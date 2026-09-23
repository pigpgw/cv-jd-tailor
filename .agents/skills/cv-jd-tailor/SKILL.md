---
name: cv-jd-tailor
description: Generate company-tailored Korean resume and portfolio application artifacts from a JD using the user's Notion Developer page as the primary resume/portfolio source. Read Notion through Composio first, then write JD-specific artifacts from verified source facts.
---

# CV JD Tailor

## Purpose

Turn one JD into local application artifacts while keeping reusable source facts grounded in the user's Notion Developer page and using the pre-submission/submitted folder boundary defined by the project instructions.

The JD is provided at invocation time. Read the JD through a suitable read-only MCP tool first, with browser reading only as its fallback. Read base resume/portfolio facts from the user's Notion Developer page through the connected Notion account in Composio.

## Boundary With AGENTS.md

- `AGENTS.md` owns repository-wide source precedence, safety boundaries, archive immutability, file placement, and minimum validation.
- This skill owns only JD analysis, evidence selection, resume/portfolio composition, application-specific artifact generation, and tailoring QA. Do not duplicate or redefine repository-wide policy here.
- Before generating, apply the evidence gate: map every selected claim to Notion, a user's latest correction, or verified code/README/execution evidence. A user request cannot turn an unsupported fact, metric, role, or causal link into a submitted claim; narrow, label, or exclude it and record the reason in strategy notes.
- After generating, run a contradiction and leakage check: compare selected projects, roles, dates, metrics, technologies, and outcomes against the source, and verify that no rejected or unverified claim entered the final artifact. Do not report completion until this check passes.
- Never write a claim that the source cannot support, even when it sounds plausible or would make the resume stronger. Remove true-but-unnecessary content when it does not directly prove a responsibility, qualification, preferred qualification, or the one verified AI-development workflow exception for the current JD. Do not fill space with generic self-praise, tool inventories, biography, or unrelated work history.
- Apply the storytelling rule to every tailored experience sentence, not only one featured bullet: `context/user problem or constraint -> candidate-owned reasoning/decision -> technical action or collaboration -> verified result or concrete deliverable`. Use only source-backed context and causality; when a metric is unavailable, end with a verifiable user-facing change, handled edge case, or completed artifact rather than inventing impact.

## Source of Truth

For the reusable project evidence schema and code-review procedure, read [references/project-evidence-schema.md](references/project-evidence-schema.md) whenever a project is being newly documented, a repository is being inspected, or project selection is being redesigned.

Use these sources in order:

- Primary resume/portfolio source: Notion `박건우 | Developer`
  - URL: `https://confused-dietician-c17.notion.site/Developer-3c77caa087bd80ff9d73f63aeeebb4d7?pvs=74`
- Local resume snapshot, fallback only: `db/이력서_원천.md`
- Local portfolio snapshot, fallback only: `db/포트폴리오_원천.md`
- Shared portfolio assets: `assets/portfolio/`

Do not treat the local snapshot markdown files as newer than Notion unless the user explicitly says they corrected those files after the Notion page. Do not create duplicate base-source files under company folders. Company folders may contain company-specific tailored artifacts only.

Source conflict order is explicit: the user's latest factual correction takes precedence over the Notion page, the Notion page takes precedence over local fallback snapshots, and local snapshots are used only when Notion is unavailable. More specific rules later in this skill may refine the JD-relevance filter, but never override the evidence gate.

### Source retrieval routes and token budget

#### JD / public job-posting route

- Read the supplied JD URL with the smallest suitable read-only MCP tool first. Prefer a direct page/Markdown extraction tool when one is available; do not guess an unavailable tool name.
- Validate that the returned text includes responsibilities, qualifications, preferences, submission instructions, and application conditions. If the MCP result is inaccessible, empty, truncated, or misses page content rendered only in the browser, read the supplied URL through browser automation.
- Use browser reading only for the JD fallback. Preserve the full JD text long enough to create the `JD 원문 원자 체크리스트`; do not use Composio as the JD reader merely because the URL is a public Notion page.

#### Personal Notion Developer source route

- Read only the user's Notion Developer source through Composio. Discover the exact Notion tools through `COMPOSIO_SEARCH_TOOLS`, confirm that the `notion` connection is active, then use the smallest suitable read operation.
- When the Developer page ID is known, call `NOTION_GET_PAGE_MARKDOWN` first. It returns readable content in one request and avoids browser accessibility/screenshot tokens and recursive block traversal.
- Fetch metadata or recursive blocks only when the Markdown result is empty, truncated, contains unknown-block placeholders, or a needed linked child page/table is absent. Do not prefetch an entire workspace, database, media, or block tree.
- Build a child-page coverage manifest before selecting evidence: identify every linked child page, project page, or database record referenced by the Developer page that could support a JD-matched experience. Read the narrow linked source for every experience retained in the tailored resume, even when the parent Markdown has a short summary. For an unselected child page, record the JD-mismatch reason rather than treating its parent-page summary as complete evidence. This is a targeted child-page pass, not a recursive workspace dump.
- If Composio reports no active Notion connection or the Developer page is inaccessible, report that directly. Do not fall back to browser automation for this personal source; the local snapshots remain fallback only under the existing source-precedence rule and must be reported as stale-source fallback.
- Keep only the facts needed for the current JD in working context: extract a compact evidence table (`project/role/period/verified scope/metric or deliverable/JD match`) from the retrieved Markdown, then use that table for composition. For every time, count, rate, or Before→After metric, add a measurement card: `measured request or workflow / baseline / changed implementation details / after / measurement scope or caveat`. Do not paste or retain the full Notion page in generated artifacts.

## Inputs

Provide at least one JD input:

- `jd_url`
- `jd_text`
- `jd_file`

Optional inputs:

- `application_dir`
- `analysis_path`
- `role_title`
- `notion_source_url`
- `resume_snapshot_path`
- `portfolio_snapshot_path`
- `existing_portfolio_pdf`
- `output_root`
- `archive_root`

Default values:

- `notion_source_url`: `https://confused-dietician-c17.notion.site/Developer-3c77caa087bd80ff9d73f63aeeebb4d7?pvs=74`
- `resume_snapshot_path`: `db/이력서_원천.md`
- `portfolio_snapshot_path`: `db/포트폴리오_원천.md`
- `existing_portfolio_pdf`: `박건우_포트폴리오.pdf` when available from the current workspace or a user-supplied path
- `output_root`: `workflow/지원전`
- `archive_root`: `workflow/지원후`

Preferred invocation style:

- `[$cv-jd-tailor] <JD_URL> application_dir=<회사명>_<JD식별자>`

## Artifacts

When the workflow succeeds, produce or update:

- `workflow/지원전/<application_dir>/<application_dir>_채용분석.md`
- `workflow/지원전/<application_dir>/<application_dir>_지원전략.md`
- `workflow/지원전/<application_dir>/박건우_이력서.typ`
- `workflow/지원전/<application_dir>/<application_dir>_포트폴리오_후보.md` only when the JD explicitly asks for AI-usage evidence or the user explicitly requests a tailored AI-usage portfolio
- matching resume PDF beside the Typst file when Typst rendering is available

Resume filename rule:

- `application_dir` is the management boundary for company/JD identity; do not repeat that identity in the submit-ready resume filename.
- Always name the submit-ready resume files `박건우_이력서.typ` and `박건우_이력서.pdf` inside the company-specific folder.
- Keep analysis and strategy filenames company-specific for local traceability, but never generate or report a resume file named like `<application_dir>_이력서_박건우.pdf` as the final submission file.

Use `workflow/지원후/<application_dir>/` as the immutable snapshot of files submitted at that time. Never edit, regenerate, overwrite, or delete anything under `workflow/지원후/` after submission, including when the source DB, skill rules, or `workflow/지원전/` are corrected. The existence of a submitted application folder is the application-status signal; do not create or update a separate application-tracker document. All content corrections belong in the source DB, shared instructions, or `workflow/지원전/`. A later application must create a new pre-submission artifact rather than changing the archived copy.

Derive `application_dir` as `{company_name}_{jd_identifier}`. Prefer the official posting ID, a unique ID in the source URL, or a user-provided identifier. If no identifier exists, use a short normalized role slug as the suffix; do not append a random hash. Reuse an existing directory for the same company and JD instead of creating a duplicate.

## Workflow

### 1. Normalize the Request

- Read the JD input first through the JD / public job-posting route above. Record `MCP direct read` or `browser fallback read` in the strategy source note.
- Resolve the Notion source URL, local fallback snapshot paths, and output paths.
- Use the Notion Developer page as the default base resume/portfolio source. Do not silently substitute local markdown snapshots when Notion access is available.
- If `analysis_path` is provided, use it as the JD analysis source and skip fresh analysis.
- Otherwise, run `company-jd-analyzer` and request its output as `workflow/지원전/<application_dir>/<application_dir>_채용분석.md`.
- The analyzer output must use the 12-section Korean structure from `company-jd-analyzer`. If key sections are missing, fix the analysis before generating application documents.

### 2. Read Notion Source

Fetch or otherwise verify the Notion Developer page through Composio before writing tailored output. Use `NOTION_GET_PAGE_MARKDOWN` for the known Developer page ID as the first read, and inspect nested blocks only if the Markdown completeness checks require it. Record `Composio Notion direct read`, `Composio narrow search`, or `local fallback` in the strategy source note.

Rules:

- Treat the Notion Developer page as reusable facts, not final copy.
- Before composing, complete a source-completeness pass for every selected experience from both the Developer page and its relevant linked child page: capture the exact organization, role, employment period, project period, project context, stack, candidate-owned work, technical decision, validation/result, and source caveat. Do not draft from an earlier summary or a partial first-screen preview. Preserve exact source dates in the resume when known; if only an employment period is known, label it as the employment period or `재직 중 수행` rather than inventing a project start/end date.
- Include a technology, tool, or experience in the submitted artifact only when the JD explicitly requires or prefers it, or when it is a direct analogous capability that explains one of those requirements. Do not add merely related technologies just because they appear in the source.
- Use `db/이력서_원천.md` and `db/포트폴리오_원천.md` only as fallback snapshots when Notion cannot be accessed, or as supporting indexes for locating shared assets.
- If Notion and local snapshots conflict, use Notion unless the user's latest correction explicitly says otherwise.
- Treat `assets/portfolio/` as the shared source for reusable portfolio images such as architecture diagrams, component images, screenshots, diagrams, and logos.
- Rewrite, reorder, and emphasize for JD fit.
- Do not invent facts, numbers, responsibilities, tools, or outcomes missing from the Notion source or user corrections.
- Do not blur multiple experiences into one claim. Never combine separate projects, education assignments, tool usage, or company work so they appear to be one implementation, one causal result, or one job responsibility. A bullet may connect only problem-action-result facts that happened in the same verified context; otherwise split them into separate bullets or keep the weaker item in strategy notes.
- Never confuse what the candidate personally did with what a library, framework, or cloud service provides by default. Use `used`, `integrated`, `configured`, `connected to the UI`, `handled state`, `handled exceptions`, or `verified` when the candidate used an existing capability; reserve `implemented`, `designed`, or `improved` for source-backed code, UX, API contract, data flow, or validation work done by the candidate.
- Do not present team-wide work, framework default behavior, managed-service built-in features, or library internals as personal implementation. When uncertain, write the narrower verified scope or keep the point in the strategy risk notes instead of the submitted artifact.
- Do not confuse developing a product that contains a business domain with directly performing that domain's operations. For example, developing a franchise platform with CRM marketing features is valid; claiming direct advertising/marketing operations ownership or improvement is not.
- When using adjacent domain experience, narrow the wording to the actual contact point and personal work, such as implementing user screens and API flows for a platform that includes CRM marketing features.
- Do not invent motivation, intent, problem awareness, beliefs, or causal framing. Phrases like `~라는 문제의식으로` or `~하려는 의도로` require explicit source support from Notion or the user's latest correction.
- Do not copy whole source sections verbatim unless the user explicitly asks for a base document.

If the Notion source cannot be accessed through Composio, report the connection or access failure directly. Use local snapshot markdown only if the user allows fallback or if the current task can proceed with an explicit stale-source warning; do not switch to browser automation for the personal source.

Shared asset folders:

- `assets/portfolio/architecture/`: system architecture images and architecture diagrams
- `assets/portfolio/components/`: UI/component images used across portfolio cases
- `assets/portfolio/screenshots/`: reusable product or feature screenshots
- `assets/portfolio/diagrams/`: flow, sequence, data, or process diagrams
- `assets/portfolio/logos/`: company, product, or technology logos when legally usable

When a portfolio case needs an image:

- Prefer an existing shared asset from `assets/portfolio/`.
- Record reusable asset path decisions in Notion when the user asks to update the source; otherwise mention them in the strategy document.
- Use relative paths from the generated application Typst file, usually `../../../assets/portfolio/...` from `workflow/지원전/<application_dir>/`.
- Do not duplicate the same reusable image into each company folder.
- Put company-specific, non-reusable submitted attachments in that company folder only.

### 3. Analyze or Reuse JD Interpretation

Fresh analysis is the default.

Keep `company-jd-analyzer` responsible for:

- company identification
- role and team extraction
- recent company signal verification
- labeling claims as `[명시]`, `[최근근거]`, `[추정]`, or `[확인필요]`
- writing one analysis markdown under the same `workflow/지원전/<application_dir>/` folder used for that application

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

If the analyzer result is `workflow/지원전/미확인회사_미확인JD/미확인회사_미확인JD_채용분석.md`, stop without creating tailored resume or portfolio artifacts until the company and JD are identified.

### 3-1. Treat the Analysis as the Tailoring Contract

Before writing strategy, resume, or portfolio content, read the analyzer markdown and make the generation decisions from it.

Required alignment:

- Sections `4. JD에서 명시된 핵심 요구사항`, `5. JD에서 읽히는 숨은 요구사항`, `6. 이 회사가 원하는 사람상`, `7. 이력서에 강조해야 할 사인`, and `8. 우선 배치할 경험/프로젝트` are the primary decision source.
- The resume headline, intro, core competencies, career bullet ordering, and project selection must be explainable from those sections.
- The portfolio case order and case emphasis must be explainable from those sections.
- If a source experience is strong in Notion but weak for the JD analysis, downplay or omit it instead of forcing it into the final document.
- If the analysis has `[확인필요]` or weak evidence, do not turn it into a confident resume claim.
- If the analysis and source facts conflict, stop and resolve the conflict against Notion and the user's latest correction before generating final Typst.
- Do not reduce the JD to a handful of generic keywords. Split every concrete JD phrase into the `JD 원문 원자 체크리스트` before writing the resume.
- Every checklist row with direct evidence must appear in a natural resume bullet using the JD's wording where truthful. Adjacent evidence must be clearly narrowed to the verified contact point. No-evidence items must be excluded from submitted claims and recorded only as a strategy risk.
- Treat the full JD text as the contract, not the analyzer summary. Before writing or updating the resume, create a `JD 원문 원자 체크리스트` in the strategy document that preserves every concrete phrase from responsibilities, qualifications, preferred qualifications, submission notes, work conditions that affect fit, and company facts that matter to motivation. Each row must end in exactly one state: `직접 반영`, `축소 반영`, `전략 리스크`, or `제출 제외`.
- For every `직접 반영` or `축소 반영` row, record the exact final resume section and the resume wording that handles it. If there is no resume location, the artifact is not ready.
- For every `전략 리스크` or `제출 제외` row, record why it is not used, such as `직접 근거 없음`, `지원서에 쓰면 과장`, `제출 문서 우선순위 낮음`, or `면접 대비로만 보관`.
- If the user later pastes additional JD text, translated JD text, official job-page content, application-form instructions, or asks whether all content is included, rerun this full checklist against the new text. Do not answer from the existing analysis alone, and do not claim completion until the strategy and resume have been updated or each omitted item has a recorded reason.
- Reproduce omissions before fixing when the user reports missing JD content: compare the current resume and strategy against the original JD phrases, write the missing rows and root cause into an application-folder note named `<application_dir>_누락재현_원인분석.md`, then patch the skill or AGENTS rule that allowed the miss. This note is allowed when the user explicitly asks for root-cause recording.

### 4. Write Strategy Markdown

Create or update:

`workflow/지원전/<application_dir>/<application_dir>_지원전략.md`

Use these top-level sections:

1. `# JD 매칭 요약`
2. `# 맞춤 이력서`
3. `# 포트폴리오 제출 메모`
4. `# 조정 메모`
5. `# 제출 파일 메모`

Inside `# JD 매칭 요약`, include:

- JD 핵심 키워드와 원천 경험 매핑 테이블
- `JD 원문 원자 체크리스트` table with one row per concrete responsibility, qualification, preferred qualification, submission note, and company/motivation fact that should affect tailoring
- a `Notion 원천·하위 페이지 확인` table that records each retained experience, the parent/child source read, and the source-backed facts used in its submitted bullet
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

Inside `# 포트폴리오 제출 메모`, record whether the JD asks for a general portfolio or explicitly asks for AI-usage evidence. For a general portfolio request, point to the user's separately managed existing PDF and do not generate a company-specific general portfolio. Only when the JD explicitly asks for AI-usage evidence, or the user explicitly requests it in the current task, create a tailored AI-usage portfolio candidate list and PDF/Typst covering verified AI workflows, prompts, Skills, Agent MD, verification, and harness improvement.

Inside `# 제출 파일 메모`, include the final resume and portfolio paths and whether the company folder is pre-submission or submitted. The final resume paths must use the fixed submit-ready filenames `workflow/지원전/<application_dir>/박건우_이력서.typ` and, when compiled, `workflow/지원전/<application_dir>/박건우_이력서.pdf`.

Inside `# 조정 메모`, include:

- 이 JD에서 특히 강한 카드 3개
- 축소하거나 제거한 요소와 이유
- 최종 문서에서 확인해야 할 리스크

### 6. Generate Tailored Files

Create or update:

- `workflow/지원전/<application_dir>/박건우_이력서.typ`
- `workflow/지원전/<application_dir>/<application_dir>_포트폴리오_박건우.typ` only when the JD explicitly requires AI-usage evidence or the user explicitly requests a tailored AI-usage portfolio; never generate a general tailored portfolio by default

Use existing templates or nearby output patterns only when they exist in the repository. If templates are unavailable, create Typst files with conservative structure and clearly report that the base template was unavailable.

Template selection order:

1. `templates/public/resume.typ` and `templates/public/portfolio.typ` when both exist
2. `workflow/지원전/_shared_application.typ` plus `workflow/지원전/_fixed_portfolio_cases.typ` when available
3. the most recent company folder under `workflow/지원전` that has both resume and AI-usage portfolio Typst files, only when an AI-usage portfolio is being generated
4. conservative standalone Typst files as a last resort, with a clear blocker/risk note

Generation rules:

- ### 생각등대 판단 기준 (이 절의 다른 일반 규칙보다 우선)

- **직무 적합성**: 경험·기술·불릿은 공고의 담당업무, 기술스택, 자격요건, 우대사항 중 하나를 직접 증명할 때만 유지한다. 프론트엔드 공고에는 프론트엔드 사용자 흐름·상태·성능 근거를, 풀스택 공고에는 화면부터 API·데이터·배포까지 연결된 근거를 선택한다. 단, 사용자가 요구하거나 일반 이력서에 필요한 학력·병역·수상·자격·어학 같은 사실 프로필은 짧고 독립된 행으로만 남기며 기술 역량의 증거처럼 부풀리지 않는다.
- **사실과 필요성**: `저는 ~한 사람입니다`, 추상적 강점, 희망, 기술 목록, 빈 페이지를 채우는 문장을 쓰지 않는다. 모든 문장은 원천으로 검증되고 현재 JD의 판단에 필요한 경험이어야 한다. 사실이어도 JD 증명력을 더하지 않으면 삭제한다.
- **첫 페이지**: 면접관이 첫 스캔에서 대표 경험, 구체적 결과, 검증된 AI 개발 경험을 확인할 수 있게 배치한다. 근거가 없는 슬로건·한 줄 소개는 넣지 않는다. 자기소개가 필요한 경우에만 5줄 이내로 대표 프로젝트 하나, 검증된 AI 개발 방식 하나, 직무 관련 사실을 연결하고 자기평가 없이 작성한다.
- **AI 경험**: 모든 소프트웨어 직무에는 검증 가능한 AI 개발 경험을 한 줄 이상 포함한다. 단순 도구 사용이 아니라 작업 범위·계획, 조사·구현·리뷰의 역할 분리, 결과 검증 방식, 속도·일관성·오류 감소 중 실제로 확인된 하나 이상을 보여 준다. AI가 만든 결과와 지원자가 직접 구현·통합·검증한 범위를 분리한다. 사용자가 최신 사실로 확인하지 않은 개발 프로세스는 생성·제안하지 않는다.
- **지원동기**: 지원동기를 요청받았을 때만 작성한다. 회사/팀/직무 각각의 검증된 사실, 지원자의 인접 경험, 입사 후 수행 가능한 구체적 업무를 연결한다. `경험해 보고 싶다`, `서비스가 좋아서`, `~하고 싶다` 같은 희망 서술로 끝내지 않는다.
- **불릿 구성과 순서**: 프로젝트·회사별 불릿은 강한 성과형 → 기능 구현형 → 인프라 → AI 활용 순서를 기본값으로 한다. 성과형은 최대 4개까지 서로 다른 문장 구조를 우선해 나열감을 줄이고, 기능 구현형은 최대 2개, 인프라와 AI 활용은 각 1개를 후보로 둔다. 이는 8개 고정 템플릿이 아니다. 검증된 사실과 JD 적합성이 있는 슬롯만 쓰며, 짧은 프로젝트·교육·단기 인턴은 더 적은 수로 끝낸다.
- **불릿 패턴 라이브러리**: 하나의 고정 템플릿을 강제하지 않는다. 가능한 경우 `도메인·기능 → 문제 또는 제약 → 분석/선택/구현 → 수치 또는 명확한 산출물`을 쓴다. 성능은 `문제 → 기법 → 수치` 또는 `분석 도구 → 원인 → Before→After`, 정합성은 `동시성 문제 → 잠금/검증 → 확보한 품질`, 기능은 `기술/프레임워크 → 사용자 흐름 → 구현 산출물`, 인프라는 `클라우드/컨테이너 구성 → 배포·상태·확장 산출물`, 협업은 `문서·결정 → 주도 행동 → 완료된 인계`를 참고한다. 수치가 없으면 화면 상태, API 계약, 테스트 결과, 배포 구조처럼 검증 가능한 산출물로 끝낸다.
- **성능·시간 수치의 최소 정보**: `프롬프트 경량화`, `Agent 흐름 조정`, `성능 최적화`처럼 조치만 요약한 뒤 수치를 붙이지 않는다. 반드시 `(1) 어떤 요청/사용자 흐름을 측정했는지`, `(2) 지연을 만든 처리 단계 또는 제약`, `(3) 실제로 바꾼 경로·라우팅·쿼리·프롬프트·구성`, `(4) Before→After와 대표/평균/최대 등 측정 범위`를 원천에서 확보한다. 이 중 하나라도 없으면 수치를 빼거나, 원천에서 확인되는 좁은 산출물로 낮춘다.
- **차별화 기준**: 기술명 자체가 아니라 왜 그 방식이 필요했는지, 어떤 기준·트레이드오프를 두었는지, 사용자의 어떤 문제나 운영 제약이 달라졌는지를 원천 근거가 있을 때만 드러낸다. 원천에 없는 설계 이유·대안 비교·효과는 만들지 않는다.
- **포트폴리오**: 대표 사례는 문제·해결·결과를 각각 분리하고, 가능한 경우 화면·다이어그램·스크린샷을 붙인다. 이력서 불릿을 그대로 늘리지 말고 기술적 판단과 검증 범위를 확장한다.
- **생성 검증**: 직무 무관 내용, 수치·산출물 없이 끝나는 정성 문장, 희망 서술형 지원동기, 단순 도구 나열 AI 문장, 단점으로 읽히는 표현을 제거한다. 불릿의 순서·구조는 위 기본값을 따르는지 보되, 경험이 없는 슬롯을 채우기 위해 사실을 만들지 않는다.
- **불릿 언어 하네스**: 생성 뒤 모든 불릿을 사실 하네스와 문장 하네스로 분리 검수한다. 문장 하네스는 `(1) 지원자가 한 행동을 나타내는 주된 서술어가 하나인지`, `(2) 수식하는 대상과 서술어가 자연스럽게 호응하는지`, `(3) 나열된 기술·명사가 문장 뼈대를 대신하지 않는지`, `(4) 접속 표현이 문제→조치→결과 관계를 실제로 나타내는지`, `(5) 한 불릿에 다른 문제·프로젝트·결과가 섞이지 않았는지`, `(6) 소리 내 읽었을 때 번역체·명사 나열체·불완전 문장이 없는지`를 확인한다. 하나라도 실패하면 사실을 줄이지 않는 범위에서 다시 쓴다.

- Keep company-specific tailoring in the company folder.
- Always generate a tailored resume when the application is still open and the company/role are identified.
- Apply a strict JD-relevance gate before choosing any experience, bullet, or tech-stack item: retain it only when it directly proves a responsibility, qualification, or preferred qualification in the current posting. Being true in the Developer source is not enough. Record every excluded otherwise-strong item and its JD-mismatch reason in the strategy; do not use unrelated experience as filler.
- **JD 어휘 매핑**: `JD 원문 원자 체크리스트`의 담당업무·자격요건·우대사항별로 `공고 표현 → 원천 근거 → 최종 문장 위치`를 먼저 확정한다. 직접 또는 좁은 유사 근거가 있으면 공고의 핵심 명사·동사를 자연스러운 한국어 문장 안에 한 번 이상 보존한다. 예를 들어 `제품·기술 해결책 설계`, `제품 기능 개발·개선`, `AI 도구 활용`, `RDBMS·NoSQL`, `핵심 지표 분석·성과 검증`처럼 사실로 증명되는 표현은 핵심역량 라벨, 프로젝트 설명, 또는 불릿에서 우선 사용한다. 키워드를 문장 끝에 붙여 넣거나, 근거 없는 담당업무·우대사항을 그대로 베끼지 않는다. 최종 검수에서 `직접 반영` 행마다 공고 어휘 또는 의미상 동등한 표현이 실제 이력서에 있는지 확인하고, 없으면 근거가 있는 범위에서 다시 쓴다.
- The only standing relevance exception is verified AI-assisted development practice. For every software role, include one compact, interview-defensible AI line on the first page when source evidence exists, even if the JD is not an AI role. It must state the actual workflow (for example Plan-First, role separation, or source-backed verification), the candidate's owned use, and a concrete result or deliverable. Never write a bare `AI 활용`, name a tool without the work it changed, or imply that AI produced unreviewed code.
- Decide role emphasis before drafting. For frontend roles, keep the headline, core capabilities, tech stacks, and most bullets focused on frontend user flows, UI state, API integration, accessibility/responsiveness, performance, and the single relevant AI workflow; omit backend, database, cloud, and Kubernetes detail unless it directly proves a stated JD requirement. For fullstack roles, show a balanced frontend-to-backend request/data/deployment flow. For AI Native/AI product roles, show the relevant product-engineering base plus verified AI workflow/implementation evidence, not an indiscriminate inventory of all stacks.
- Treat every technology list as an evidence list, not a career inventory. A stack line may contain only technologies needed to establish the current JD match or a necessary adjacent competency. This detailed-evidence gate does not remove the required factual profile sections (education/activity including short internships, military service, academic history, awards, certificates, language); retain them as independent full-entry records.
- Apply a stack-line gate separately from bullet selection. Put a technology in the visible `기술 스택` line only when at least one holds: (1) the JD explicitly requires or prefers it, (2) it is indispensable to understanding the selected experience's direct JD proof, or (3) omitting it would hide a stated required flow such as the requested frontend-to-backend, data, cloud, or container boundary. Remove true-but-irrelevant tools, test libraries, editors, state libraries, styling tools, and incidental managed services when they do not clear this gate; a long stack line can signal unfocused fit and become a negative. Keep such implementation detail only in a directly relevant bullet when it explains a decision.
- Preserve the personal-history section structure even when detailed technical bullets are JD-filtered. Keep `경력`, `교육 및 활동`, `수상`, `자격증 및 어학`, `학력`, and `병역` as distinct sections whenever the source has an entry for them or the application form asks for them. Place every short internship as its own dated, role-labeled entry inside `교육 및 활동`; do not create a separate `단기 인턴` section. Awards must remain separate from credentials; list language scores under `자격증 및 어학`. Never merge military service with education/activity or academic history with a project section.
- Use one consistent dated-entry layout for career, projects, education/activity, awards, certificates, academic history, military service, and language records. Do not turn lower-page facts into a compact metadata grid, side-by-side mini-card, or title-only row. In `교육 및 활동`, list each program and each short internship separately with its exact period, role, organization, and one bounded factual line; do not fold 크래프톤 정글, SK AI Leader Academy, 네이버 부스트코스·부스트캠프 코칭스터디, or short internships into a generic sentence. Apply JD relevance to the detail and ordering, not by deleting or merging these structural records.
- Build every resume from one explicit visual system: a single page-margin rule, a small fixed type scale (name, section, entry, body, detail, metadata), and a small fixed spacing scale used for section headers, entry gaps, stack/overview gaps, and bullet gaps. Reuse the same section-header rule and divider treatment for every section, including awards, credentials, academic history, and military service; never introduce a compressed footer-specific heading style. Keep line leading tighter than the gap between separate bullets, and render the PDF to check for orphaned headings, uneven page bottoms, inconsistent columns, or one-record spill pages before delivery.
- For `수상`, `자격증`, and `어학`, use separate headings and chronological factual rows. Do not convert an award into a project result, do not write a language score as a certificate, and do not omit dates that the Developer source verifies.
- Review every inherited bullet from a base resume before retaining it. Re-score it for direct JD match, candidate ownership, specificity, outcome, and redundancy. Rewrite or remove it when it fails any of these checks; formatting a generic bullet differently does not make it tailored.
- Keep detail proportional to evidence strength, not to page convenience. For a selected primary experience, include the exact period, role, service context, and enough distinct bullets to expose the underlying technical decisions and validation; do not collapse several verified source facts into one vague summary. Use the smallest set of non-redundant bullets that covers the JD, then use layout/page breaks rather than deleting high-signal evidence merely to force a one-page document.
- Use the first page as an interviewer decision surface. Within the first scan, show the strongest directly relevant project/work evidence, 3-4 non-overlapping core strengths, and the verified AI workflow. Add a headline or self-introduction only when it conveys a specific source-backed fact that is not already clearer in the experience section; never use a generic role slogan. Do not use the first page for weak history, broad skill catalogues, generic claims, or an unrelated second-best project.
- When a resume self-introduction is necessary, keep it fact-based and within five rendered lines. It may contain only a role-relevant fact, one verified AI-development practice, and one strongest project/professional fact; remove biography, aspiration, personality claims, technology inventories, and `저는 ~한 사람입니다` self-description. Omit it entirely when it would only restate the resume.
- When a `지원동기` is requested, write it separately from the self-introduction and make all three links explicit: why this company, why this team, and why this role. Ground the company/team link in a verified company/product/team fact, connect it to 1-2 verified adjacent experiences, then name the concrete work the candidate can perform after joining. Put the most effort into this reasoning; generic praise, a JD paraphrase, or an ending that only says `기여하고 싶습니다` fails the motivation check.
- Write bullets as evidence rather than self-description. One bullet normally contains one same-context chain: `domain or user/task context -> observed problem or constraint -> candidate-owned analysis, decision, or implementation -> measured result or concrete delivered state`. Do not merge chains from different products, and do not invent a problem when the evidence only supports a feature; in that case use `user/task context -> implemented feature or flow -> verified artifact/user-visible state`.
- Prefer these compact bullet patterns when evidence supports them: performance `context + bottleneck + analysis tool + technique -> Before/After`; consistency `domain action + concurrent/invalid state -> locking/validation/transaction -> protected quality or test result`; feature `standard/framework + user flow -> implemented interaction/API/state -> verified behavior`; infrastructure `cloud/container component + deployment/operation need -> configured flow -> verified deployment, routing, state-check, or scaling artifact`; collaboration `document/decision + candidate-owned coordination -> completed handoff or execution result`. Use a named analysis/implementation technique only when source-backed.
- For an AI/Agent response-time bullet, use `measured request path + latency-causing stages/constraint -> named routing or prompt/Agent changes -> scoped Before→After`. Never submit `프롬프트 경량화와 Agent 흐름 조정으로 N초 단축` as a complete bullet. For example, when the source supports it, identify the long-running retrieval/validation/generation path, the lighter route for a request class, and the specific prompt or Agent routing adjustment. Keep a Trace/progress UI bullet separate from the processing-time bullet unless the source proves that the UI changed processing time.
- A strong result ends in a number, a bounded validation result, or a concrete deliverable. Use causal wording only where the source verifies it. If no metric exists, write a defensible outcome such as an implemented screen state, error/empty/loading path, API contract, test result, deployment structure, or documented handoff; do not substitute vague claims such as `UX 향상`, `생산성 증대`, or `협업에 기여`.
- If a complete, source-backed performance chain does not fit in a one- or two-line resume bullet, shorten stack names and incidental context first; do not remove the measured request, the concrete change, and the measurement scope. Put extended technical details in the portfolio or strategy, but retain the causal minimum in the resume.
- Before finalizing each bullet, verify: (1) which exact JD item it proves, (2) which source fact supports every claim, (3) what the candidate personally decided or implemented, (4) why that technique was selected, when evidence supports the reason, (5) what changed or was delivered, and (6) whether another retained bullet already proves the same point. Delete or narrow a bullet that cannot answer these questions.
- Run the bullet language harness after the fact/JD checks, not before them. Rewrite in this order: `keep the source-backed subject and action -> state the user/workflow context -> remove stacked modifiers and incidental stack names -> split a second chain into a new bullet or delete it -> retain the result`. Do not repair awkward Korean by adding unverified intent, impact, or causal language. Avoid fragments ending only in a noun, consecutive `~하고/~하며/~로` chains, untranslated English grammar, and more than two same-level connectors in one sentence. Preserve an unfamiliar technical term only when the reader also gets its role in the workflow.
- Apply a final necessity check to every sentence: if deleting it does not reduce evidence for a concrete JD item, an independently required factual profile record, or the verified AI-development exception, delete it. Never keep a sentence merely because it is true, technically impressive, or helps fill a page.
- AI bullets require the same scrutiny as technical bullets. Prefer a traceable workflow such as `scope/plan -> implementation -> verification -> result`; separate AI-generated output from the candidate's review, integration, and validation. Include only the portions actually verified in the source and keep one AI bullet distinct from product-feature bullets so the interview thread is clear.
- Before finalizing the resume, run a coverage-and-lexicon pass against every row in the `JD 원문 원자 체크리스트`. Search for the submitted resume's corresponding wording and verify semantic coverage manually for paraphrases. For every source-backed `직접 반영` row, retain the JD's core noun or action verb in a natural submitted sentence unless a Korean synonym is clearer; record any omission reason. Important exact phrases such as product names, role-specific evaluation words, submission-form instructions, and company-scale facts must either appear in the resume/strategy or have an explicit omission reason. Do not declare the artifact ready while a directly supported checklist row is missing from the resume.
- After generation, run a separate artifact-integrity pass. Compare the final resume against the strategy and analysis: the selected core-capability labels and ordering must match the strategy exactly, every retained project/activity must have a JD-fit reason, and no inherited item from a generic/base resume may remain unless the strategy explicitly retains it. Treat any mismatch as a failed generation requiring correction, not as a cosmetic review note.
- The final pass must also check for stale or contradictory claims by searching the generated source for excluded activities, unsupported JD keywords, duplicate work/project descriptions, and strategy items that do not appear in the artifact. Report the exact mismatch before claiming readiness.
- If any exact JD phrase is intentionally not used because it lacks evidence, keep it in the strategy risk table; do not silently drop it.
- Do not generate a tailored general portfolio PDF, Typst, or candidate list. When a JD asks for a general portfolio, provide the user's separately managed existing `existing_portfolio_pdf` path for submission. Create an AI-usage candidate list and AI-usage portfolio artifact only when the JD explicitly asks for AI-usage evidence or the user explicitly requests a tailored AI-usage portfolio in the current task.
- The portfolio candidate Markdown must rank 3-6 cases by JD fit. For every case, write: `JD requirement -> verified experience -> problem/constraint -> architecture/data flow -> code or prompt/tool detail -> result/validation -> scope caveat`. Use concrete code-level details when verified, such as API contracts, queue/worker boundaries, event/state handling, retries, pagination, sanitization, prompt instructions, agent routing, or test commands. Do not turn the candidate list into a polished portfolio or invent missing implementation details.
- Do not list JD-required technologies or duties as unsupported personal experience. If another verified experience demonstrates the same underlying competency, rewrite it around that competency and keep the evidence source clear.
- Extract the exact evaluation words from every JD responsibility, qualification, preferred qualification, and application instruction into the checklist. Build a mapping of `JD wording -> verified source fact -> candidate-owned action -> resume location or omission reason`. For every item with direct evidence, reuse the JD wording naturally in a bullet or core-capability statement; for adjacent evidence, use a narrower truthful equivalent; for no evidence, exclude the term rather than keyword-stuffing.
- Never hard-code a universal project priority. Recompute the project set for each JD from the evidence records: select one or more projects only when each contributes a distinct or stronger match, prefer the smallest non-redundant set that covers the important requirements, and record the chosen projects and order only in that company's strategy file. A new project must become eligible through the same evidence schema without changing this skill.
- When repository evidence is needed, inspect the full history and candidate-authored changes before writing portfolio or resume claims. Store reusable code evidence as repository/file/function/commit references and concise implementation summaries; do not copy whole repositories or attribute teammate-owned features to the candidate.
- Separate personal work from library/framework/service responsibility in every bullet. For example, Yjs synchronization, Monaco editing behavior, Bedrock Agent trace generation, Amazon API Gateway WebSocket APIs, SQS queueing, and OpenSearch retrieval are platform/library or managed-service capabilities; the resume should state the candidate's verified work such as integrating them, defining API/data contracts, rendering progress state, using `PostToConnection`, handling edge cases, improving UX, or validating behavior.
- Make candidate ownership grammatically explicit in every technical bullet. Use verbs such as `설계했습니다`, `구현했습니다`, `연동했습니다`, `분리했습니다`, `검증했습니다`, `분석했습니다`, and `적용했습니다` only for source-backed candidate work. Name platform behavior separately as context: for example, write `Bedrock Agent가 생성한 Trace 이벤트를 진행 단계 UI로 변환해 연동했습니다`, not `Trace 기능을 구현했습니다`; write `Y.Doc 공유 흐름을 구현했습니다`, not `Yjs 동기화를 구현했습니다`; write `API Gateway WebSocket APIs와 PostToConnection을 사용해 전달 경로를 구성했습니다`, not `WebSocket API를 개발했습니다`.
- Do not let a bullet's grammatical subject switch from the candidate to an unspecified system. A sentence such as `Host가 조회한 뒤 전달해` must identify what the candidate implemented: `Host 단일 조회·Y.Doc 전달 흐름을 구현해`. A service/project overview may describe product scope, but it must not imply personal ownership of all service features.
- For CPPM's real-time Agent status work, lead with the user-visible change: convert `Bedrock Agent Trace` events such as search, Knowledge Base retrieval, and Action Group calls into user-friendly processing steps, then deliver them to the screen through `Amazon API Gateway WebSocket APIs` as a progress-status UI. Do not describe this as exposing internal logs. Describe `Amazon CloudWatch` separately as the tool used to analyze and validate Agent routing and Lambda/OpenSearch error flows.
- Keep CPPM outcomes separate: Trace/progress UI reduced uncertainty about whether a 1-2 minute task was still running and contributed to fewer abandonment inquiries; prompt/Agent-flow optimization reduced the measured average response time from about 2 minutes to 1 minute 10 seconds. Do not claim that the Trace UI itself reduced elapsed processing time.
- For CPPM's waiting-experience improvement, keep the causes and outcomes distinct. The OpenSearch Agent could retry with similar search terms or different periods, or answer as if data existed, when its verification query returned no results. Describe the verified control as a validation prompt with explicit no-result, retry-limit, and error-termination conditions. The prompt and Agent flow initially made responses long; prompt simplification/lightening and flow adjustment reduced the average response from about 2 minutes to about 1 minute 10 seconds. The graph-code generation, execution, S3 storage, and link delivery flow was working; separately, because completion time was not predictable enough for a reliable percentage or remaining-time estimate, convert search, Knowledge Base retrieval, and Action Group Trace events into user-friendly real-time processing steps. If no measured abandonment-rate reduction exists, write only that it contributed to reducing abandonment inquiries.
- Do not combine separate verified facts into a new technology label. For example, if Bedrock Agent Trace and Amazon API Gateway WebSocket APIs are separately verified, do not write `WebSocket Trace`; write only verified units such as `Bedrock Agent Trace`, `Amazon API Gateway WebSocket APIs`, or `progress/status UI`.
- Any fact marked as draft, needs confirmation, limited, or uncertain in Notion/local snapshots must not be written as completed implementation. Downgrade it to the confirmed level such as reviewed, designed, PoC, learned, or exclude it.
- Follow the `생각등대` writing guide: each strong bullet should be technically credible but readable, using a problem/reason/implementation/result structure. Avoid opaque internal shorthand and avoid writing only tool names.
- Treat the resume as a decision document for getting an interview, not a career archive. The first 10-15 second scan should show role fit, the strongest practical evidence, technical depth, and no risky overclaims.
- Bullets should show what changed because of the candidate, not just what they were responsible for. Prefer scope, numbers, user/business impact, or validation results; when production metrics are unavailable, use verifiable scope such as code size, API count, constraints, processing time, UI/state/exception coverage, or test coverage.
- Apply the shared `생각등대` rules: select only experience directly connected to the JD's responsibilities, qualifications, and preferred qualifications; make the first page immediately show the candidate's differentiating strength and strongest evidence; do not pad the resume with every known experience.
- Review verified AI-tool usage for every JD, not only AI-role JDs. Include one compact first-page AI-development line whenever the actual workflow/control, context, candidate-owned review, and result are evidenced; AI practice is the standing cross-role relevance exception, but never use `AI 활용` as an unsupported standalone keyword.
- Default bullet structure is `problem or constraint -> candidate-owned technique/judgment -> result or impact`. The cause may be omitted for space, but end with a metric or a concrete deliverable. Prefer `Before -> After`; if no metric exists, use a verifiable outcome such as consistency, error-state handling, or a completed screen/artifact.
- Name the applied method or tool specifically: write `MySQL EXPLAIN + index tuning` instead of generic performance improvement, `optimistic/pessimistic lock` instead of generic concurrency handling, and `AWS CI/CD + S3 integration` instead of generic cloud deployment. Framework-only bullets must include the contribution target and resulting artifact.
- For CPPM realtime communication, distinguish the AWS service, delivery call, and transport: `Amazon API Gateway WebSocket APIs` is the managed AWS service providing WebSocket connections, `API Gateway Management API`'s `PostToConnection` is the Worker Lambda delivery call, and `WebSocket` is the communication mechanism. Write `Amazon API Gateway WebSocket APIs integration limit` for the constraint and `delivered to the WebSocket connection through PostToConnection` for Trace delivery instead of using the ambiguous label `WebSocket API`.
- When evidence spans several projects and professional work, prefer a scope-oriented label such as `RESTful API 설계·개발·연동` over a technology-list label. In the core capability, explain in one or two natural Korean sentences that the candidate designed, developed, and connected RESTful APIs, then connected differing data structures and state flows to frontend features covering retrieval/storage, search, asynchronous work, and exception handling. Put concrete stacks and project-specific evidence in the experience bullets, and never make separate projects appear to be one implementation.
- Feature bullets may use `standard/protocol or technology -> feature -> user-visible change`; infrastructure bullets may use `cloud service -> connected flow -> deployment/operation artifact`. Keep `problem -> solution -> result` readable within one bullet, using an arrow only when it improves scanability.
- Design visual hierarchy as part of bullet writing: keep one problem/action/result chain per bullet, usually within 1-2 sentences, and normally bold only the metric/deliverable plus one key result phrase, with no more than 1-2 emphasized spans per bullet. Do not bold full problem clauses, every technology name, or every sentence; the first scan should reveal the result and the candidate's contribution.
- When useful, order a project entry as `period -> JD-relevant tech stack -> team/role -> one-sentence service overview -> evidence bullets`. Keep the overview to one sentence and put detailed problem, judgment, implementation, and impact in the bullets. Tech stack lines are evidence for the JD, not a complete inventory.
- Apply these shared expression patterns when selecting or rewriting capabilities: `API/data integration` should foreground the user flow completed across backends and external APIs; `state/realtime UI` should foreground how users understood and continued their work; `performance/data` should foreground the observed bottleneck, analysis method, and Before/After; `AI/Agent` should foreground the operational constraint, Agent structure, and user-visible result; `AI Native/SDD` should foreground changing requirements, documentation/harness updates, verification, and the improvement loop. If a capability still reads as a parallel technology list, rewrite it around the outcome.
- For cross-project capabilities, state the shared outcome first, name the contributing projects, and leave project-specific implementation and metrics in their own experience bullets. Never merge APIs, state management, or performance figures from separate projects into one implied service or causal result.
- Do not use broad phrases such as `AX 전환에 기여`, `operationalized`, or `architecture design` by themselves. Attach concrete source-backed evidence such as multi-agent flow, progress/status UI, API/data flow, SQS asynchronous processing, secret/key separation, search UX, or other candidate-owned implementation details.
- Write in natural Korean that a reviewer can understand on first read. Do not drop internal abbreviations, domain names, or technology names without context. Explain who used the product, what workflow it supported, and what screen/API/state/data flow the candidate worked on.
- Apply a user-first explanation pattern to every generated artifact, not only AI or CPPM cases: start with the user-visible or business-relevant change, then explain the problem and constraints, the candidate's decision and implementation, the technical mechanism, and the measured or observed result. A reader without the project's technical context should understand the situation and the candidate's contribution from the first sentence.
- Do not use technology names as standalone claims. Explain why the technology was used and what changed, such as `장시간 작업이 요청 제한으로 끊기지 않도록 SQS로 작업을 분리` or `처리 단계를 사용자 화면에 실시간으로 보여 주기 위해 API Gateway Management API의 PostToConnection으로 WebSocket 연결에 이벤트를 전달`. Apply this rule consistently to resume bullets, capability sections, cover letters, motivation answers, portfolio cases, and activity descriptions.
- Keep the wording accessible without becoming technically shallow. A good bullet should show why the technology was needed, how the candidate integrated or configured it, and what exception handling, state management, performance, security, UX, or validation scope was personally handled.
- Keep the writing natural and modest. Avoid AI-like declarative phrasing such as `증명하겠습니다`, `전환하는 개발자`, or `역량을 보유했습니다`. Prefer fact-based phrasing such as `구현했습니다`, `경험이 있습니다`, `연결해 봤습니다`, or `맡았습니다`.
- For verified specification-driven work, show the full chain rather than only the final result: clarify changing requirements and unfamiliar domain information in documents, define API/directory/account-management rules and validation criteria, improve the SDD document plus Codex harness/prompts as gaps are found, verify the implementation against the specification, and then describe the resulting service separation and implementation.
- Include a `지원동기` section only when the JD/form asks for it or when the company/role naturally connects to the candidate's interests, narrative, and verified experience. Do not force personal storytelling when the connection is weak; omit the section instead. Do not include a separate `소개` section unless the JD or application form explicitly asks for a brief self-introduction, 자기소개, or About-style text.
- Before finalizing any application, extract and verify the posting/form's required submission contents separately from the role requirements. If the posting says the resume must include 자기소개 or 지원동기, treat those as mandatory deliverables and place them in the requested resume or required form fields; do not leave them only as an optional suggestion. When the form already has required 자기소개/지원동기 questions, verify those fields are populated before submission.
- Treat `지원동기` as the explanation of why this company's specific work matches the candidate's verified problem-solving pattern, not as company praise, preference, or a generic career aspiration.
- Use this common motivation structure when a motivation section is needed: `specific company/role problem or work nature -> why that point connects to the candidate's experience or interest -> 1-2 adjacent verified experiences -> how the candidate can work in that role after joining`.
- In `지원동기`, domain-adjacent work must stay domain-adjacent. If the candidate developed software for workflows that include CRM marketing, do not phrase it as having performed marketing operations; state the software/product development contact point and verified implementation scope.
- When writing `지원동기`, the main point is why this specific company. Use source-verified company vision, values, business direction, products/services, and recent signals, then connect them naturally to the candidate's interests, narrative, and verified strengths. Only after that, connect why this team, why this role, and what concrete work the candidate can do there. If the paragraph would still work after replacing the company name, do not use it as motivation.
- Do not write `지원동기` as a JD summary. Phrases equivalent to `역할로 이해했습니다`, `반복 업무와 병목을 이해하고`, or `운영 가능한 솔루션으로 만드는 역할` are weak if they only paraphrase the posting. Briefly identify the company/team/role context, then move quickly to source-backed adjacent work the candidate has done and the concrete work they can perform in that role.
- Do not end `지원동기` with generic wishes such as `기여하고 싶습니다`, `성장하고 싶습니다`, `역량을 발휘하겠습니다`, or `비전에 공감했습니다`. End with the concrete work the candidate can perform and the way they can work, grounded in verified experience.
- Portfolio artifacts must read like a technical portfolio similar in intent to `/Users/baggeon-u/Desktop/cv-jd-tailor/박건우_포트폴리오.pdf`, not like a resume summary. Each selected case should show `problem/constraint -> architecture or flow -> code/implementation points -> AI usage method -> verification/result` when source facts support it.
- For tailored portfolios, search the complete Notion project evidence pool, including newly added projects. Do not restrict the pool to named companies or programs. Prefer professional evidence when the JD match and evidence strength are otherwise comparable, but select any project that directly proves a requirement and combine multiple projects when each contributes a distinct signal. Exclude only when the JD match, ownership, evidence, or publicity is insufficient.
- For both resume and portfolio emphasis, use this evidence priority: `DGM UnitOne professional work -> internships -> bootcamp/education projects -> university projects`. University projects usually have weak practical hiring signal compared with DGM UnitOne; do not promote them into core competencies or representative projects by default. Even for AI/healthcare postings, prefer the source-backed DGM UnitOne experience of connecting Amazon Bedrock-based AI work-support features to screens, APIs, and asynchronous flows. Do not write university project experience as if it were production service work, and do not use labels such as `AI 추론 결과 서비스화` unless the source explicitly confirms real service deployment.
- Include code-oriented implementation points where possible, such as `connectionId`-based WebSocket delivery, separating text chunks and Bedrock Agent Trace events from the Bedrock completion stream, `AgentEventManager` singleton subscription/cleanup, `requestAnimationFrame` scroll control, `LastEvaluatedKey` cursor pagination, DOMPurify sanitization, Lambda environment-variable API-key isolation, or Graph Agent Lambda subprocess/S3 URL return flow.
- Include a visible Architecture/Flow block for each major portfolio case. If reusable image assets exist under `assets/portfolio`, use them. If no image assets exist, create a Typst text diagram with boxes/grids, for example `Frontend -> Amazon API Gateway WebSocket APIs -> Lambda -> Bedrock Agent -> SQS/DynamoDB/S3`.
- Describe AI usage methods without overstating ownership. For DGM UnitOne common capability, use Figma MCP, Cursor, Codex, and Skills only in the verified context of publishing, technical research, PoC, and documentation workflow; include Plan-First Workflow or Researcher/Planner/Reviewer role separation only when relevant. Do not confuse AI-generated output with candidate-owned implementation and verification.
- A technical portfolio should contain at least 5 troubleshooting cases. Default case candidates are `long-running Agent response wait experience`, `chat search and navigation`, `multi-agent architecture`, `API Gateway timeout with SQS asynchronous split`, `API key protection and XSS handling`, and `AI-assisted development process internalization`. If a case does not match the JD, replace it with another verified DGM UnitOne troubleshooting case rather than inventing one.
- When creating or using architecture images, use AWS official Architecture Icons or user-provided image assets only. If official icons are not available locally, do not create unofficial AWS-like icons; use a Typst text diagram instead.
- Treat the first resume page as the interviewer's decision surface. Put the candidate's JD-matched differentiators, strongest career/project evidence, and reason to interview them on page one. Do not waste page one on generic self-introduction or broad technology inventory.
- `핵심 역량` is for the JD's required core competencies only when they can be supported by verified source facts. Do not fill the section with aspirational skills, weak keyword matches, or technologies the candidate has not used. If there are not enough source-backed competencies, make the section shorter or omit it instead of padding it.
- `핵심 역량` is not a complete inventory of the candidate's skills. Select only 3-5 source-backed strengths from the JD's qualifications and preferred qualifications that are directly relevant and strong enough to discuss in an interview. Exclude unrelated, weak, or merely familiar technologies from this section; keep them in detailed experience or the tech stack only when the JD genuinely needs them. Shorten or omit the section instead of padding it.
- In `핵심 역량`, the label and first clause must be a concrete technical decision area that can lead to an interview question. Do not use generic or AI-sounding labels such as `AI·제품 연결`, `서비스 구현력`, `제품 구현력`, or `클라우드·업무 플랫폼 구현`.
- Write each core-capability item as a short decision statement: `JD requirement -> candidate's differentiating evidence -> result/impact`. Do not use a technology name (`React`, `AWS`, `SQL`), a personality adjective (`problem solver`, `hardworking`), or a bare responsibility (`built screens and APIs`) as a standalone capability. Each item must expose one concrete judgment or implementation area that can lead to an interview question.
- Rank candidate strengths by direct JD match, specificity of evidence (constraint, scope, result), differentiation, and overlap. Do not expand one CPPM experience into separate top-level items for every related detail; combine or drop multi-agent design, validation prompts, response optimization, and Trace UI according to the JD's highest-priority need.
- Treat the experience bullets below core capabilities as evidence, not repetition. For each project/product, write `user/work context -> problem or constraint -> candidate-owned decision and implementation -> change/result`; place technology names inside that explanation. Keep one problem-solution-result chain per bullet. Split validation prompts, response-time optimization, and real-time status UI when their causes, actions, or outcomes differ. If there is no quantified business metric, use verified scope such as processing time, API count, constraints, exception coverage, or observed user impact, and qualify the impact conservatively.
- For AX/AI/FDE roles, prefer source-backed capability labels such as `다중 Agent 업무지원 설계`, `장시간 AI 작업 운영화`, `Agent 응답 UI 구현`, `업무 플랫폼 기능 구현`, `AWS 서버리스 연동`, and `데이터 조회·관측 흐름 개선`. Attach concrete evidence in the same bullet: Master/Supervisor/OpenSearch/Graph Agent structure, Agent Instruction, Bedrock Agent Trace, Amazon SQS, AWS Lambda, Amazon API Gateway WebSocket APIs, DynamoDB cursor pagination, DOMPurify, API key server-side isolation, or other verified implementation details.
- For frontend/product roles, prefer UI/state/API/data-flow labels such as `실시간 협업 상태 처리`, `업무 화면·API 구현`, and `검색·하이라이트·메시지 이동 UX`. Do not reduce a verified implementation into analysis-only wording. Reduce AI/AWS/database keywords on page one only when they do not directly support the JD.
- Build core-competency bullets by this sequence: extract the JD's qualification/preferred-qualification wording, find direct source facts in Notion/local source/user latest corrections, rank by direct match, evidence specificity, differentiation, and overlap, select only 3-5 strengths, then rewrite each into one natural sentence that shows problem/constraint, candidate-owned judgment or implementation, and result. Do not use a phrase that is neither in the JD nor supported by source facts.
- For DGM UnitOne common capability, use these as candidates for AI/AX/FDE/automation/developer-productivity JDs: `AI를 개발 프로세스에 도입해 퍼블리싱, 기술 조사, PoC, 문서화 과정을 표준화`, `Plan-First Workflow`, `Researcher·Planner·Reviewer 역할 분리`, and `반복 퍼블리싱 작업 시간 4시간 -> 30분(87% 단축)`. In submitted artifacts, use only the one most JD-relevant point and keep it short.
- For CPPM, use these as candidates for AI/AX/FDE/fullstack/AWS/workflow-automation JDs: `Agent Trace 기반 실시간 작업 단계 UI`, `싱글톤 기반 AgentEventManager`, `requestAnimationFrame 기반 렌더링 제어`, `debounce 300ms`, `LastEvaluatedKey 기반 페이지네이션`, `Lambda 환경변수 기반 API Key 격리`, `DOMPurify 기반 Sanitization`, `Master -> Supervisor -> OpenSearch·Graph Agent 3계층 Multi-Agent 아키텍처`, `Amazon Bedrock Knowledge Base(RAG)`, `CloudWatch 로그 분석`, and `Graph Agent 기반 서버리스 시각화 파이프라인`.
- For cloud/AWS JDs, CPPM may be positioned strongly as `AWS 운영형 서비스 구현` or `AWS 기반 서비스 기능의 실행·관측·오류 흐름 구현` when the JD values cloud operations, MSP, DevOps, backend, AI infrastructure, or service reliability. Keep the scope bounded to the verified service-function layer: AWS Lambda execution, Amazon API Gateway WebSocket APIs delivery, Amazon DynamoDB storage/query, Amazon OpenSearch Service retrieval, Amazon S3 result return, Amazon CloudWatch log/error-flow analysis, and verified Bedrock Agent integration. Do not phrase it as total cloud-infrastructure ownership, EKS operations, network-device operations, data-center operations, or CSP migration unless a current source verifies that exact work.
- For CPPM cloud-operation wording, `AWS 운영 경험` is allowed only as shorthand for operating and improving AWS-backed application/service flows, not as a claim of owning all cloud infrastructure. Prefer sentences like `AWS 기반 AI 업무지원 기능의 실행·저장·검색·전송·오류 분석 흐름을 실제 서비스 기능으로 구현` or `CloudWatch 로그로 Agent 라우팅, Lambda 오류, OpenSearch 재시도 흐름을 분석`; avoid vague claims such as `클라우드 운영 전문가`, `AWS 인프라 전체 운영`, or `EKS/Kubernetes 운영 경험`.
- Do not paste the long CPPM/FBITI candidate list wholesale. Deduplicate overlapping claims and select only 3-5 bullets that match the JD's qualification/preferred-qualification signals. Merge repeated security wording into one API-key/XSS bullet, and repeated DynamoDB debounce/pagination wording into one data-query bullet.
- Strong wording such as `ERD 설계부터 RESTful API 설계 및 개발까지 전담` requires source or latest-user confirmation. Use the correct spelling `RESTful API` in submitted artifacts.
- Do not put defensive meta sections or phrases in submitted resumes/portfolios, such as `제외 기술`, `직접 근거가 약해`, or `보유 기술처럼 쓰지 않습니다`. Keep those judgments in the strategy document only; submitted artifacts should simply select verified experiences.
- Preserve visible tildes in all range expressions. In Typst body text, a raw `~` can render as spacing instead of a visible tilde, so write ranges as escaped tildes such as `1\~2분`, `3\~5주`, and `2024.02.07\~2024.02.25`. Do not silently replace range tildes with spaces or hyphens.
- Keep reusable career facts in the Notion Developer page. Do not create or expand local markdown source files unless the user explicitly asks for a snapshot update.
- In resumes, company work performed during employment must stay under the career section. Do not duplicate CPPM, 프비티, or other employer work under the standalone project section.
- When one employment entry contains multiple products, projects, or workstreams, split them inside the career entry with small subheadings instead of mixing all bullets in one flat list. Keep them under `경력`, not under the standalone project section.
- For 디지엠유닛원, the career entry must be split with visible small subheadings for exactly two workstreams: `LG 공통업무 플랫폼(CPPM)` and `프비티`. Do not mix CPPM, 프비티, and AI Native Workflow bullets into one flat list. Do not create `AI Native 워크플로우` as a standalone project or case; fold AI Native process evidence into the relevant actual project, usually `프비티`.
- For CPPM project/product descriptions, use the compact project title `LG 공통업무 플랫폼(CPPM)`. Do not repeat `LG CNS 프로젝트` or add an explanatory affiliate-scale phrase in the title when the employer context already identifies the work. For self-introductions, resume headlines, top positioning statements, and motivation sections, avoid the client company name and use wrapped wording such as `외부 LLM 사용이 제한된 환경의 AI 업무지원 기능` or `AI Agent 기반 업무지원 기능`. Do not shrink CPPM into a small internal AI-support feature; describe AI work as the candidate's feature area inside that platform.
- Use the verified 프비티 workstream period `2025.07 – 2026.01`; never write `상세 기간 미확정` for it.
- For CPPM/AX positioning, prefer the user's safe phrases: `Bedrock Agent, SQS, WebSocket 진행 상태 UI를 연결` and `외부 LLM 사용이 제한된 환경에서 AI 기능을 업무 화면으로 구현`. However, do not lead one-line headlines with generic environment context such as `보안 제약`; almost every enterprise environment has security constraints, so it is not a strong personal differentiator. In self-introductions/headlines, foreground the candidate's verified strength: understanding work flows and implementing the screen, API, and AI Agent structure together.
- Describe 프비티 from its official site as a franchise-headquarters all-in-one solution. When more context is needed, explain that it integrates membership, order/procurement, inventory, franchisee management, and CRM marketing workflows.
- For every career and standalone project entry, use this order: `project/product name -> tech stack -> project/product description -> bullets`. Place the tech stack and description directly under the project name, not mixed into the bullets.
- Put the project/product description directly under the tech stack in a similarly styled smaller/lighter line. Keep it to one short sentence, ideally around 40 Korean characters, and explain only the product/service nature. Move background, problems, implementation detail, and results to bullets.
- Treat tech stacks as JD-matching evidence, not a full inventory of every tool used. Analyze responsibilities, required qualifications, and preferred qualifications, then list only technologies that directly match the JD or credibly demonstrate an adjacent required competency. If a used technology is unrelated to the JD, omit it or keep it only in a necessary bullet context.
- Tech stack lines must contain only official technology or product names as written in official documentation or product pages. Do not include role names, project descriptions, business-domain phrases, outcomes, education-program names, work-method labels such as `AI Native Workflow`, or job titles such as `Software Engineer`.
- If an official name is uncertain, verify it against official documentation, product pages, README files, or package names before writing it in a tech stack. Do not put class names, internal object names, or invented abbreviations in tech stack lines.
- Keep tech stack order intentional. Put the most JD-relevant or reviewer-critical technologies first; when priority is equal, use `primary framework/library -> language/state management -> UI/styling -> realtime/collaboration/domain technology -> build/deployment/infrastructure`.
- For AWS services, use official product names such as `Amazon Bedrock`, `Knowledge Bases for Amazon Bedrock`, `AWS Lambda`, `Amazon API Gateway WebSocket APIs`, `Amazon SQS`, `Amazon DynamoDB`, and `Amazon OpenSearch Service`.
- Use user-corrected canonical project tech stacks as the default candidates: 프비티 `Next.js, React, styled-components, Vite, Spring Boot, MySQL, Docker`; CPPM `React, styled-components, Vite, Docker, AWS`; Code Sync `React, Tailwind CSS, Yjs, WebSocket, WebRTC, Vite`. Trim only items that do not fit the JD.
- Adjust tech-stack granularity to the JD. For frontend JDs, avoid foregrounding databases, backend tools, or detailed AWS services that dilute frontend fit. For AI/FDE/automation/AWS JDs, expand CPPM's `AWS` into 3-4 core services such as `Amazon Bedrock`, `AWS Lambda`, `Amazon SQS`, and `Amazon DynamoDB`.
- If the AWS list becomes too long, keep only the strongest 3-4 services in the tech stack and explain details such as `Knowledge Bases for Amazon Bedrock`, `Amazon API Gateway WebSocket APIs`, `Amazon OpenSearch Service`, and `Amazon CloudWatch` in bullets.
- In resumes, place `경력` first, then `교육 및 활동` (including short internships as separate entries), followed by `수상`, `자격증`, `학력`, `병역`, and `어학` when source records exist. A standalone project section is optional and only for non-employment work when its evidence is stronger than education framing; do not place it ahead of career. Never merge bootcamp/education history, short internships, awards, certificates, language scores, military service, or academic history into a vague project block.
- Treat SKALA as education, like 크래프톤 정글. Do not create a standalone project named `SKALA 4기 실습`, and do not position ordinary SKALA practice as professional project work.
- Use 스마일게이트 윈터데브 only when it directly proves a frontend requirement, as one short supporting line under `교육 및 활동`. Omit it for other JD types and do not let any education history displace stronger professional evidence.
- Describe SKALA's official identity only as `SK AI Leader Academy`, an AI service development education program, or SW/Data/AI education with team projects. Do not call it a backend/cloud-native course unless an official source explicitly says that.
- Include SKALA as its own `교육 및 활동` record with its exact period. Expand its verified Java/Spring, RDBMS, concurrency, containers, or Kubernetes evidence for matching fullstack/backend/cloud-native roles; for a frontend role, retain only a concise factual line rather than turning it into detailed technical evidence. Keep it to at most 1-2 bullets. Never use vague progress wording such as `개별 과제 코드를 정리하고 있습니다` or `배우고 있습니다`. Technical terms such as MSA, Spring Cloud, Kafka, JPA, PostgreSQL, Docker, query tuning, index/execution-plan analysis, transactions, concurrency, tests, and service decomposition may appear only as README/code/execution-backed implementation, analysis, or performance evidence, not as an invented official course title.
- For cloud, DevOps, backend, full-stack, or infrastructure-adjacent JDs, SKALA Docker/Kubernetes evidence should be written as deployment-structure capability, not as weak classwork wording. Avoid `Docker 실습`, `Kubernetes 과제`, and `수업 들음` in submitted artifacts; use verified units such as `Docker 멀티스테이지 이미지 구성`, `JDK/JRE build-runtime separation`, `non-root container execution`, `Actuator management port separation`, `Kubernetes Deployment/Service/Ingress/ConfigMap/Secret`, `startup/readiness/liveness Probe`, `HPA`, `PDB`, `imagePullSecrets`, `namespace`, `resource requests/limits`, `readOnlyRootFilesystem`, and `RollingUpdate strategy` when the local files or Notion source confirm them.
- Do not turn SKALA Docker/Kubernetes learning into production operations. If a JD wants cloud-native or Kubernetes evidence, phrase it as `Spring Boot 애플리케이션을 Docker 멀티스테이지 이미지로 구성하고 Kubernetes 배포·라우팅·상태검사·확장 구조를 정리/구성` unless deployment to a real owned production service is verified.
- Do not emphasize toy/service-theme descriptions from SKALA web-mini such as public trials, AI judges, voting, or relationship-dispute scenarios. If that work is relevant, translate it into concrete engineering evidence such as API design, STOMP/event flow, persistence, query behavior, testing, deployment, or client-server integration.
- Treat 크래프톤 정글 as CS-focused education. Always retain it as a separate `교육 및 활동` record with its exact period and the same full-entry layout as career. Apply JD relevance only to its detail and ordering. Code Sync is always an independent `주요 프로젝트` record, never a career or education/activity entry, even though it was completed during 크래프톤 정글. Keep the education entry separate from Code Sync, usually as one computer-science foundation bullet starting with `주 100시간 이상 전산학을 학습하며`; do not append `크래프톤 정글 최종 프로젝트` to the submitted project title unless the application specifically requires that affiliation. When an algorithm-learning stack line is useful for the JD, list the user's verified `C, Python`; Pintos is not a tech stack item or backend/infrastructure work.
- For 크래프톤 정글 AWS special lectures, use them only as education/activity evidence for AWS network and compute fundamentals. When source-backed, state that AWS practitioners led a two-day workshop covering VPC, Subnet, Public/Private IP, DNS, DHCP, and EC2, and connect it to later DGM UnitOne AWS service implementation and SKALA Docker/Kubernetes deployment-structure learning. Do not promote the workshop itself into commercial AWS operations experience.
- For the 디지엠유닛원 career role label, always state the verified employment type `정규직` alongside the role: use `정규직 · Frontend Engineer` for frontend JDs, and `정규직 · Software Engineer` for fullstack, AI Native, AX, AI service, PI, or Builder-oriented JDs. This rule applies only to the 디지엠유닛원 employment entry. Keep 크래프톤 정글 Code Sync's project role as `Frontend Developer`, while describing the affiliation as a 크래프톤 정글 final project/education outcome.
- Keep all source-verified education/activity entries as independent full-entry records with exact periods, even when they are not detailed JD evidence. Order and expand JD-relevant entries first; keep each entry to at most two bullets. Do not put education, short internships, awards, military service, or academic history under `경력` or `주요 프로젝트`.
- Never assign an employment-style role to an education/activity record unless the source explicitly verifies that role. In particular, do not label an academy participant `Backend`, `Full-stack`, `Engineer`, or similar based on course content; use a source-backed neutral education label or the program's verified participant label.
- For this user's academy and boot-camp records, use the role label `교육` (not `교육생`) unless the user later supplies a different official participant title. Keep short internships explicitly labeled `단기 인턴`.
- Awards should list actual awards only. Do not place "selected project", homepage listing, or internal showcase results under awards unless the source clearly treats them as an award.
- Never include `크래프톤 정글 우수 프로젝트 선정` as an award, achievement, or other submitted item for any JD. Use Code Sync only as a project implementation experience.
- For Code Sync, prefer quantified implementation impact over a generic feature list when the JD values frontend, performance, collaboration, or product improvement. Candidate evidence includes GitHub API calls `44 -> 22`, initial JavaScript bundle `1,820KB -> 99KB`, PR-review discomfort responses `50 -> 5`, and weekly team PR comments `285 -> 89`. Use the survey, comment, and bundle figures only with their measurement scope/conditions, and phrase them as measured records or contribution rather than unsupported sole causation.
- For Code Sync's initial-loading performance bullet, preserve the causal distinction: the issue was the SPA loading code for unused screens during the initial entry, not the mere use of multiple libraries. Explain the structure, then the Route-level code splitting, lazy loading, or `React.lazy` implementation, and then the measured bundle result. Do not write that the libraries themselves caused the slowdown.
- Prefer the user's "생각등대" bullet pattern for compact resume writing: `[domain/feature] + [problem] + [-> solution technique] + [-> quantified result or concrete deliverable]`. Use arrows or concise connectors to expose the problem-to-decision-to-result chain, and never replace that chain with a technology-only list.
- For frontend capability statements, do not reduce state handling to `tested delayed/empty/error responses`. When source-backed, explain that the candidate considered success, loading, empty, failure, long-running, and navigation states from the user's perspective, then attach concrete evidence such as user-friendly Agent Trace steps delivered through `PostToConnection`, search/highlighting/message navigation, or other screen and event-flow implementation.
- Treat the same story structure as the default for career bullets, project bullets, core capabilities, activity descriptions, self-introductions, motivations, and portfolio cases. Do not force every item into an artificial incident; for a feature or activity, use `user/task context -> what the candidate built or organized -> resulting workflow or artifact` while preserving the actual scope.
- Keep the core-capability section scannable: normally use about four items, one sentence per item, with the broad capability, implementation scope, and representative project evidence only. Move detailed technologies, troubleshooting steps, metrics, and full problem-action-result stories into the career/project bullets; remove repetition rather than expanding the capability section.
- In each core-capability item, keep the label short and JD-readable, then write the explanation as natural Korean prose rather than a comma-separated technology list. State what was connected or implemented and which screen, state, or user flow it enabled; do not force unrelated capabilities into one item.
- When the JD values responsive UI, use the verified device scope naturally: if desktop, tablet, and mobile are source-backed, prefer wording such as `데스크톱·태블릿·모바일 등 다양한 디바이스에 대응하는 반응형 화면`. Avoid awkward stacked modifiers such as `사용자 역할과 디바이스에 맞춘 반응형`; if the device scope is not verified, do not invent one.
- A one-line headline is optional, never a required resume field. Use it only when one concise, source-backed fact gives an interviewer new decision-relevant information; otherwise omit it. Never use a role restatement, generic breadth claim, abstract outcome, or a sentence that merely paraphrases the JD.
- Review additional Code Sync evidence when relevant: BlockNote and Excalidraw/DrawBoard integrated into the same Yjs session, `html-to-image` editor-image sharing, commit-SHA-based PR file retrieval, and outdated-comment handling. Keep Code Sync as the final project of 크래프톤 정글 and separate it from 디지엠유닛원 employment.
- Keep source-verified certificates in an independent `자격증` section with credential and exact date. When a JD explicitly mentions SQL or SQLD, connect SQLD to verified SQL evidence such as SKALA PostgreSQL execution-plan analysis, index/Materialized View changes, and measured query improvement; otherwise do not inflate the credential into a technical-evidence bullet.
- 아티피셜 소사이어티 is never a career entry. Keep it as a separate dated `교육 및 활동` entry with role `단기 인턴`. The user's verified scope is training-data acquisition through Crawling, preprocessing and 데이터 어그멘테이션, EasyOCR-based OCR quality checks, and model-performance improvement support; do not inflate this into ownership of an entire production model or service. For AI/ML/computer-vision JDs, this detail can be prioritized.
- Include verified language information in its own `어학` section as a concise dated record, for example `2026.07.01 OPIc IM2`, without certificate number or unverified expiration date.
- Include verified awards in their own `수상` section as chronological factual bullets, such as `2023.07 ICICT 2023 치앙마이 포스터상`; do not add unverified award criteria or winner-scope details.
- Awards, when included, must be chronological bullets with dates. Do not compress unrelated awards into one comma-separated row.
- Include military service in its own `병역` section. Use only verified facts such as signal soldier and peer counselor; do not expand it into telecom equipment development or embedded experience.
- Keep 아티피셜 소사이어티 only as a separate dated `교육 및 활동` entry with role `단기 인턴`. Never place it under career. Retain its exact period `2022.07.04~2022.07.22` and a bounded factual scope; expand eye-tracking service data acquisition, Crawling, 데이터 어그멘테이션, or OCR detail only when directly relevant. Apply the same separate-entry rule to every other verified short internship.
- Treat verified technical and collaboration records as resume evidence, but keep their sections distinct. Do not include Toonners in resumes or portfolios for the current workflow. For frontend JDs, use only Code Sync, CPPM, and 프비티 as project evidence. For backend or cloud JDs, use 디지엠유닛원, SKALA, and verified SKALA MSA/web-mini evidence as the base. For PM or AI Native JDs, also review the verified MSA/web-mini PM/convention-governance experience. Add unrelated side projects only after explicit user instruction.
- For frontend-related JDs, 스마일게이트 윈터데브 may appear only as one short education/activity line; omit it for all other JD types.
- Do not use the fisheye project in submitted resumes or portfolios until an evidence link is confirmed.
- Links should be attached to meaningful text, such as the project name, award name, official page label, or `[GitHub]`; do not append raw-looking links at sentence ends.
- When the user corrects a reusable fact, update the Notion source when explicitly asked; otherwise reflect it in the generated company artifact and report that the source still needs a Notion update.
- Avoid duplicating the same source paragraph across multiple company artifacts without JD-specific rewriting.
- Portfolio summaries should be candidate-first, not JD-first. Do not open with a paraphrase like `the posting requires...`; start with the strongest verified work the candidate actually did, then add the JD connection briefly. For adjacent domains such as marketing/FDE, explicitly distinguish product-development contact with CRM/marketing workflows from actually performing marketing operations.
- Portfolio cases should not merely repeat resume bullets. Each case should give the interviewer a technical thread to probe: problem/constraint, candidate-owned judgment and implementation scope, why the technology was used, result/validation, and remaining risk or learning. Include at least three of these dimensions per case.
- One-line headlines should expose a verified personal differentiator, not generic environment context or self-positioning. For AX/AI/FDE roles, prefer submitted-document wording like `업무 흐름을 이해하고 화면·API·AI Agent 구조로 구현해 본 개발자`, grounded in verified enterprise work-platform experience, multi-agent AI functionality, response/progress UI, API, and asynchronous-flow integration. Avoid awkward internal review wording such as `현업 AI 서비스`, `현업 AI Agent 기능`, `현업 업무 플랫폼`, or `보안 제약이 있는 업무 플랫폼에서...`. In sensitive client contexts, omit the client name in headlines, self-introductions, and motivations while preserving the precise project description inside the relevant project section.
- Avoid resume bullets that only restate the intro, subtitle, or responsibility scope. A career bullet should have a concrete problem, meaningful action, and outcome/metric/domain impact. If an item only says that a feature was improved or feedback was reflected without a result, keep it in the intro/subtitle/context or omit it.
- Prefer concrete problem names, actions, and verifiable outcomes over generic self-praise.
- Do not inflate scope or merge unrelated facts into a new causal story.

### 7. Render PDFs When Possible

Run `typst compile` for the generated resume Typst file and write the PDF beside it as `박건우_이력서.pdf`. Only when an AI-usage portfolio Typst file was requested and generated, compile that portfolio file as well.

If Typst or a template dependency is unavailable:

- keep the `.typ` output
- report the blocker directly
- do not claim PDF generation succeeded

### 8. Report Completion

At the end, report:

- JD analysis path used
- submitted snapshot path when the user confirms application completion
- strategy markdown path
- resume Typst/PDF paths
- existing portfolio PDF path when the user needs a submission reference
- prioritized AI-usage portfolio-candidate Markdown path only when the JD explicitly asks for AI-usage evidence or the user explicitly requests it
- verification commands run
- remaining blockers or missing source files

## Failure Rules

- Do not generate tailored documents when company identification is unresolved and the user did not provide enough identity to name the application.
- Do not invent facts, numbers, roles, tools, or outcomes.
- Do not write tailored results back into external document stores unless the user explicitly asks.
- Do not create a separate application-tracker markdown file. Use the presence of a company folder under `workflow/지원후/` as the submitted signal, and use local resume/portfolio markdown files only as fallback snapshots if they already exist.

## Validation

Before claiming success, verify:

- the JD was accessed with an MCP read first, or `browser fallback read` is recorded with its MCP failure/completeness reason
- the Notion Developer source page was accessed through Composio (`NOTION_GET_PAGE_MARKDOWN` preferred) or the connection/access/fallback-staleness limitation was explicitly reported
- every retained experience has a recorded narrow read of its relevant Notion child page, project page, or database record; an unavailable child source is treated as a scope limitation rather than silently filled from a parent summary
- browser automation was not used for the personal Notion Developer source
- if fallback snapshots were used, `db/이력서_원천.md` and `db/포트폴리오_원천.md` exist and their limitation is reported
- `assets/portfolio/` exists when portfolio images are referenced
- the analyzer markdown exists or a provided `analysis_path` exists
- the analyzer markdown has the required 12 sections
- the submitted snapshot exists under `workflow/지원후/` when the user says the application was submitted
- the strategy markdown exists
- the resume Typst file exists when generation was requested
- the final resume Typst/PDF filenames are exactly `박건우_이력서.typ` and `박건우_이력서.pdf` inside the application folder, not company-prefixed names
- no general company-specific portfolio Typst/PDF was generated; AI-usage portfolio Typst/PDF exists only when the JD explicitly asks for AI-usage evidence or the user explicitly requested it
- when an AI-usage portfolio is requested, its candidates are ranked and each candidate contains architecture/code/AI-usage/result/scope fields
- PDFs exist only if `typst compile` succeeded, or an existing PDF was deliberately reused and its path was verified
- final resume/portfolio choices are traceable to analyzer sections 4-8
- the strategy includes a `JD 원문 원자 체크리스트`, and every row is marked `직접 반영`, `축소 반영`, `전략 리스크`, or `제출 제외` with a resume location or omission reason
- if the user supplied additional JD text after initial generation, the checklist and resume were rerun against the latest supplied text
- submitted bullets distinguish candidate-authored work from library/framework/cloud-service capabilities
- generated content does not contain coined or merged technical labels that are not explicitly source-backed, such as `WebSocket Trace`
- any uncertain implementation scope is downgraded or excluded instead of being stated as completed work
- generated resume does not duplicate employer work under the standalone project section
- standalone projects are separated project-by-project instead of grouped under vague education labels
- SKALA is never presented as a major standalone project; include it under education/activity as a separate record, expand its technical evidence when it directly matches the JD, and keep it separate from professional career work
- SKALA web-mini theme words such as public trial, AI judgment, voting, or relationship dispute are not foregrounded unless the JD unusually requires that domain
- 크래프톤 정글 and SKALA are separate education/activity records with exact periods; their detail and order reflect JD relevance. Code Sync is considered for project evidence only when the JD supports its verified frontend/collaboration/API scope
- all Notion projects were reviewed against the JD, and every selected or excluded project has a strategy reason
- education/activity entries are independent, exact-period records in their own section and have at most two bullets each; JD relevance determines their detail/order, not whether the factual record is merged or deleted
- 아티피셜 소사이어티 never appears under career; Toonners is absent from the current resume/portfolio workflow; frontend project evidence is limited to Code Sync/CPPM/프비티 and backend/cloud evidence is based on SKALA/디지엠유닛원
- 스마일게이트 윈터데브 is present only as a one-line education/activity support item for frontend-related JDs and absent from other JD types
- certificates and language information appear as separate, concise dated factual sections when source-verified; JD relevance determines whether they receive additional technical context
- submitted artifacts do not contain defensive meta sections such as `제외 기술`
- awards are dated chronological bullets in an independent `수상` section and do not include `크래프톤 정글 우수 프로젝트 선정`
- every detailed experience bullet and technical stack item has an exact JD-fit mapping or is the verified AI-development exception; factual profile records are retained independently with source/date verification
- the first page contains a fact-based self-introduction within five rendered lines, 3-4 distinct core strengths, strongest role-specific evidence, and one verified AI-development workflow/result
- each submitted bullet passes the same-context problem/decision/result or feature/verified-artifact check, names a source-backed technique where used, and ends in a metric, bounded validation, or concrete deliverable
- every submitted time/performance metric has a measurement card in the strategy and states the measured request/workflow, concrete candidate change, Before→After value, and measurement scope; no vague optimization label stands in for the changed implementation
- every submitted bullet passes the bullet language harness: one source-backed primary action, natural Korean predicate agreement, no stacked noun/technology list, no mixed problem chains, and no awkward connector sequence
- a requested motivation explicitly answers why this company, team, and role from verified company and candidate evidence; it is not interchangeable with another company name
- any user fact corrections made during the turn were reflected in the company artifact, and any needed Notion source update was either performed after explicit request or reported as pending
- `workflow/지원후/` was not modified, regenerated, overwritten, or deleted after submission

If any validation step fails, report the exact missing item and stop short of claiming the full workflow succeeded.
