# Candidate Record Rules

These are reusable classification and wording boundaries for this candidate. The canonical Notion record and the user's latest correction still outrank this file.

## Experience Classification

### 디지엠유닛원

- Classify as employment experience.
- Keep 프비티 and the internal-work chatbot/CPPM context inside the employment record; do not duplicate them as independent personal projects.
- Generalize customer names and non-public internal identifiers when disclosure scope is uncertain.
- State only the candidate's verified implementation, integration, validation, documentation, or collaboration scope.

### CPPM and agent work

- Keep the two outcomes causally separate:
  - Trace/progress UI: let users see that a long-running task was proceeding; may be described as reducing perceived waiting burden or contributing to fewer abandonment-related inquiries only when the source supports that outcome.
  - response time reduction: approximately 2 minutes to approximately 1 minute 10 seconds, caused by prompt lightening and agent-flow adjustment—not by the progress UI.
- Amazon Bedrock Agents console configuration may support `설계·구성·검증` when that is the verified action. Do not imply that the candidate authored the managed service itself.
- Distinguish PoC feasibility checks, production implementation, and later learning. Do not collapse them into one completed production claim.

### Code Sync and 크래프톤 정글

- Code Sync is the final team project of 크래프톤 정글 and remains separate from employment experience.
- Classify 크래프톤 정글 as intensive education/training focused on computer-science foundations; use the verified residential or weekly-hour detail only when the source supports the exact wording.
- Attribute team results carefully. Separate the candidate's implementation from a teammate's work and from shared verification.
- Do not mix unrelated metrics:
  - GitHub API calls `44회 → 22회`
  - bundle or asset size `1,820KB → 99KB`
  Each number must stay attached to its own change and measurement context.

### SKALA

- Classify as education/training unless the canonical source says otherwise.
- Current LangChain/LangGraph, multi-agent, monitoring, security, or service-structure work must be worded as learning and project application at the verified depth.
- Do not convert training projects into operating-company production experience.

### 아티피셜 소사이어티

- Classify as a short internship or activity according to the canonical source and form taxonomy.
- Keep scope bounded to verified work such as data acquisition, augmentation, dataset composition, model training support, and EasyOCR result checking.
- Do not promote support work to sole model ownership or production deployment.

### Other projects

- Exclude Toonners, fisheye, pill-recognition, or other low-signal projects unless the JD directly needs them and a current source proves relevance and ownership.
- Awards, certifications, language scores, military service, and education dates are factual fields. Copy them from the current source rather than reconstructing them from older applications.

## Role Lens

### Frontend JD

Lead with verified screen/API/state work, user flows, loading-empty-error-long-running states, real-time UI, performance, responsive behavior, and frontend development process. Keep backend, cloud, database, and agent internals as supporting context unless requested.

Use wording precisely:

- `반응형 화면`: layout changes according to viewport evidence.
- `사용 주체별 화면 흐름` or `역할별 서비스 화면`: owner/user/franchise/head-office or other role-specific modes.

Do not call role-specific desktop/mobile variants responsive without viewport-based evidence.

### AI/AX JD

Lead with verified agent routing, retrieval, tool use, evaluation/validation, monitoring, error handling, asynchronous execution, user-visible progress, and data-backed workflow results. Do not replace exact service or framework names with vague expressions to sound less technical.

### Full-stack JD

Lead with evidence that connects the screen, API contract, data flow, asynchronous or real-time behavior, and deployment/runtime boundary. Do not claim equal depth across every layer unless the source proves it.

## Typst and Text Rules

- Keep submission filenames as `박건우_이력서.typ` and `박건우_이력서.pdf`.
- Protect headings from being stranded at the bottom of a page.
- Verify that literal `~` characters render in ranges such as `1~2분`; do not rely on Typst spacing syntax.
- Preserve official technical names: Amazon Bedrock Agents, Amazon API Gateway, Amazon SQS, AWS Lambda, Amazon OpenSearch Service, LangChain, LangGraph, WebSocket, WebRTC, Yjs, Monaco Editor, and other source-confirmed names.
- Humanize Korean sentence rhythm, not technical terminology or factual precision.
