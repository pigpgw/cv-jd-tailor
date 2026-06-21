---
name: company-jd-analyzer
description: Analyze a job description to identify the company, extract explicit and implied hiring needs, gather recent company signals, and write one Korean 12-section hiring brief under workflow/지원전/{company_name}/ for resume and portfolio tailoring. Use when the user provides a JD link, text, or file and wants company/JD analysis before tailored application document generation.
---

# Company JD Analyzer

Use this skill when the user gives a job description and wants a hiring-focused brief that helps tailor a resume or portfolio.

## Inputs

At least one input is required:

- JD URL
- JD text
- JD file

Optional inputs:

- company name
- role title
- target team
- target seniority
- user resume path
- user portfolio path
- output directory

Default output root:

- `workflow/지원전`

## Goal

Start from the JD, identify the company, gather hiring-relevant recent signals, infer what kind of person the company likely wants, and write exactly one final Korean markdown file:

`workflow/지원전/{company_name}/{company_name}_채용분석.md`

If the company cannot be identified with confidence, write:

`workflow/지원전/미확인회사/미확인회사_채용분석.md`

Do not create extra files unless the user explicitly asks.

## Output File Naming

- Use the identified company name as the file name.
- Keep Korean if the company is commonly written in Korean.
- Keep English if the company is commonly written in English.
- Replace only filesystem-breaking characters: `/ \ : * ? " < > |`
- Do not slugify unless the environment requires it.

Examples:

- `workflow/지원전/토스/토스_채용분석.md`
- `workflow/지원전/OpenAI/OpenAI_채용분석.md`
- `workflow/지원전/스튜디오 바톤/스튜디오 바톤_채용분석.md`

## Operating Rules

1. Start from the JD, not from assumptions.
2. Identify the company before broader research.
3. Prefer live web research because hiring context is time-sensitive.
4. Prioritize sources in this order:
   - official JD or official careers page
   - official company website
   - official product pages
   - official newsroom, blog, engineering blog
   - official interviews, leadership statements, press releases
   - reputable news coverage
   - weaker secondary sources only if stronger evidence is unavailable
5. Prefer recent signals:
   - last 180 days for hiring, product, org, funding, and strategy signals
   - last 365 days for broader business context
   - older official about pages only for stable background
6. Label important claims as one of:
   - `[명시]` explicitly stated in the JD
   - `[최근근거]` supported by recent evidence outside the JD
   - `[추정]` inferred from the JD and supporting context
   - `[확인필요]` plausible but not sufficiently verified
7. Never present inference as fact.
8. Never invent recent company context.
9. Optimize for hiring relevance and resume/portfolio tailoring, not generic company research.

## Workflow

### 1. Parse the JD

Extract:

- company name
- role title
- team or org name if available
- responsibilities
- required qualifications
- preferred qualifications
- tech stack
- seniority signals
- collaboration signals
- repeated keywords
- domain clues
- product clues

### 2. Identify the Company

Use the JD itself first. If the JD is on a recruiting platform, find the official company site or official careers page.

Confidence guidance:

- High confidence: the JD directly names the company, or the recruiting page clearly maps to the official company site
- Medium confidence: the company is strongly suggested but not directly confirmed by an official source
- Low confidence: multiple companies could plausibly match

If confidence is below high, say so clearly and weaken the wording. If identification is too uncertain, use `workflow/지원전/미확인회사/미확인회사_채용분석.md`.

### 3. Research Recent Company Context

Look for recent evidence such as:

- product launches or major feature changes
- organizational changes
- hiring expansion or contraction
- funding, business, or financial updates
- customer segment focus
- engineering blog topics
- leadership comments about product, execution, or hiring priorities

Use recent official sources whenever possible.

### 4. Build a Hiring Hypothesis

Synthesize:

- the company's likely current situation
- why this role may exist now
- what type of person would likely succeed
- what the company may care about beyond the literal JD wording

Every inference must be labeled `[추정]` or `[확인필요]`.

### 5. Translate Into Tailoring Strategy

Determine:

- what should be emphasized
- what can be downplayed
- which experiences or projects are strongest evidence
- which keywords should appear
- what gaps or risks exist
- what interview questions are likely

If the user provided a resume or portfolio, use it to prioritize and tailor the advice. If not, provide practical guidance and state that no user resume/portfolio was reviewed.

### 6. Write the Final Markdown File

- Create `workflow/지원전/{company_name}` if needed.
- Write exactly one Korean markdown file in that company folder.
- Keep the writing concise, analytical, and hiring-focused.

## Required Markdown Structure

The final file must follow this structure exactly:

```markdown
# {회사명} 채용 분석

## 1. 공고 핵심 요약
- Summarize the role in one or two Korean sentences.

## 2. 회사/서비스 개요
- What the company does
- What product or domain matters most for this role
- Separate stable background from recent context.

## 3. 최근 6~12개월 주요 시그널
- Use dated bullets where possible.
- Prefer recent evidence.
- Mark each point with `[최근근거]` or `[확인필요]`.

## 4. JD에서 명시된 핵심 요구사항
- Extract explicit requirements from the JD.
- Mark each item as `[명시]`.

## 5. JD에서 읽히는 숨은 요구사항
- Infer likely expectations not directly stated.
- Mark each item as `[추정]` or `[확인필요]`.

## 6. 이 회사가 원하는 사람상
- 어떤 태도
- 어떤 실행 방식
- 어떤 협업 방식
- 어떤 문제 해결 방식
- Separate fact and inference.

## 7. 이력서에 강조해야 할 사인
- Keywords to include
- Experience types to place first
- Strongest evidence style
- Impact framing that fits this role

## 8. 우선 배치할 경험/프로젝트
- Recommend the most relevant experiences or project types to foreground.
- Explain why they match.

## 9. 지원자 입장에서의 리스크
- Missing evidence
- Weak signals
- Possible hiring-side concerns
- Compensation strategy in resume or interview

## 10. 예상 면접 질문
- Questions based on explicit JD requirements
- Questions based on inferred expectations
- Questions based on recent company context

## 11. 총평
- What matters most
- What must be reflected in the resume
- What should be prepared before applying

## 12. 근거 출처 메모
- Source name
- Source type
- Date if available
- Why it mattered
```

## Writing Rules

1. Write the final output in Korean.
2. Keep company names, product names, role names, and technical keywords in their natural form when appropriate.
3. Be concise and specific.
4. Avoid generic praise or fluff.
5. Separate stable background from recent signals.
6. Include concrete dates for recent company context.
7. Downgrade confidence when evidence is weak.
8. Prioritize usefulness for resume and portfolio tailoring.

## Final Checks

Before saving the file, verify:

1. The company is correctly identified.
2. The file name is based on the company name.
3. The output is fully in Korean.
4. Recent claims are actually recent.
5. Fact and inference are clearly separated.
6. The output is useful for tailoring a resume and portfolio.
7. Risks and missing evidence are clearly stated.
