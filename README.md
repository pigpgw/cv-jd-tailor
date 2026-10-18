# 박건우 이력서·포트폴리오 작업 공간

실제 기준 폴더는 `cv-jd-tailor`입니다. 바탕화면 `이력서`에는 이동 안내 파일만 남겼습니다. 자료는 이 폴더에 통합되어 있습니다.

| 자료 | 위치 |
|---|---|
| 최신 공용 포트폴리오 PDF | [PDF](assets/portfolio/박건우_포트폴리오.pdf) |
| 수정할 Typst 원본 | [main.typ](assets/portfolio/main.typ) |
| 원본 이미지 8개·한글 글꼴 | `assets/portfolio/images/`, `assets/portfolio/fonts/` |
| typst.app 업로드용 ZIP | `assets/portfolio/exports/박건우_포트폴리오_Typst_원본.zip` |
| 최신 공용 이력서 PDF | [PDF](assets/resume/박건우_이력서.pdf) |
| 크래프톤 현재 지원 준비 | [폴더](workflow/지원전/크래프톤_pioneer_tech/) |
| 기존 이력서 보관본 | `assets/resume/original/` |
| 편집 가능한 아키텍처 자료 | `assets/portfolio/architecture/` |
| 테라다인 지원·면접·코딩 준비 | `workflow/지원후/teradyne_application/` |
| JD별 지원 준비 / 제출 보관본 | `workflow/지원전/`, `workflow/지원후/` |
| 경력 원천 fallback | `db/` |
| 공용 템플릿 | `templates/public/` |

포트폴리오는 소개와 기술 사례 7개를 담은 10페이지입니다. Code Sync는 코드·이미지를 포함한 2페이지로 구성했습니다. 2026-10-18 Notion 최신 사실 원장과 대조해 소속·기간·개인 기여·측정 범위를 보완했으며 기존 이미지 8개에 Code Sync 실제 리뷰 화면을 추가했습니다. 상세 점검 기록은 `assets/portfolio/README.md`에 있습니다.

`db/`, `workflow/`, `assets/`는 로컬 전용입니다. Git에는 공용 지침과 템플릿만 관리합니다.

## 포트폴리오 다시 생성

```sh
cd assets/portfolio
typst compile --font-path fonts main.typ 박건우_포트폴리오.pdf
```

임시 렌더 이미지, 중복 추출 이미지 폴더와 중복 이미지 ZIP은 제거했습니다. 이전 포트폴리오 PDF 두 개는 삭제했고, 현재 Typst PDF와 편집 원본을 유지합니다. 이력서·지원 문서·녹음·영상·코딩 기록은 보존했습니다.


## Figma 원천 자료와 직무별 구성

- [이미지·프레임 목록](assets/index.html)
- [직무별 이력서·포트폴리오 구성 기준](assets/직무별_구성기준.md)
- [Code Sync 원문](assets/code-sync/Figma_원문.md): 크래프톤 정글 최종 팀 프로젝트.
- [디지엠유닛원 원문](assets/dgm-unitone/Figma_원문.md): 프비티·CPPM 재직 업무.
- [공통 이력서 초안과 전체 원본](assets/common/Figma_원문.md): 여러 경험이 섞인 프레임, 전체 캔버스 PNG/SVG와 원본 JSON.

Figma 파일 한 페이지의 전체 노드 427개, 텍스트 244개, 참조된 원본 이미지 18개와 주요 프레임 8개를 보존했습니다. 이미지는 Code Sync 9개·디지엠유닛원 8개·공통 아이콘 1개로 분류했고, 이미지 해시를 원본 참조와 대조했습니다. 외부 저장소·동영상 전체와 미참조 이미지 캐시는 복제하지 않았습니다. `.fig` 편집 파일의 로컬 사본을 생성한 것은 아니며 전체 REST JSON·PNG·SVG를 보관했습니다.

Figma 원문에 남은 과거 표현·측정값은 보존하되, 제출 문장은 Notion 최신 사실과 JD를 기준으로 다시 작성합니다. 프론트엔드·풀스택·AI/AX는 같은 경험 원천을 참조하는 구성 기준이며, 직무별 최종 제출본을 이번에 별도로 생성한 것은 아닙니다.

## 2026-10-18 최신본 정리

현재 공용 PDF는 assets/portfolio/박건우_포트폴리오.pdf와 assets/resume/박건우_이력서.pdf입니다. 포트폴리오는 경력·교육 프로젝트 구분과 핵심 볼드 강조를 반영했고 서비스 분리 사례는 제외했습니다. assets/resume/original은 이전 원본입니다. workflow/지원후와 Figma·이미지·도식 원천은 유지했습니다. 구버전 포트폴리오 생성물은 휴지통으로 이동했습니다.
