---
name: cv-jd-tailor
description: Generate evidence-grounded, JD-specific Korean resumes and optional application artifacts from a live job posting and the user's Notion Developer record. Use when a user wants a tailored resume, portfolio selection, or application draft. Exclude generic career advice, unsupported ATS scoring, and final submission unless separately requested.
---

# CV JD Tailor

## Outcome

Turn one live JD into a reviewable application package whose important claims are traceable to the user's verified career record. Optimize for role fit and recruiter readability without changing ownership, dates, metrics, causal links, or completion state.

`AGENTS.md` controls source precedence, archive boundaries, paths, safety, and repository-wide validation. This skill controls JD decomposition, evidence selection, composition, and tailoring QA.

## Load Only What the Current Phase Needs

- Read [references/tailoring-pipeline.md](references/tailoring-pipeline.md) at the start of every tailoring task.
- Read [references/candidate-record-rules.md](references/candidate-record-rules.md) before selecting or wording the user's experiences.
- Read [references/resume-bullet-quality.md](references/resume-bullet-quality.md) before drafting or revising resume bullets.
- Read [references/project-evidence-schema.md](references/project-evidence-schema.md) when documenting a new project, inspecting a repository, or rebuilding project evidence.
- Read [references/review-protocol.md](references/review-protocol.md) after the first rendered draft.
- Read [references/submission-ledger-harness.md](references/submission-ledger-harness.md) only when updating application records or processing multiple postings.

Do not load every reference speculatively. Keep the active context limited to the current phase and selected evidence.

## Required Inputs

At least one JD input:

- `jd_url`
- `jd_text`
- `jd_file`

Optional:

- `application_dir`
- `analysis_path`
- `role_title`
- `notion_source_url`
- `resume_snapshot_path`
- `portfolio_snapshot_path`
- `existing_portfolio_pdf`
- `output_root`
- `archive_root`

Defaults:

- Notion source: the canonical Developer page in `AGENTS.md`
- Local fallback: `db/이력서_원천.md`, `db/포트폴리오_원천.md`
- Output root: `workflow/지원전`
- Submitted archive: `workflow/지원후`

If company, role, or posting ID is ambiguous, resolve them from the live posting before creating a folder.

## Source Contract

1. Read the complete JD from its live public source when possible. A search snippet is discovery evidence, not a complete JD.
2. Confirm posting identity and current status before tailoring. If the posting is closed, duplicated, inaccessible, or requires an unsupported eligibility condition, stop and report it.
3. Read the Notion Developer page through Composio first. For each selected experience, read the narrow child source that proves its scope, ownership, result, and dates.
4. Use local snapshots only when Notion is unavailable, and label the run as fallback-based.
5. A previous application draft is expression reference only. Never use it as the factual source for dates, roles, metrics, or technologies.
6. A platform or library capability is not proof that the candidate implemented it. Require a candidate-owned action in the source.

### Evidence states

Label each JD requirement and draft claim with one state:

- `직접 근거`: the source explicitly proves the candidate's relevant action or result.
- `인접 근거`: the source proves a related capability but not the exact requirement.
- `근거 부족`: no source supports the claim; exclude it from submitted text.
- `확인 필요`: a likely fact is incomplete or conflicting; do not promote it until resolved.

Keep eligibility separate from evidence strength:

- `충족`
- `미충족`
- `확인 필요`
- `해당 없음`

Do not invent ATS percentages, pass probabilities, or pseudo-precise match scores. If the user requests a fit threshold, calculate it only from explicit JD atoms and show the numerator, denominator, exclusions, and evidence state.

## Output Contract

For `workflow/지원전/{회사명}_{JD식별자}/`, produce only artifacts required by the posting or user:

- `{회사명}_{JD식별자}_채용분석.md`
- `{회사명}_{JD식별자}_지원전략.md`
- `박건우_이력서.typ`
- `박건우_이력서.pdf` only after successful compilation
- self-introduction answers only when the posting requires them or the user requests them
- portfolio variants only when the JD or user requires them

The strategy document must contain:

1. posting identity, source, liveness, and role lens
2. atomic JD checklist covering responsibilities, qualifications, preferences, instructions, and conditions
3. requirement-to-evidence matrix with evidence and eligibility states
4. claim ledger and measurement cards for every retained metric
5. selected and excluded experiences with reasons and ownership boundaries
6. first-page/top-third scan plan and artifact manifest
7. final exact crosswalk from every JD atom to `직접 반영`, `축소 반영`, `전략 리스크`, or `제출 제외`

Do not create placeholder files or empty optional sections merely to satisfy a template.

## Execution

### 1. Preflight

- Resolve company, role, posting ID, source URL, deadline/status, and application route.
- Check `workflow/지원후/` and the application ledger for prior submission.
- Check for another active folder for the same posting and reuse it instead of duplicating work.
- Select the role lens before reading the resume as a whole: frontend, full-stack, AI/AX, data, or another JD-defined lens.

### 2. Analyze the complete JD

- Invoke `company-jd-analyzer` first unless a current 12-section analysis already exists for the exact posting.
- Decompose every responsibility, qualification, preferred qualification, submission instruction, and condition into atomic rows.
- Separate hard eligibility from ranking preference. A preference gap is not an eligibility failure.
- Preserve exact technical names where they matter, but do not copy JD wording as unsupported self-description.

### 3. Build the evidence map

- Retrieve the parent Notion page and the child sources for all retained experiences.
- Build a compact table: `requirement / source / candidate action / result / evidence state / proposed artifact location`.
- Record contradictions, rejected claims, and ownership limits before drafting.
- For each metric, record: `measured workflow / baseline / change / after / scope or caveat`.

### 4. Decide the application strategy

- Put the strongest direct evidence for the role in the first-page top third.
- Use adjacent evidence only with honest scope, such as learning, project application, or transferable implementation—not as direct production experience.
- Prefer a few distinct, interview-defensible proofs over repeated keyword coverage.
- State what will be omitted. Exclusion is part of tailoring, not missing work.

### 5. Draft strategy first, resume second

- Complete the requirement crosswalk and selected-evidence plan before editing Typst.
- Each bullet should contain one problem or constraint, one candidate-owned decision/action, and one verified result or concrete deliverable.
- Keep technical terminology official and precise. Humanize rhythm and sentence structure without replacing technical names with vague everyday wording.
- Avoid generic self-praise, skill inventories without proof, defensive meta-language, and company-name substitution templates.

### 6. Render and inspect

- Compile Typst and verify that the PDF exists.
- Extract PDF text and compare it with the strategy and source ledger.
- Inspect page one, heading placement, wrapping, links, glyphs, clipped content, and page count.
- Treat environment font fallback warnings separately from compilation failure.

### 7. Run distinct reviews

Follow [references/review-protocol.md](references/review-protocol.md):

- evidence audit: source fidelity, ownership, dates, metrics, causality, and leakage
- recruiter scan: top-third fit, 30-second readability, differentiation, repetition, and likely interview questions
- artifact QA: parseability, layout, file contract, and exact JD crosswalk

Consolidate findings once, revise once, and rerun the checks once. Continue only for factual, rendering, or validation failures—not for endless stylistic cycling.

### 8. Report the result

Report:

- live/fallback source status
- generated and intentionally omitted artifacts
- verified strengths, adjacent evidence, and unresolved gaps
- compilation and validation results
- any existing unrelated repository failures separately

Final submission, external upload, or moving files to `workflow/지원후/` requires a separate explicit user request.

## Composition Priorities

1. hard eligibility and role-defining responsibilities
2. direct evidence with candidate ownership
3. verified result, user-facing change, handled failure state, or concrete artifact
4. preferred qualifications with direct or honestly adjacent evidence
5. concise education, awards, certifications, and activities needed for context

Do not let supporting backend, cloud, or AI content dominate a frontend JD unless the posting explicitly values it. Conversely, an AI/AX JD should lead with verified agent, data, evaluation, monitoring, or workflow evidence rather than generic web development.

## Batch Mode

For multiple postings:

- analyze each exact posting independently
- deduplicate by official posting ID or canonical URL, not title alone
- keep company folders separate by posting ID
- use the application ledger to prevent repeat work or repeat application
- do not lower the evidence bar to increase volume
- stop before application submission unless the user explicitly opens that gate

## Stop Conditions

Stop and explain the blocker when:

- the complete JD cannot be recovered
- mandatory eligibility is unmet or unresolved
- the Notion source and fallback are both unavailable
- a key claim has conflicting ownership, date, or measurement evidence
- the target folder is a submitted immutable archive
- requested wording would require fabrication or combine facts from different projects

## Completion Standard

The task is complete only when:

- every JD atom has a disposition
- every retained claim has a traceable source and evidence state
- every metric has a measurement card or is removed
- role lens and first-page priorities are visible in the rendered PDF
- evidence audit, recruiter scan, parse/layout QA, `git diff --check`, and required skill validators pass
- created files and unresolved risks are reported accurately
