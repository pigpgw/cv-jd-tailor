---
name: cv-jd-tailor
description: Generate company-tailored Korean resume and portfolio application artifacts from a JD using this repository's local DB markdown files: resume source, portfolio source, and application tracker. Use when a JD URL/text/file should produce JD analysis, update application status, and write tailored markdown/Typst/PDF artifacts from local repository sources.
---

# CV JD Tailor

## Purpose

Turn one JD into local application artifacts while keeping reusable source facts and application status in this repository.

The JD is provided at invocation time, and base resume/portfolio facts are read from local DB markdown files.

## Source of Truth

Use exactly these local DB files:

- Resume source: `db/이력서_원천.md`
- Portfolio source: `db/포트폴리오_원천.md`
- Application tracker: `db/지원회사_관리.md`
- Shared portfolio assets: `assets/portfolio/`

Do not create duplicate base-source files under company folders. Company folders may contain company-specific tailored artifacts only.

## Inputs

Provide at least one JD input:

- `jd_url`
- `jd_text`
- `jd_file`

Optional inputs:

- `company_dir`
- `analysis_path`
- `application_status`
- `role_title`
- `resume_source_path`
- `portfolio_source_path`
- `application_tracker_path`
- `output_root`
- `archive_root`

Default values:

- `resume_source_path`: `db/이력서_원천.md`
- `portfolio_source_path`: `db/포트폴리오_원천.md`
- `application_tracker_path`: `db/지원회사_관리.md`
- `output_root`: `workflow/지원전`
- `archive_root`: `workflow/지원후`
- `application_status`: `서류 준비`

Preferred invocation style:

- `[$cv-jd-tailor] <JD_URL> company_dir=<회사명> application_status=서류 준비`

## Application Status Model

Manage each company/application in `db/지원회사_관리.md` by stage.

Allowed statuses:

- `서류 준비`
- `서류 제출`
- `서류 탈락`
- `과제`
- `과제 탈락`
- `코테`
- `코테 탈락`
- `면접 1차`
- `면접 1차 탈락`
- `면접 2차`
- `면접 2차 탈락`
- `최종 합격`
- `최종 탈락`
- `보류`

The tracker must have one row per application key. The application key is:

`회사명 + 직무명 + JD URL`

If there is no JD URL, use:

`회사명 + 직무명 + JD text hash or JD file path`

Before adding a row, search the tracker for the same company, role, and JD identifier. If a matching row exists, update that row's status, latest date, and notes instead of adding a duplicate.

Do not maintain a separate change history or status log in the tracker. Manage only the current application status table.

## Artifacts

When the workflow succeeds, produce or update:

- `workflow/지원전/<company_dir>/<company_dir>_채용분석.md`
- `workflow/지원전/<company_dir>/<company_dir>_지원전략.md`
- `workflow/지원전/<company_dir>/<company_dir>_이력서_박건우.typ`
- `workflow/지원전/<company_dir>/<company_dir>_포트폴리오_박건우.typ`
- matching PDFs beside the two Typst files when Typst rendering is available

Use `workflow/지원후/<company_dir>/` only for submitted, closed, or archived application copies when the user explicitly asks to archive/move an application, or when the task is specifically a post-application status update.

If `company_dir` is omitted, derive it from the analyzer output company name.

## Workflow

### 1. Normalize the Request

- Read the JD input first.
- Resolve local DB paths and output paths.
- Do not use external base document URLs as default sources; this repository workflow uses the local DB files above.
- If `analysis_path` is provided, use it as the JD analysis source and skip fresh analysis.
- Otherwise, run `company-jd-analyzer` and request its output as `workflow/지원전/<company_dir>/<company_dir>_채용분석.md`.
- The analyzer output must use the 12-section Korean structure from `company-jd-analyzer`. If key sections are missing, fix the analysis before generating application documents.

### 2. Read Local DB Sources

Read the resume source and portfolio source before writing tailored output.

Rules:

- Treat `db/이력서_원천.md` and `db/포트폴리오_원천.md` as reusable facts, not final copy.
- Treat `assets/portfolio/` as the shared source for reusable portfolio images such as architecture diagrams, component images, screenshots, diagrams, and logos.
- Rewrite, reorder, and emphasize for JD fit.
- Do not invent facts, numbers, responsibilities, tools, or outcomes missing from the DB sources or user corrections.
- Do not invent motivation, intent, problem awareness, beliefs, or causal framing. Phrases like `~라는 문제의식으로` or `~하려는 의도로` require explicit source support from the DB or the user's latest correction.
- Do not copy whole source sections verbatim unless the user explicitly asks for a base document.

If a required DB source file is missing or empty, stop before generating tailored documents and report the missing source.

Shared asset folders:

- `assets/portfolio/architecture/`: system architecture images and architecture diagrams
- `assets/portfolio/components/`: UI/component images used across portfolio cases
- `assets/portfolio/screenshots/`: reusable product or feature screenshots
- `assets/portfolio/diagrams/`: flow, sequence, data, or process diagrams
- `assets/portfolio/logos/`: company, product, or technology logos when legally usable

When a portfolio case needs an image:

- Prefer an existing shared asset from `assets/portfolio/`.
- Record the asset path and usage context in `db/포트폴리오_원천.md`.
- Use relative paths from the generated company Typst file, usually `../../../assets/portfolio/...` from `workflow/지원전/<company_dir>/`.
- Do not duplicate the same reusable image into each company folder.
- Put company-specific, non-reusable submitted attachments in that company folder only.

### 3. Analyze or Reuse JD Interpretation

Fresh analysis is the default.

Keep `company-jd-analyzer` responsible for:

- company identification
- role and team extraction
- recent company signal verification
- labeling claims as `[명시]`, `[최근근거]`, `[추정]`, or `[확인필요]`
- writing one analysis markdown under the same `workflow/지원전/<company_dir>/` folder used for that application

The analysis brief must include these sections:

1. 공고 핵심 요약
2. 회사/서비스 개요
3. 최근 6~12개월 주요 시그널
4. JD에서 명시된 핵심 요구사항
5. JD에서 읽히는 숨은 요구사항
6. 이 회사가 원하는 사람상
7. 이력서에 강조해야 할 사인
8. 우선 배치할 경험/프로젝트
9. 지원자 입장에서의 리스크
10. 예상 면접 질문
11. 총평
12. 근거 출처 메모

If the analyzer result is `workflow/지원전/미확인회사/미확인회사_채용분석.md`, stop after updating the tracker only when the user supplied enough application identity to track it. Do not create tailored resume or portfolio artifacts.

### 3-1. Treat the Analysis as the Tailoring Contract

Before writing strategy, resume, or portfolio content, read the analyzer markdown and make the generation decisions from it.

Required alignment:

- Sections `4. JD에서 명시된 핵심 요구사항`, `5. JD에서 읽히는 숨은 요구사항`, `6. 이 회사가 원하는 사람상`, `7. 이력서에 강조해야 할 사인`, and `8. 우선 배치할 경험/프로젝트` are the primary decision source.
- The resume headline, intro, core competencies, career bullet ordering, and project selection must be explainable from those sections.
- The portfolio case order and case emphasis must be explainable from those sections.
- If a source experience is strong in the DB but weak for the JD analysis, downplay or omit it instead of forcing it into the final document.
- If the analysis has `[확인필요]` or weak evidence, do not turn it into a confident resume claim.
- If the analysis and local DB conflict, stop and resolve the conflict against the DB and the user's latest correction before generating final Typst.

### 4. Update Application Tracker

Open `db/지원회사_관리.md` and update the application table.

Required tracker fields:

- 회사명
- 직무명
- JD 식별자
- 전형 상태
- 최근 변경일
- 지원전 폴더
- 분석 파일
- 메모

Rules:

- Do not add duplicate rows for the same application key.
- If status changes, update only the current row. Do not add a separate change history entry.
- If the row exists and only analysis or output paths changed, update those cells.
- Keep statuses in the allowed list. If the user gives another status, preserve it in notes and choose the closest allowed status.

### 5. Write Strategy Markdown

Create or update:

`workflow/지원전/<company_dir>/<company_dir>_지원전략.md`

Use these top-level sections:

1. `# JD 매칭 요약`
2. `# 맞춤 이력서`
3. `# 맞춤 포트폴리오`
4. `# 조정 메모`
5. `# 지원회사 관리 메모`

Inside `# JD 매칭 요약`, include:

- JD 핵심 키워드와 원천 경험 매핑 테이블
- `[명시]`, `[최근근거]`, `[추정]`, `[확인필요]` 라벨 유지
- 직접 매칭, 축소 반영, 미커버 리스크 구분
- why each selected resume/portfolio item belongs in the final output
- which attractive DB items were intentionally excluded because the analysis does not support them strongly enough

Inside `# 맞춤 이력서`, include:

- 상단 지원동기 방향
- 자기소개 방향
- 핵심 역량
- 경력
- 프로젝트
- 제외하거나 축소할 근거

Inside `# 맞춤 포트폴리오`, include:

- 첫 문단 방향
- 프로젝트 순서
- 각 프로젝트의 문제 -> 해결 -> 결과
- JD와 직접 연결되는 증거

Inside `# 지원회사 관리 메모`, include:

- 전형 상태
- JD 식별자
- 추후 상태 변경 시 남길 메모 기준

Inside `# 조정 메모`, include:

- 이 JD에서 특히 강한 카드 3개
- 축소하거나 제거한 요소와 이유
- 최종 문서에서 확인해야 할 리스크

### 6. Generate Tailored Files

Create or update:

- `workflow/지원전/<company_dir>/<company_dir>_이력서_박건우.typ`
- `workflow/지원전/<company_dir>/<company_dir>_포트폴리오_박건우.typ`

Use existing templates or nearby output patterns only when they exist in the repository. If templates are unavailable, create Typst files with conservative structure and clearly report that the base template was unavailable.

Template selection order:

1. `templates/public/resume.typ` and `templates/public/portfolio.typ` when both exist
2. `workflow/지원전/_shared_application.typ` plus `workflow/지원전/_fixed_portfolio_cases.typ` when available
3. the most recent company folder under `workflow/지원전` that has both resume and portfolio Typst files
4. conservative standalone Typst files as a last resort, with a clear blocker/risk note

Generation rules:

- Keep company-specific tailoring in the company folder.
- Keep reusable career facts only in `db/이력서_원천.md` and `db/포트폴리오_원천.md`.
- In resumes, company work performed during employment must stay under the career section. Do not duplicate LG 공통업무 플랫폼, 프비티, or other employer work under the standalone project section.
- When one employment entry contains multiple products, projects, or workstreams, split them inside the career entry with small subheadings instead of mixing all bullets in one flat list. Keep them under `경력`, not under the standalone project section.
- For 디지엠유닛원, use only two employment project headings: `프비티` and `LG 공통업무 플랫폼`. Do not create `AI Native 워크플로우` as a standalone project or case; fold AI Native process evidence into the relevant actual project, usually `프비티`.
- In resumes, the standalone project section is for non-employment work only, such as personal projects, education projects, research, or capstone work.
- For the 디지엠유닛원 career role label, adapt the role to the JD: use `Frontend Engineer` for frontend JDs, and `Software Engineer` for fullstack, AI Native, AX, AI service, PI, or Builder-oriented JDs. This rule applies only to the 디지엠유닛원 employment entry. Keep 크래프톤 정글 Code Sync as `Frontend Developer` because it is a frontend education project.
- Education and activity entries should appear only when they help the current JD. Keep each entry to at most two bullets; if the JD fit is weak, use a short subtitle only or omit the entry.
- Awards should list actual awards only. Do not place "selected project", homepage listing, or internal showcase results under awards unless the source clearly treats them as an award.
- Links should be attached to meaningful text, such as the project name, award name, official page label, or `[GitHub]`; do not append raw-looking links at sentence ends.
- When the user corrects a fact, update the relevant local DB source as well as the generated company artifact unless the user explicitly asks for a one-off artifact-only edit.
- Avoid duplicating the same source paragraph across multiple company artifacts without JD-specific rewriting.
- Avoid resume bullets that only restate the intro, subtitle, or responsibility scope. A career bullet should have a concrete problem, meaningful action, and outcome/metric/domain impact. If an item only says that a feature was improved or feedback was reflected without a result, keep it in the intro/subtitle/context or omit it.
- Prefer concrete problem names, actions, and verifiable outcomes over generic self-praise.
- Do not inflate scope or merge unrelated facts into a new causal story.

### 7. Render PDFs When Possible

Run `typst compile` for both Typst files and write PDFs beside them.

If Typst or a template dependency is unavailable:

- keep the `.typ` output
- report the blocker directly
- do not claim PDF generation succeeded

### 8. Report Completion

At the end, report:

- JD analysis path used
- tracker path updated
- strategy markdown path
- resume Typst/PDF paths
- portfolio Typst/PDF paths
- verification commands run
- remaining blockers or missing source files

## Failure Rules

- Do not generate tailored documents when company identification is unresolved and the user did not provide enough identity to name the application.
- Do not invent facts, numbers, roles, tools, or outcomes.
- Do not write tailored results back into external document stores unless the user explicitly asks.
- Do not create duplicate application tracker rows.
- Do not create new base-source markdown files outside `db/이력서_원천.md`, `db/포트폴리오_원천.md`, and `db/지원회사_관리.md` unless the user explicitly asks.

## Validation

Before claiming success, verify:

- `db/이력서_원천.md` exists
- `db/포트폴리오_원천.md` exists
- `db/지원회사_관리.md` exists
- `assets/portfolio/` exists when portfolio images are referenced
- the analyzer markdown exists or a provided `analysis_path` exists
- the analyzer markdown has the required 12 sections
- the tracker has no duplicate row for the same application key
- the strategy markdown exists
- both Typst files exist when generation was requested
- both PDFs exist only if `typst compile` succeeded
- final resume/portfolio choices are traceable to analyzer sections 4-8
- generated resume does not duplicate employer work under the standalone project section
- education/activity entries are JD-relevant and have at most two bullets each
- any user fact corrections made during the turn were also reflected in the relevant `db/` source file

If any validation step fails, report the exact missing item and stop short of claiming the full workflow succeeded.
