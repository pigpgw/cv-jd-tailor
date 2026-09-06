---
name: cv-jd-tailor
description: Generate company-tailored Korean resume and portfolio application artifacts from a JD using the user's Notion Developer page as the primary resume/portfolio source and the local application tracker. Use when a JD URL/text/file should produce JD analysis, update application status, and write tailored markdown/Typst/PDF artifacts from verified source facts.
---

# CV JD Tailor

## Purpose

Turn one JD into local application artifacts while keeping reusable source facts grounded in the user's Notion Developer page and application status in this repository.

The JD is provided at invocation time, and base resume/portfolio facts are read from the Notion Developer page first.

## Source of Truth

Use these sources in order:

- Primary resume/portfolio source: Notion `박건우 | Developer`
  - URL: `https://confused-dietician-c17.notion.site/Developer-3c77caa087bd80ff9d73f63aeeebb4d7?pvs=74`
- Local resume snapshot, fallback only: `db/이력서_원천.md`
- Local portfolio snapshot, fallback only: `db/포트폴리오_원천.md`
- Application tracker: `db/지원회사_관리.md`
- Shared portfolio assets: `assets/portfolio/`

Do not treat the local snapshot markdown files as newer than Notion unless the user explicitly says they corrected those files after the Notion page. Do not create duplicate base-source files under company folders. Company folders may contain company-specific tailored artifacts only.

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
- `notion_source_url`
- `resume_snapshot_path`
- `portfolio_snapshot_path`
- `existing_portfolio_pdf`
- `application_tracker_path`
- `output_root`
- `archive_root`

Default values:

- `notion_source_url`: `https://confused-dietician-c17.notion.site/Developer-3c77caa087bd80ff9d73f63aeeebb4d7?pvs=74`
- `resume_snapshot_path`: `db/이력서_원천.md`
- `portfolio_snapshot_path`: `db/포트폴리오_원천.md`
- `existing_portfolio_pdf`: `박건우_포트폴리오.pdf` when available from the current workspace or a user-supplied path
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
- Resolve the Notion source URL, local fallback snapshot paths, and output paths.
- Use the Notion Developer page as the default base resume/portfolio source. Do not silently substitute local markdown snapshots when Notion access is available.
- If `analysis_path` is provided, use it as the JD analysis source and skip fresh analysis.
- Otherwise, run `company-jd-analyzer` and request its output as `workflow/지원전/<company_dir>/<company_dir>_채용분석.md`.
- The analyzer output must use the 12-section Korean structure from `company-jd-analyzer`. If key sections are missing, fix the analysis before generating application documents.

### 2. Read Notion Source

Fetch or otherwise verify the Notion Developer page before writing tailored output.

Rules:

- Treat the Notion Developer page as reusable facts, not final copy.
- Use `db/이력서_원천.md` and `db/포트폴리오_원천.md` only as fallback snapshots when Notion cannot be accessed, or as supporting indexes for locating shared assets.
- If Notion and local snapshots conflict, use Notion unless the user's latest correction explicitly says otherwise.
- Treat `assets/portfolio/` as the shared source for reusable portfolio images such as architecture diagrams, component images, screenshots, diagrams, and logos.
- Rewrite, reorder, and emphasize for JD fit.
- Do not invent facts, numbers, responsibilities, tools, or outcomes missing from the Notion source or user corrections.
- Do not blur multiple experiences into one claim. Never combine separate projects, education assignments, tool usage, or company work so they appear to be one implementation, one causal result, or one job responsibility. A bullet may connect only problem-action-result facts that happened in the same verified context; otherwise split them into separate bullets or keep the weaker item in strategy notes.
- Never confuse what the candidate personally did with what a library, framework, or cloud service provides by default. Use `used`, `integrated`, `configured`, `connected to the UI`, `handled state`, `handled exceptions`, or `verified` when the candidate used an existing capability; reserve `implemented`, `designed`, or `improved` for source-backed code, UX, API contract, data flow, or validation work done by the candidate.
- Do not present team-wide work, framework default behavior, managed-service built-in features, or library internals as personal implementation. When uncertain, write the narrower verified scope or keep the point in the strategy risk notes instead of the submitted artifact.
- Do not invent motivation, intent, problem awareness, beliefs, or causal framing. Phrases like `~라는 문제의식으로` or `~하려는 의도로` require explicit source support from Notion or the user's latest correction.
- Do not copy whole source sections verbatim unless the user explicitly asks for a base document.

If the Notion source cannot be accessed, report that directly. Use local snapshot markdown only if the user allows fallback or if the current task can proceed with an explicit stale-source warning.

Shared asset folders:

- `assets/portfolio/architecture/`: system architecture images and architecture diagrams
- `assets/portfolio/components/`: UI/component images used across portfolio cases
- `assets/portfolio/screenshots/`: reusable product or feature screenshots
- `assets/portfolio/diagrams/`: flow, sequence, data, or process diagrams
- `assets/portfolio/logos/`: company, product, or technology logos when legally usable

When a portfolio case needs an image:

- Prefer an existing shared asset from `assets/portfolio/`.
- Record reusable asset path decisions in Notion when the user asks to update the source; otherwise mention them in the strategy document.
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
- If a source experience is strong in Notion but weak for the JD analysis, downplay or omit it instead of forcing it into the final document.
- If the analysis has `[확인필요]` or weak evidence, do not turn it into a confident resume claim.
- If the analysis and source facts conflict, stop and resolve the conflict against Notion and the user's latest correction before generating final Typst.

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
- whether the JD explicitly requires, optionally accepts, or does not request a portfolio
- whether to reuse `existing_portfolio_pdf` as-is, submit it with a tailored resume only, or generate a new company-specific portfolio
- if reusing an existing portfolio, explain why its project order and evidence already match the JD better than a newly generated company-specific portfolio

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
- `workflow/지원전/<company_dir>/<company_dir>_포트폴리오_박건우.typ` only when the JD requires or benefits from a tailored portfolio

Use existing templates or nearby output patterns only when they exist in the repository. If templates are unavailable, create Typst files with conservative structure and clearly report that the base template was unavailable.

Template selection order:

1. `templates/public/resume.typ` and `templates/public/portfolio.typ` when both exist
2. `workflow/지원전/_shared_application.typ` plus `workflow/지원전/_fixed_portfolio_cases.typ` when available
3. the most recent company folder under `workflow/지원전` that has both resume and portfolio Typst files
4. conservative standalone Typst files as a last resort, with a clear blocker/risk note

Generation rules:

- Keep company-specific tailoring in the company folder.
- Always generate a tailored resume when the application is still open and the company/role are identified.
- For portfolio submission, follow the JD first:
  - if the JD requires a portfolio or project document, provide a portfolio PDF path, either reused or newly generated
  - if the JD only optionally accepts a portfolio, include it only when it strengthens the required competencies
  - if the JD does not ask for a portfolio and the resume already covers the required competencies, do not force a new portfolio
- Prefer reusing `existing_portfolio_pdf` when its existing project order, evidence depth, and required-competency coverage are already stronger than a quick rewrite.
- Generate a new tailored portfolio when the JD's required competencies, preferred qualifications, or submission instructions need a different project order, reduced noise, or role-specific evidence that the existing portfolio does not foreground.
- Do not list JD-required technologies or duties as unsupported personal experience. If another verified experience demonstrates the same underlying competency, rewrite it around that competency and keep the evidence source clear.
- Separate personal work from library/framework/service responsibility in every bullet. For example, Yjs synchronization, Monaco editing behavior, Bedrock Agent trace generation, API Gateway WebSocket transport, SQS queueing, and OpenSearch retrieval are platform/library capabilities; the resume should state the candidate's verified work such as integrating them, defining API/data contracts, rendering progress state, handling edge cases, improving UX, or validating behavior.
- Do not combine separate verified facts into a new technology label. For example, if Bedrock Agent Trace and API Gateway WebSocket are separately verified, do not write `WebSocket Trace`; write only verified units such as `Bedrock Agent Trace`, `API Gateway WebSocket`, or `progress/status UI`.
- Any fact marked as draft, needs confirmation, limited, or uncertain in Notion/local snapshots must not be written as completed implementation. Downgrade it to the confirmed level such as reviewed, designed, PoC, learned, or exclude it.
- Follow the `생각등대` writing guide: each strong bullet should be technically credible but readable, using a problem/reason/implementation/result structure. Avoid opaque internal shorthand and avoid writing only tool names.
- Write in natural Korean that a reviewer can understand on first read. Do not drop internal abbreviations, domain names, or technology names without context. Explain who used the product, what workflow it supported, and what screen/API/state/data flow the candidate worked on.
- Keep the wording accessible without becoming technically shallow. A good bullet should show why the technology was needed, how the candidate integrated or configured it, and what exception handling, state management, performance, security, UX, or validation scope was personally handled.
- Keep the writing natural and modest. Avoid AI-like declarative phrasing such as `증명하겠습니다`, `전환하는 개발자`, or `역량을 보유했습니다`. Prefer fact-based phrasing such as `구현했습니다`, `경험이 있습니다`, `연결해 봤습니다`, or `맡았습니다`.
- Include a `지원동기` section only when the JD/form asks for it or when the company/role naturally connects to the candidate's interests, narrative, and verified experience. Do not force personal storytelling when the connection is weak; omit the section instead. Avoid generic endings such as `기여하고 싶습니다`; state what the candidate can do in the role based on verified experience. Do not include a separate `소개` section unless the JD or application form explicitly asks for a brief self-introduction, 자기소개, or About-style text.
- When writing `지원동기`, the main point is why this specific company. Use source-verified company vision, values, business direction, products/services, and recent signals, then connect them naturally to the candidate's interests, narrative, and verified strengths. Only after that, connect why this team, why this role, and what concrete work the candidate can do there. If the paragraph would still work after replacing the company name, do not use it as motivation.
- Do not write `지원동기` as a JD summary. Phrases equivalent to `역할로 이해했습니다`, `반복 업무와 병목을 이해하고`, or `운영 가능한 솔루션으로 만드는 역할` are weak if they only paraphrase the posting. Briefly identify the company/team/role context, then move quickly to source-backed adjacent work the candidate has done and the concrete work they can perform in that role.
- Treat the first resume page as the interviewer's decision surface. Put the candidate's JD-matched differentiators, strongest career/project evidence, and reason to interview them on page one. Do not waste page one on generic self-introduction or broad technology inventory.
- `핵심 역량` is for the JD's required core competencies only when they can be supported by verified source facts. Do not fill the section with aspirational skills, weak keyword matches, or technologies the candidate has not used. If there are not enough source-backed competencies, make the section shorter or omit it instead of padding it.
- Do not put defensive meta sections or phrases in submitted resumes/portfolios, such as `제외 기술`, `직접 근거가 약해`, or `보유 기술처럼 쓰지 않습니다`. Keep those judgments in the strategy document only; submitted artifacts should simply select verified experiences.
- Keep reusable career facts in the Notion Developer page. Do not create or expand local markdown source files unless the user explicitly asks for a snapshot update.
- In resumes, company work performed during employment must stay under the career section. Do not duplicate LG 공통업무 플랫폼, 프비티, or other employer work under the standalone project section.
- When one employment entry contains multiple products, projects, or workstreams, split them inside the career entry with small subheadings instead of mixing all bullets in one flat list. Keep them under `경력`, not under the standalone project section.
- For 디지엠유닛원, the career entry must be split with visible small subheadings for exactly two workstreams: `LG 공통 업무 플랫폼(CPPM)` and `프비티`. Do not mix CPPM, 프비티, and AI Native Workflow bullets into one flat list. Do not create `AI Native 워크플로우` as a standalone project or case; fold AI Native process evidence into the relevant actual project, usually `프비티`.
- Describe 프비티 from its official site as a franchise-headquarters all-in-one solution. When more context is needed, explain that it integrates membership, order/procurement, inventory, franchisee management, and CRM marketing workflows.
- For every career and standalone project entry, place the tech stack directly under the title, then add a similarly styled smaller/lighter one-sentence description explaining what the product/project is. Readers should understand CPPM, 프비티, Code Sync, or any other name without already knowing the internal context.
- Treat tech stacks as JD-matching evidence, not a full inventory of every tool used. Analyze responsibilities, required qualifications, and preferred qualifications, then list only technologies that directly match the JD or credibly demonstrate an adjacent required competency. If a used technology is unrelated to the JD, omit it or keep it only in a necessary bullet context.
- In resumes, the standalone project section is for non-employment work only, such as personal projects, education final projects, research, or capstone work. Separate each project clearly by project name, period, role, tech stack, and problem-solution-result bullets. Do not merge multiple projects into one vague block.
- Treat SKALA as education, like 크래프톤 정글. Do not create a standalone project named `SKALA 4기 실습`, and do not position ordinary SKALA practice as if it were professional project work.
- Describe SKALA's official identity only as `SK AI Leader Academy`, an AI service development education program, or SW/Data/AI education with team projects. Do not call it a backend/cloud-native course unless an official source explicitly says that.
- Use SKALA only when it directly supports the JD, and usually under `교육/활동` with at most 1-2 bullets. Technical terms such as MSA, Spring Cloud, Kafka, JPA, PostgreSQL, Docker, query tuning, index/execution-plan analysis, transactions, concurrency, tests, and service decomposition may appear only as README/code/execution-backed individual practice evidence, not as an invented official course title.
- Do not emphasize toy/service-theme descriptions from SKALA web-mini such as public trials, AI judges, voting, or relationship-dispute scenarios. If that work is relevant, translate it into concrete engineering evidence such as API design, STOMP/event flow, persistence, query behavior, testing, deployment, or client-server integration.
- Treat 크래프톤 정글 as CS-focused education. It can support operating systems, networks, data structures/algorithms, and software fundamentals. Its final project Code Sync is also a strong frontend/project case, so include Code Sync for most IT roles unless the JD is clearly unrelated or another project is materially stronger.
- Even when Code Sync is selected as a standalone project, keep 크래프톤 정글 itself as a separate education/activity entry when space allows. Limit it to 1-2 computer-science foundation bullets. Prefer Korean phrasing that starts with `주 100시간 이상 전산학을 학습하며`, then mention source-backed topics such as CSAPP, malloc, mmap, Tiny Web Server, and Pintos Thread/User Program/Virtual Memory/File System. Pintos is an educational operating-system assignment, so do not frame it as backend or infrastructure work.
- Do not include 엘리스 or 스마일게이트 윈터데브 by default in resumes or portfolios. Consider them only when the user explicitly asks for them or when a specific JD requires evidence that cannot be covered by stronger verified experiences.
- For the 디지엠유닛원 career role label, adapt the role to the JD: use `Frontend Engineer` for frontend JDs, and `Software Engineer` for fullstack, AI Native, AX, AI service, PI, or Builder-oriented JDs. This rule applies only to the 디지엠유닛원 employment entry. Keep 크래프톤 정글 Code Sync's project role as `Frontend Developer`, while describing the affiliation as a 크래프톤 정글 final project/education outcome.
- Education and activity entries should appear only when they help the current JD. Keep each entry to at most two bullets; if the JD fit is weak, use a short subtitle only or omit the entry.
- Awards should list actual awards only. Do not place "selected project", homepage listing, or internal showcase results under awards unless the source clearly treats them as an award.
- Never include `크래프톤 정글 우수 프로젝트 선정` as an award, achievement, or other submitted item for any JD. Use Code Sync only as a project implementation experience.
- Certifications and language scores should appear in submitted resumes only when the JD explicitly requires or prefers them. If the JD does not mention them, omit SQLD, OPIc, and similar credentials from the submitted artifact.
- Awards, when included, must be chronological bullets with dates. Do not compress unrelated awards into one comma-separated row.
- Keep army service as a short education/activity item when relevant or when preserving the user's standard profile. Use only verified facts such as signal soldier and peer counselor; do not expand it into telecom equipment development or embedded experience.
- Include Artificial Society as a short-term internship in education/activity when space allows. Use the period `2024.02.07~2024.02.25`, describe it as a 3-week internship supporting model performance improvement for an AI eye-tracking service, and avoid broad labels such as generic data support. Mention Data Augmentation or EasyOCR quality improvement support only when that detail is needed and source-backed.
- Links should be attached to meaningful text, such as the project name, award name, official page label, or `[GitHub]`; do not append raw-looking links at sentence ends.
- When the user corrects a reusable fact, update the Notion source when explicitly asked; otherwise reflect it in the generated company artifact and report that the source still needs a Notion update.
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
- portfolio decision and Typst/PDF paths when created or reused
- verification commands run
- remaining blockers or missing source files

## Failure Rules

- Do not generate tailored documents when company identification is unresolved and the user did not provide enough identity to name the application.
- Do not invent facts, numbers, roles, tools, or outcomes.
- Do not write tailored results back into external document stores unless the user explicitly asks.
- Do not create duplicate application tracker rows.
- Do not create new base-source markdown files. Use `db/지원회사_관리.md` for local application tracking only, and use local resume/portfolio markdown files only as fallback snapshots if they already exist.

## Validation

Before claiming success, verify:

- the Notion Developer source page was accessed or the fallback/staleness limitation was explicitly reported
- if fallback snapshots were used, `db/이력서_원천.md` and `db/포트폴리오_원천.md` exist and their limitation is reported
- `db/지원회사_관리.md` exists
- `assets/portfolio/` exists when portfolio images are referenced
- the analyzer markdown exists or a provided `analysis_path` exists
- the analyzer markdown has the required 12 sections
- the tracker has no duplicate row for the same application key
- the strategy markdown exists
- the resume Typst file exists when generation was requested
- the portfolio Typst file exists only when a tailored portfolio was requested or judged necessary
- PDFs exist only if `typst compile` succeeded, or an existing PDF was deliberately reused and its path was verified
- final resume/portfolio choices are traceable to analyzer sections 4-8
- submitted bullets distinguish candidate-authored work from library/framework/cloud-service capabilities
- generated content does not contain coined or merged technical labels that are not explicitly source-backed, such as `WebSocket Trace`
- any uncertain implementation scope is downgraded or excluded instead of being stated as completed work
- generated resume does not duplicate employer work under the standalone project section
- standalone projects are separated project-by-project instead of grouped under vague education labels
- SKALA is not presented as a major standalone project unless the user explicitly approves; if used, it appears as education/activity or narrow technical evidence with at most 1-2 bullets
- SKALA web-mini theme words such as public trial, AI judgment, voting, or relationship dispute are not foregrounded unless the JD unusually requires that domain
- 크래프톤 정글 is treated as CS-focused education, and Code Sync is considered as a strong frontend project case for most IT applications
- 엘리스 and 스마일게이트 윈터데브 are excluded by default
- education/activity entries are JD-relevant and have at most two bullets each
- certifications/language scores are omitted unless explicitly required or preferred by the JD
- submitted artifacts do not contain defensive meta sections such as `제외 기술`
- awards are dated chronological bullets and do not include `크래프톤 정글 우수 프로젝트 선정`
- any user fact corrections made during the turn were reflected in the company artifact, and any needed Notion source update was either performed after explicit request or reported as pending

If any validation step fails, report the exact missing item and stop short of claiming the full workflow succeeded.
