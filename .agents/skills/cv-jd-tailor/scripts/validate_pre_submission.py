#!/usr/bin/env python3
"""Audit pre-submission resume artifacts for completeness and text contamination.

This is a mechanical gate, not a factuality or semantic-JD reviewer. It enforces
explicit claim exclusions recorded in each strategy, but every remaining claim
and checklist-to-resume mapping still requires human review.
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

try:
    from pypdf import PdfReader
except ImportError:  # pragma: no cover - depends on local PDF runtime
    PdfReader = None


KANA = re.compile(r"[\u3040-\u30ff]")
BAD_TEXT = re.compile(r"[\ufffd\u0000]")
ROOT = Path(__file__).resolve().parents[4]


def read_pdf(path: Path) -> str:
    if PdfReader is None:
        raise RuntimeError("pypdf is required to extract final PDF text")
    return "\n".join(page.extract_text() or "" for page in PdfReader(str(path)).pages)


def normalize_for_crosswalk(value: str) -> str:
    value = re.sub(r"[`*_#]", "", value)
    return re.sub(r"[^0-9A-Za-z가-힣]", "", value)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=ROOT / "workflow/지원전")
    parser.add_argument("--include-closed", action="store_true")
    parser.add_argument("--require-pdf", action="store_true")
    args = parser.parse_args()

    if (args.root / "박건우_이력서.typ").is_file():
        folders = [args.root]
    else:
        folders = sorted(p for p in args.root.iterdir() if p.is_dir() and (args.include_closed or p.name != "_마감"))
    if not folders:
        print(f"ERROR no application folders: {args.root}")
        return 2

    errors: list[str] = []
    warnings: list[str] = []
    shared_portfolio = ROOT / "assets/portfolio/박건우_포트폴리오.pdf"
    if not shared_portfolio.is_file():
        errors.append(f"missing shared portfolio attachment: {shared_portfolio}")
    for folder in folders:
        typ = folder / "박건우_이력서.typ"
        strategy = folder / f"{folder.name}_지원전략.md"
        pdf = folder / "박건우_이력서.pdf"
        analysis = folder / f"{folder.name}_채용분석.md"
        intro_typ = folder / "박건우_자기소개서.typ"
        intro_pdf = folder / "박건우_자기소개서.pdf"
        for needed in (typ, strategy):
            if not needed.is_file():
                errors.append(f"{folder.name}: missing {needed.name}")
        if not typ.is_file():
            continue
        if not analysis.is_file():
            errors.append(f"{folder.name}: missing {analysis.name}")
        else:
            analysis_text = analysis.read_text(encoding="utf-8")
            missing_sections = [str(i) for i in range(1, 13) if f"## {i}." not in analysis_text]
            if missing_sections:
                errors.append(f"{folder.name}: analysis missing sections {','.join(missing_sections)}")
        source = typ.read_text(encoding="utf-8")
        if BAD_TEXT.search(source):
            errors.append(f"{folder.name}: replacement/NUL character in Typst")
        hits = sorted(set(KANA.findall(source)))
        if hits:
            errors.append(f"{folder.name}: Japanese kana in Typst: {''.join(hits)}")
        if args.require_pdf and not pdf.is_file():
            errors.append(f"{folder.name}: missing {pdf.name}")
        if pdf.is_file():
            try:
                rendered = read_pdf(pdf)
            except Exception as exc:  # report all affected files in one run
                errors.append(f"{folder.name}: PDF extraction failed: {exc}")
                continue
            if BAD_TEXT.search(rendered):
                errors.append(f"{folder.name}: replacement/NUL character in PDF text")
            pdf_hits = sorted(set(KANA.findall(rendered)))
            if pdf_hits:
                errors.append(f"{folder.name}: Japanese kana in PDF text: {''.join(pdf_hits)}")
            if len(rendered.strip()) < 100:
                errors.append(f"{folder.name}: extracted PDF text is unexpectedly short")
        if intro_typ.is_file():
            intro_source = intro_typ.read_text(encoding="utf-8")
            if BAD_TEXT.search(intro_source):
                errors.append(f"{folder.name}: replacement/NUL character in self-introduction Typst")
            intro_hits = sorted(set(KANA.findall(intro_source)))
            if intro_hits:
                errors.append(f"{folder.name}: Japanese kana in self-introduction Typst: {''.join(intro_hits)}")
            if args.require_pdf and not intro_pdf.is_file():
                errors.append(f"{folder.name}: missing {intro_pdf.name} for existing self-introduction Typst")
            if intro_pdf.is_file():
                try:
                    intro_text = read_pdf(intro_pdf)
                except Exception as exc:
                    errors.append(f"{folder.name}: self-introduction PDF extraction failed: {exc}")
                else:
                    if BAD_TEXT.search(intro_text):
                        errors.append(f"{folder.name}: replacement/NUL character in self-introduction PDF text")
                    if KANA.search(intro_text):
                        errors.append(f"{folder.name}: Japanese kana in self-introduction PDF text")
                    if len(intro_text.strip()) < 100:
                        errors.append(f"{folder.name}: self-introduction PDF text is unexpectedly short")
        if strategy.is_file():
            text = strategy.read_text(encoding="utf-8")
            boundary_match = re.search(
                r"^## 사실·역할 경계\s*$([\s\S]*?)(?=^## |\Z)", text, flags=re.MULTILINE
            )
            if not boundary_match:
                errors.append(f"{folder.name}: strategy missing 사실·역할 경계")
            else:
                boundary = boundary_match.group(1)
                forbidden = re.findall(r"금지 문구:\s*`?([^`\n;|]+)", boundary)
                scan_texts = [("resume Typst", source)]
                if pdf.is_file():
                    scan_texts.append(("resume PDF", rendered))
                if intro_typ.is_file():
                    scan_texts.append(("self-introduction Typst", intro_source))
                if intro_pdf.is_file():
                    try:
                        scan_texts.append(("self-introduction PDF", read_pdf(intro_pdf)))
                    except Exception:
                        pass
                for phrase in forbidden:
                    needle = normalize_for_crosswalk(phrase.strip().strip("*- "))
                    if not needle:
                        continue
                    for label, body in scan_texts:
                        if needle in normalize_for_crosswalk(body):
                            errors.append(f"{folder.name}: forbidden phrase in {label}: {phrase.strip()[:70]}")
            if "JD 원문 원자 체크리스트" not in text:
                errors.append(f"{folder.name}: missing JD 원문 원자 체크리스트")
            has_exact_crosswalk = "JD별 직접 대조 문구 (전면 재생성본)" in text and "최종 이력서 문구" in text
            if not has_exact_crosswalk:
                errors.append(f"{folder.name}: strategy lacks exact current-resume wording crosswalk")
            if "## 제출 파일 구분" not in text or "assets/portfolio/박건우_포트폴리오.pdf" not in text:
                errors.append(f"{folder.name}: strategy lacks resume/shared-portfolio/self-introduction file distinction")
            if has_exact_crosswalk and pdf.is_file():
                pdf_text = normalize_for_crosswalk(read_pdf(pdf))
                block = text.split("## JD별 직접 대조 문구 (전면 재생성본)", 1)[1].split("\n## ", 1)[0]
                for row in block.splitlines():
                    if not row.startswith("|") or "---" in row or "최종 이력서 문구" in row or "첫 페이지 근거" in row:
                        continue
                    cells = [cell.strip() for cell in row.strip("|").split("|")]
                    if len(cells) < 2:
                        continue
                    excerpt = normalize_for_crosswalk(cells[1])
                    if len(excerpt) >= 24 and excerpt[:32] not in pdf_text:
                        errors.append(f"{folder.name}: crosswalk excerpt not found in extracted resume PDF: {cells[1][:70]}")

    print(f"Applications scanned: {len(folders)}")
    print(f"Errors: {len(errors)} | Review warnings: {len(warnings)}")
    for item in errors:
        print(f"ERROR {item}")
    for item in warnings:
        print(f"REVIEW {item}")
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main())
