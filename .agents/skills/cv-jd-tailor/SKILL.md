---
name: cv-jd-tailor
description: Generate company-tailored Korean resume and portfolio application artifacts from a JD using the user's Notion Developer page as the primary resume/portfolio source. Use when a JD URL/text/file should produce JD analysis and write tailored markdown/Typst/PDF artifacts from verified source facts.
---

# CV JD Tailor

## Purpose

Turn one JD into local application artifacts while keeping reusable source facts grounded in the user's Notion Developer page and using the pre-submission/submitted folder boundary defined by the project instructions.

The JD is provided at invocation time, and base resume/portfolio facts are read from the Notion Developer page first.

## Boundary With AGENTS.md

- `AGENTS.md` owns repository-wide source precedence, safety boundaries, archive immutability, file placement, and minimum validation.
- This skill owns only JD analysis, evidence selection, resume/portfolio composition, application-specific artifact generation, and tailoring QA. Do not duplicate or redefine repository-wide policy here.
- Before generating, apply the evidence gate: map every selected claim to Notion, a user's latest correction, or verified code/README/execution evidence. A user request cannot turn an unsupported fact, metric, role, or causal link into a submitted claim; narrow, label, or exclude it and record the reason in strategy notes.
- After generating, run a contradiction and leakage check: compare selected projects, roles, dates, metrics, technologies, and outcomes against the source, and verify that no rejected or unverified claim entered the final artifact. Do not report completion until this check passes.

## Source of Truth

For the reusable project evidence schema and code-review procedure, read [references/project-evidence-schema.md](references/project-evidence-schema.md) whenever a project is being newly documented, a repository is being inspected, or project selection is being redesigned.

Use these sources in order:

- Primary resume/portfolio source: Notion `박건우 | Developer`
  - URL: `https://confused-dietician-c17.notion.site/Developer-3c77caa087bd80ff9d73f63aeeebb4d7?pvs=74`
- Local resume snapshot, fallback only: `db/이력서_원천.md`
- Local portfolio snapshot, fallback only: `db/포트폴리오_원천.md`
- Shared portfolio assets: `assets/portfolio/`

Do not treat the local snapshot markdown files as newer than Notion unless the user explicitly says they corrected those files after the Notion page. Do not create duplicate base-source files under company folders. Company folders may contain company-specific tailored artifacts only.

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
- `workflow/지원전/<application_dir>/<application_dir>_이력서_박건우.typ`
- `workflow/지원전/<application_dir>/<application_dir>_포트폴리오_후보.md` only when the JD explicitly asks for AI-usage evidence or the user explicitly requests a tailored AI-usage portfolio
- matching resume PDF beside the Typst file when Typst rendering is available

Use `workflow/지원후/<application_dir>/` as the immutable snapshot of files submitted at that time. Never edit, regenerate, overwrite, or delete anything under `workflow/지원후/` after submission, including when the source DB, skill rules, or `workflow/지원전/` are corrected. The existence of a submitted application folder is the application-status signal; do not create or update a separate application-tracker document. All content corrections belong in the source DB, shared instructions, or `workflow/지원전/`. A later application must create a new pre-submission artifact rather than changing the archived copy.

Derive `application_dir` as `{company_name}_{jd_identifier}`. Prefer the official posting ID, a unique ID in the source URL, or a user-provided identifier. If no identifier exists, use a short normalized role slug as the suffix; do not append a random hash. Reuse an existing directory for the same company and JD instead of creating a duplicate.

## Workflow

### 1. Normalize the Request

- Read the JD input first.
- Resolve the Notion source URL, local fallback snapshot paths, and output paths.
- Use the Notion Developer page as the default base resume/portfolio source. Do not silently substitute local markdown snapshots when Notion access is available.
- If `analysis_path` is provided, use it as the JD analysis source and skip fresh analysis.
- Otherwise, run `company-jd-analyzer` and request its output as `workflow/지원전/<application_dir>/<application_dir>_채용분석.md`.
- The analyzer output must use the 12-section Korean structure from `company-jd-analyzer`. If key sections are missing, fix the analysis before generating application documents.

### 2. Read Notion Source

Fetch or otherwise verify the Notion Developer page before writing tailored output.

Rules:

- Treat the Notion Developer page as reusable facts, not final copy.
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
- Do not reduce the JD to a handful of generic keywords. Split every explicit responsibility, qualification, and preferred qualification into an itemized coverage list and label each item `direct evidence`, `adjacent evidence`, or `no evidence` before writing the resume.
- Every qualification or preferred qualification with direct evidence must appear in a natural resume bullet using the JD's wording where truthful. Adjacent evidence must be clearly narrowed to the verified contact point. No-evidence items must be excluded from submitted claims and recorded only as a strategy risk.

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
- `[명시]`, `[최근근거]`, `[추정]`, `[확인필요]` 라벨 유지
- 직접 매칭, 축소 반영, 미커버 리스크 구분
- why each selected resume/portfolio item belongs in the final output
- which attractive DB items were intentionally excluded because the analysis does not support them strongly enough
- a requirement coverage table with one row per explicit responsibility, qualification, and preferred qualification, including evidence level and the exact resume/strategy location where it is handled

Inside `# 맞춤 이력서`, include:

- 상단 지원동기 방향
- 자기소개 방향
- 핵심 역량
- 경력
- 프로젝트
- 제외하거나 축소할 근거

Inside `# 포트폴리오 제출 메모`, record whether the JD asks for a general portfolio or explicitly asks for AI-usage evidence. For a general portfolio request, point to the user's separately managed existing PDF and do not generate a company-specific general portfolio. Only when the JD explicitly asks for AI-usage evidence, or the user explicitly requests it in the current task, create a tailored AI-usage portfolio candidate list and PDF/Typst covering verified AI workflows, prompts, Skills, Agent MD, human review, verification, and harness improvement.

Inside `# 제출 파일 메모`, include the final resume and portfolio paths and whether the company folder is pre-submission or submitted.

Inside `# 조정 메모`, include:

- 이 JD에서 특히 강한 카드 3개
- 축소하거나 제거한 요소와 이유
- 최종 문서에서 확인해야 할 리스크

### 6. Generate Tailored Files

Create or update:

- `workflow/지원전/<application_dir>/<application_dir>_이력서_박건우.typ`
- `workflow/지원전/<application_dir>/<application_dir>_포트폴리오_박건우.typ` only when the JD explicitly requires AI-usage evidence or the user explicitly requests a tailored AI-usage portfolio; never generate a general tailored portfolio by default

Use existing templates or nearby output patterns only when they exist in the repository. If templates are unavailable, create Typst files with conservative structure and clearly report that the base template was unavailable.

Template selection order:

1. `templates/public/resume.typ` and `templates/public/portfolio.typ` when both exist
2. `workflow/지원전/_shared_application.typ` plus `workflow/지원전/_fixed_portfolio_cases.typ` when available
3. the most recent company folder under `workflow/지원전` that has both resume and AI-usage portfolio Typst files, only when an AI-usage portfolio is being generated
4. conservative standalone Typst files as a last resort, with a clear blocker/risk note

Generation rules:

- Keep company-specific tailoring in the company folder.
- Always generate a tailored resume when the application is still open and the company/role are identified.
- Before finalizing the resume, run a requirement-coverage pass against every explicit JD responsibility, qualification, and preferred qualification. Do not declare the application artifact ready while a directly supported requirement is missing from the resume.
- After generation, run a separate artifact-integrity pass. Compare the final resume against the strategy and analysis: the selected core-capability labels and ordering must match the strategy exactly, every retained project/activity must have a JD-fit reason, and no inherited item from a generic/base resume may remain unless the strategy explicitly retains it. Treat any mismatch as a failed generation requiring correction, not as a cosmetic review note.
- The final pass must also check for stale or contradictory claims by searching the generated source for excluded activities, unsupported JD keywords, duplicate work/project descriptions, and strategy items that do not appear in the artifact. Report the exact mismatch before claiming readiness.
- Do not generate a tailored general portfolio PDF, Typst, or candidate list. When a JD asks for a general portfolio, provide the user's separately managed existing `existing_portfolio_pdf` path for submission. Create an AI-usage candidate list and AI-usage portfolio artifact only when the JD explicitly asks for AI-usage evidence or the user explicitly requests a tailored AI-usage portfolio in the current task.
- The portfolio candidate Markdown must rank 3-6 cases by JD fit. For every case, write: `JD requirement -> verified experience -> problem/constraint -> architecture/data flow -> code or prompt/tool detail -> result/validation -> scope caveat`. Use concrete code-level details when verified, such as API contracts, queue/worker boundaries, event/state handling, retries, pagination, sanitization, prompt instructions, agent routing, approval gates, or test commands. Do not turn the candidate list into a polished portfolio or invent missing implementation details.
- Do not list JD-required technologies or duties as unsupported personal experience. If another verified experience demonstrates the same underlying competency, rewrite it around that competency and keep the evidence source clear.
- Extract the exact evaluation words from every JD responsibility, qualification, and preferred qualification. Build a mapping of `JD wording -> verified source fact -> candidate-owned action -> resume location`. For every item with direct evidence, reuse the JD wording naturally in a bullet or core-capability statement; for adjacent evidence, use a narrower truthful equivalent; for no evidence, exclude the term rather than keyword-stuffing.
- Never hard-code a universal project priority. Recompute the project set for each JD from the evidence records: select one or more projects only when each contributes a distinct or stronger match, prefer the smallest non-redundant set that covers the important requirements, and record the chosen projects and order only in that company's strategy file. A new project must become eligible through the same evidence schema without changing this skill.
- When repository evidence is needed, inspect the full history and candidate-authored changes before writing portfolio or resume claims. Store reusable code evidence as repository/file/function/commit references and concise implementation summaries; do not copy whole repositories or attribute teammate-owned features to the candidate.
- Separate personal work from library/framework/service responsibility in every bullet. For example, Yjs synchronization, Monaco editing behavior, Bedrock Agent trace generation, API Gateway WebSocket transport, SQS queueing, and OpenSearch retrieval are platform/library capabilities; the resume should state the candidate's verified work such as integrating them, defining API/data contracts, rendering progress state, handling edge cases, improving UX, or validating behavior.
- For CPPM's real-time Agent status work, lead with the user-visible change: convert `Bedrock Agent Trace` events such as search, Knowledge Base retrieval, and Action Group calls into user-friendly processing steps, then deliver them to the screen through `Amazon API Gateway WebSocket APIs` as a progress-status UI. Do not describe this as exposing internal logs. Describe `Amazon CloudWatch` separately as the tool used to analyze and validate Agent routing and Lambda/OpenSearch error flows.
- For CPPM's waiting-experience improvement, keep the causes and outcomes distinct. The OpenSearch Agent could retry with similar search terms or different periods, or answer as if data existed, when its verification query returned no results. Describe the verified control as a validation prompt with explicit no-result, retry-limit, and error-termination conditions. The prompt and Agent flow initially made responses long; prompt simplification/lightening and flow adjustment reduced the average response from about 2 minutes to about 1 minute 10 seconds. The graph-code generation, execution, S3 storage, and link delivery flow was working; separately, because completion time was not predictable enough for a reliable percentage or remaining-time estimate, convert search, Knowledge Base retrieval, and Action Group Trace events into user-friendly real-time processing steps. If no measured abandonment-rate reduction exists, write only that it contributed to reducing abandonment inquiries.
- Do not combine separate verified facts into a new technology label. For example, if Bedrock Agent Trace and API Gateway WebSocket are separately verified, do not write `WebSocket Trace`; write only verified units such as `Bedrock Agent Trace`, `API Gateway WebSocket`, or `progress/status UI`.
- Any fact marked as draft, needs confirmation, limited, or uncertain in Notion/local snapshots must not be written as completed implementation. Downgrade it to the confirmed level such as reviewed, designed, PoC, learned, or exclude it.
- Follow the `생각등대` writing guide: each strong bullet should be technically credible but readable, using a problem/reason/implementation/result structure. Avoid opaque internal shorthand and avoid writing only tool names.
- Treat the resume as a decision document for getting an interview, not a career archive. The first 10-15 second scan should show role fit, the strongest practical evidence, technical depth, and no risky overclaims.
- Bullets should show what changed because of the candidate, not just what they were responsible for. Prefer scope, numbers, user/business impact, or validation results; when production metrics are unavailable, use verifiable scope such as code size, API count, constraints, processing time, UI/state/exception coverage, or test coverage.
- Apply the shared `생각등대` rules: select only experience directly connected to the JD's responsibilities, qualifications, and preferred qualifications; make the first page immediately show the candidate's differentiating strength and strongest evidence; do not pad the resume with every known experience.
- Review verified AI-tool usage for every JD, not only AI-role JDs. Include it briefly only when the actual tool, context, candidate-owned review, and JD connection are evidenced; never use `AI 활용` as an unsupported standalone keyword.
- Default bullet structure is `problem or constraint -> candidate-owned technique/judgment -> result or impact`. The cause may be omitted for space, but end with a metric or a concrete deliverable. Prefer `Before -> After`; if no metric exists, use a verifiable outcome such as consistency, error-state handling, or a completed screen/artifact.
- Name the applied method or tool specifically: write `MySQL EXPLAIN + index tuning` instead of generic performance improvement, `optimistic/pessimistic lock` instead of generic concurrency handling, and `AWS CI/CD + S3 integration` instead of generic cloud deployment. Framework-only bullets must include the contribution target and resulting artifact.
- For CPPM realtime communication, distinguish the AWS service, delivery call, and transport: `Amazon API Gateway WebSocket APIs` is the managed AWS service providing WebSocket connections, `API Gateway Management API`'s `PostToConnection` is the Worker Lambda delivery call, and `WebSocket` is the communication mechanism. Write `Amazon API Gateway WebSocket APIs integration limit` for the constraint and `delivered to the WebSocket connection through PostToConnection` for Trace delivery instead of using the ambiguous label `WebSocket API`.
- When evidence spans several projects and professional work, prefer a scope-oriented label such as `RESTful API 설계·개발·연동` over a technology-list label. In the core capability, explain in one or two natural Korean sentences that the candidate designed, developed, and connected RESTful APIs, then connected differing data structures and state flows to frontend features covering retrieval/storage, search, asynchronous work, and exception handling. Put concrete stacks and project-specific evidence in the experience bullets, and never make separate projects appear to be one implementation.
- Feature bullets may use `standard/protocol or technology -> feature -> user-visible change`; infrastructure bullets may use `cloud service -> connected flow -> deployment/operation artifact`. Keep `problem -> solution -> result` readable within one bullet, using an arrow only when it improves scanability.
- Design visual hierarchy as part of bullet writing: keep one problem/action/result chain per bullet, usually within 1-2 sentences, and normally bold only the metric/deliverable plus one key result phrase, with no more than 1-2 emphasized spans per bullet. Do not bold full problem clauses, every technology name, or every sentence; the first scan should reveal the result and the candidate's contribution.
- When useful, order a project entry as `period -> JD-relevant tech stack -> team/role -> one-sentence service overview -> evidence bullets`. Keep the overview to one sentence and put detailed problem, judgment, implementation, and impact in the bullets. Tech stack lines are evidence for the JD, not a complete inventory.
- Apply these shared expression patterns when selecting or rewriting capabilities: `API/data integration` should foreground the user flow completed across backends and external APIs; `state/realtime UI` should foreground how users understood and continued their work; `performance/data` should foreground the observed bottleneck, analysis method, and Before/After; `AI/Agent` should foreground the operational constraint, Agent structure, and user-visible result; `AI Native/SDD` should foreground changing requirements, documentation/harness updates, human review, and the improvement loop. If a capability still reads as a parallel technology list, rewrite it around the outcome.
- For cross-project capabilities, state the shared outcome first, name the contributing projects, and leave project-specific implementation and metrics in their own experience bullets. Never merge APIs, state management, or performance figures from separate projects into one implied service or causal result.
- Do not use broad phrases such as `AX 전환에 기여`, `operationalized`, or `architecture design` by themselves. Attach concrete source-backed evidence such as multi-agent flow, progress/status UI, API/data flow, SQS asynchronous processing, secret/key separation, search UX, or other candidate-owned implementation details.
- Write in natural Korean that a reviewer can understand on first read. Do not drop internal abbreviations, domain names, or technology names without context. Explain who used the product, what workflow it supported, and what screen/API/state/data flow the candidate worked on.
- Apply a user-first explanation pattern to every generated artifact, not only AI or CPPM cases: start with the user-visible or business-relevant change, then explain the problem and constraints, the candidate's decision and implementation, the technical mechanism, and the measured or observed result. A reader without the project's technical context should understand the situation and the candidate's contribution from the first sentence.
- Do not use technology names as standalone claims. Explain why the technology was used and what changed, such as `장시간 작업이 요청 제한으로 끊기지 않도록 SQS로 작업을 분리` or `처리 단계를 사용자 화면에 실시간으로 보여 주기 위해 API Gateway WebSocket으로 이벤트를 전달`. Apply this rule consistently to resume bullets, capability sections, cover letters, motivation answers, portfolio cases, and activity descriptions.
- Keep the wording accessible without becoming technically shallow. A good bullet should show why the technology was needed, how the candidate integrated or configured it, and what exception handling, state management, performance, security, UX, or validation scope was personally handled.
- Keep the writing natural and modest. Avoid AI-like declarative phrasing such as `증명하겠습니다`, `전환하는 개발자`, or `역량을 보유했습니다`. Prefer fact-based phrasing such as `구현했습니다`, `경험이 있습니다`, `연결해 봤습니다`, or `맡았습니다`.
- For verified specification-driven work, show the full chain rather than only the final result: clarify changing requirements and unfamiliar domain information in documents, define API/directory/account-management rules and validation criteria, improve the SDD document plus Codex harness/prompts as gaps are found, human-review the generated code against the specification, and then describe the resulting service separation and implementation.
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
- Include a visible Architecture/Flow block for each major portfolio case. If reusable image assets exist under `assets/portfolio`, use them. If no image assets exist, create a Typst text diagram with boxes/grids, for example `Frontend -> API Gateway WebSocket -> Lambda -> Bedrock Agent -> SQS/DynamoDB/S3`.
- Describe AI usage methods without overstating ownership. For DGM UnitOne common capability, use Figma MCP, Cursor, Codex, and Skills only in the verified context of publishing, technical research, PoC, and documentation workflow; include Plan-First Workflow, Human Approval Gate, Researcher/Planner/Reviewer role separation, and prompt/logging structure when relevant. Do not confuse AI-generated output with candidate-owned implementation and verification.
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
- For DGM UnitOne common capability, use these as candidates for AI/AX/FDE/automation/developer-productivity JDs: `AI를 개발 프로세스에 도입해 퍼블리싱, 기술 조사, PoC, 문서화 과정을 표준화`, `Plan-First Workflow`, `Human Approval Gate`, `Researcher·Planner·Reviewer 역할 분리`, `프롬프트 및 로깅 체계`, and `반복 퍼블리싱 작업 시간 4시간 -> 30분(87% 단축)`. In submitted artifacts, use only the one most JD-relevant point and keep it short.
- For CPPM, use these as candidates for AI/AX/FDE/fullstack/AWS/workflow-automation JDs: `Agent Trace 기반 실시간 작업 단계 UI`, `싱글톤 기반 AgentEventManager`, `requestAnimationFrame 기반 렌더링 제어`, `debounce 300ms`, `LastEvaluatedKey 기반 페이지네이션`, `Lambda 환경변수 기반 API Key 격리`, `DOMPurify 기반 Sanitization`, `Master -> Supervisor -> OpenSearch·Graph Agent 3계층 Multi-Agent 아키텍처`, `Amazon Bedrock Knowledge Base(RAG)`, `CloudWatch 로그 분석`, and `Graph Agent 기반 서버리스 시각화 파이프라인`.
- Do not paste the long CPPM/FBITI candidate list wholesale. Deduplicate overlapping claims and select only 3-5 bullets that match the JD's qualification/preferred-qualification signals. Merge repeated security wording into one API-key/XSS bullet, and repeated DynamoDB debounce/pagination wording into one data-query bullet.
- Strong wording such as `ERD 설계부터 RESTful API 설계 및 개발까지 전담` requires source or latest-user confirmation. Use the correct spelling `RESTful API` in submitted artifacts.
- Do not put defensive meta sections or phrases in submitted resumes/portfolios, such as `제외 기술`, `직접 근거가 약해`, or `보유 기술처럼 쓰지 않습니다`. Keep those judgments in the strategy document only; submitted artifacts should simply select verified experiences.
- Preserve visible tildes in all range expressions. In Typst body text, a raw `~` can render as spacing instead of a visible tilde, so write ranges as escaped tildes such as `1\~2분`, `3\~5주`, and `2024.02.07\~2024.02.25`. Do not silently replace range tildes with spaces or hyphens.
- Keep reusable career facts in the Notion Developer page. Do not create or expand local markdown source files unless the user explicitly asks for a snapshot update.
- In resumes, company work performed during employment must stay under the career section. Do not duplicate CPPM, 프비티, or other employer work under the standalone project section.
- When one employment entry contains multiple products, projects, or workstreams, split them inside the career entry with small subheadings instead of mixing all bullets in one flat list. Keep them under `경력`, not under the standalone project section.
- For 디지엠유닛원, the career entry must be split with visible small subheadings for exactly two workstreams: `LG 전 계열사가 사용하는 공통업무 플랫폼(CPPM)` and `프비티`. Do not mix CPPM, 프비티, and AI Native Workflow bullets into one flat list. Do not create `AI Native 워크플로우` as a standalone project or case; fold AI Native process evidence into the relevant actual project, usually `프비티`.
- For CPPM project/product descriptions, preserve the user-corrected factual wording `LG 전 계열사가 사용하는 공통업무 플랫폼`. For self-introductions, resume headlines, top positioning statements, and motivation sections, avoid the client company name and use wrapped wording such as `대기업 모든 계열사가 사용하는 공통업무 플랫폼`, `외부 LLM 사용이 제한된 환경의 AI 업무지원 기능`, or `AI Agent 기반 업무지원 기능`. Do not use the awkward/incorrect wording `대기업 계열사 공통 업무 플랫폼`. Do not shrink CPPM into a small internal AI-support feature; describe AI work as the candidate's feature area inside that platform.
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
- In resumes, keep `경력`, `주요 프로젝트`, `교육 및 활동`, `수상`, `병역`, and `학력` as separate sections. The standalone project section is for non-employment work only, such as personal projects, education final projects, research, or capstone work. Never merge bootcamp/education history, awards, military service, or academic history into a vague project block.
- Treat SKALA as education, like 크래프톤 정글. Do not create a standalone project named `SKALA 4기 실습`, and do not position ordinary SKALA practice as professional project work.
- Use 스마일게이트 윈터데브 only for frontend-related JDs, as one short supporting line under `교육 및 활동`. Omit it for other JD types and never place it ahead of the mandatory SKALA/크래프톤 정글 education entries for IT/AI JDs.
- Describe SKALA's official identity only as `SK AI Leader Academy`, an AI service development education program, or SW/Data/AI education with team projects. Do not call it a backend/cloud-native course unless an official source explicitly says that.
- For IT- or AI-related JDs, always include SKALA under `교육 및 활동`; for other JDs, include it only when directly relevant. Keep it to at most 1-2 bullets. Never use vague progress wording such as `개별 과제 코드를 정리하고 있습니다` or `배우고 있습니다`. Technical terms such as MSA, Spring Cloud, Kafka, JPA, PostgreSQL, Docker, query tuning, index/execution-plan analysis, transactions, concurrency, tests, and service decomposition may appear only as README/code/execution-backed implementation, analysis, or performance evidence, not as an invented official course title.
- Do not emphasize toy/service-theme descriptions from SKALA web-mini such as public trials, AI judges, voting, or relationship-dispute scenarios. If that work is relevant, translate it into concrete engineering evidence such as API design, STOMP/event flow, persistence, query behavior, testing, deployment, or client-server integration.
- Treat 크래프톤 정글 as CS-focused education. For IT- or AI-related JDs, always include it under `교육 및 활동`; for other JDs, include it only when directly relevant. Its final project Code Sync is a separate project evidence record and is selected only when the current JD supports it. Keep the education entry separate from Code Sync, usually as one computer-science foundation bullet starting with `주 100시간 이상 전산학을 학습하며`. Pintos is not a tech stack item or backend/infrastructure work.
- For the 디지엠유닛원 career role label, adapt the role to the JD: use `Frontend Engineer` for frontend JDs, and `Software Engineer` for fullstack, AI Native, AX, AI service, PI, or Builder-oriented JDs. This rule applies only to the 디지엠유닛원 employment entry. Keep 크래프톤 정글 Code Sync's project role as `Frontend Developer`, while describing the affiliation as a 크래프톤 정글 final project/education outcome.
- Education and activity entries should appear when they help the current JD; SKALA and 크래프톤 정글 are mandatory in this section for IT- or AI-related JDs. Keep each entry to at most two bullets. Do not put education, awards, military service, or academic history under `경력` or `주요 프로젝트`.
- Awards should list actual awards only. Do not place "selected project", homepage listing, or internal showcase results under awards unless the source clearly treats them as an award.
- Never include `크래프톤 정글 우수 프로젝트 선정` as an award, achievement, or other submitted item for any JD. Use Code Sync only as a project implementation experience.
- For Code Sync, prefer quantified implementation impact over a generic feature list when the JD values frontend, performance, collaboration, or product improvement. Candidate evidence includes GitHub API calls `44 -> 22`, initial JavaScript bundle `1,820KB -> 99KB`, PR-review discomfort responses `50 -> 5`, and weekly team PR comments `285 -> 89`. Use the survey, comment, and bundle figures only with their measurement scope/conditions, and phrase them as measured records or contribution rather than unsupported sole causation.
- For Code Sync's initial-loading performance bullet, preserve the causal distinction: the issue was the SPA loading code for unused screens during the initial entry, not the mere use of multiple libraries. Explain the structure, then the Route-level code splitting, lazy loading, or `React.lazy` implementation, and then the measured bundle result. Do not write that the libraries themselves caused the slowdown.
- Prefer the user's "생각등대" bullet pattern for compact resume writing: `[domain/feature] + [problem] + [-> solution technique] + [-> quantified result or concrete deliverable]`. Use arrows or concise connectors to expose the problem-to-decision-to-result chain, and never replace that chain with a technology-only list.
- Review additional Code Sync evidence when relevant: BlockNote and Excalidraw/DrawBoard integrated into the same Yjs session, `html-to-image` editor-image sharing, commit-SHA-based PR file retrieval, and outdated-comment handling. Keep Code Sync as the final project of 크래프톤 정글 and separate it from 디지엠유닛원 employment.
- Certifications should appear in submitted resumes only when the JD explicitly requires or prefers them. If the JD does not mention them, omit SQLD and similar credentials from the submitted artifact.
- When a JD explicitly mentions SQL or SQLD, include SQLD and connect it to verified SQL evidence such as SKALA PostgreSQL execution-plan analysis, index/Materialized View changes, and measured query improvement. If SQL is not requested, omit SQLD.
- Artificial Society is never a career entry. For AI/ML/computer-vision JDs, it may appear only as a separate education/activity item when its verified scope is useful; keep the scope truthful: model-performance improvement support, Data Augmentation, and OCR-quality work, not ownership of an entire production model or service.
- Language information is a user-requested default trust signal. Include it briefly in the bottom `수상 및 어학` section as `2026.07.01 OPIc IM2`. Do not include the certificate number or unverified expiration date in submitted resumes.
- Awards must remain in submitted resumes as factual bottom information even when university projects are not used as core competencies or representative projects. Write them as chronological bullets: `2023.07 ICICT 2023 치앙마이 포스터상`, `2023.08 조선대학교 IT융합대학 캡스톤디자인 경진대회 은상`, and `2024.02 총장배 모범상`. Do not add project explanations, award criteria, or winner-scope details when the source marks them as 확인필요.
- Awards, when included, must be chronological bullets with dates. Do not compress unrelated awards into one comma-separated row.
- Always include army service as a short education/activity item in every submitted resume, regardless of JD fit. Use only verified facts such as signal soldier and peer counselor; do not expand it into telecom equipment development or embedded experience.
- Keep Artificial Society only as a separate activity evidence record. Never place it under career. Include it only when the JD directly benefits from its verified AI eye-tracking, model-performance, data-augmentation, or OCR scope; use the Developer Notion source period `2022.07.04~2022.07.22` and avoid broad labels such as generic data support.
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

Run `typst compile` for both Typst files and write PDFs beside them.

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

- the Notion Developer source page was accessed or the fallback/staleness limitation was explicitly reported
- if fallback snapshots were used, `db/이력서_원천.md` and `db/포트폴리오_원천.md` exist and their limitation is reported
- `assets/portfolio/` exists when portfolio images are referenced
- the analyzer markdown exists or a provided `analysis_path` exists
- the analyzer markdown has the required 12 sections
- the submitted snapshot exists under `workflow/지원후/` when the user says the application was submitted
- the strategy markdown exists
- the resume Typst file exists when generation was requested
- no general company-specific portfolio Typst/PDF was generated; AI-usage portfolio Typst/PDF exists only when the JD explicitly asks for AI-usage evidence or the user explicitly requested it
- when an AI-usage portfolio is requested, its candidates are ranked and each candidate contains architecture/code/AI-usage/result/scope fields
- PDFs exist only if `typst compile` succeeded, or an existing PDF was deliberately reused and its path was verified
- final resume/portfolio choices are traceable to analyzer sections 4-8
- submitted bullets distinguish candidate-authored work from library/framework/cloud-service capabilities
- generated content does not contain coined or merged technical labels that are not explicitly source-backed, such as `WebSocket Trace`
- any uncertain implementation scope is downgraded or excluded instead of being stated as completed work
- generated resume does not duplicate employer work under the standalone project section
- standalone projects are separated project-by-project instead of grouped under vague education labels
- SKALA is never presented as a major standalone project; for IT/AI JDs it appears under education/activity, and its technical evidence remains separate from professional career work
- SKALA web-mini theme words such as public trial, AI judgment, voting, or relationship dispute are not foregrounded unless the JD unusually requires that domain
- for IT/AI JDs, 크래프톤 정글 and SKALA appear under education/activity; Code Sync is considered for project evidence only when the JD supports its verified frontend/collaboration/API scope
- all Notion projects were reviewed against the JD, and every selected or excluded project has a strategy reason
- education/activity entries are in their own section, have at most two bullets each, and include SKALA plus 크래프톤 정글 for IT/AI JDs
- Artificial Society never appears under career; Toonners is absent from the current resume/portfolio workflow; frontend project evidence is limited to Code Sync/CPPM/프비티 and backend/cloud evidence is based on SKALA/디지엠유닛원
- 스마일게이트 윈터데브 is present only as a one-line education/activity support item for frontend-related JDs and absent from other JD types
- certifications are omitted unless explicitly required or preferred by the JD, while the user-approved `2026.07.01 OPIc IM2` language entry is preserved
- submitted artifacts do not contain defensive meta sections such as `제외 기술`
- awards are dated chronological bullets and do not include `크래프톤 정글 우수 프로젝트 선정`
- any user fact corrections made during the turn were reflected in the company artifact, and any needed Notion source update was either performed after explicit request or reported as pending
- `workflow/지원후/` was not modified, regenerated, overwritten, or deleted after submission

If any validation step fails, report the exact missing item and stop short of claiming the full workflow succeeded.
