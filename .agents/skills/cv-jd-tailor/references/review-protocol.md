# Review Protocol

Keep review lenses distinct. Evidence verification and hiring judgment answer different questions and should not be blended into one vague score.

## Review A — Evidence Audit

Inputs:

- final Typst/PDF text
- JD atomic checklist
- claim ledger and metric cards
- selected Notion child sources and verified code/README/execution evidence

For every meaningful claim, assign:

- `검증됨`: source proves wording, ownership, and scope.
- `범위 축소 필요`: source supports a narrower claim.
- `모순`: source conflicts with the draft.
- `근거 없음`: no source supports the claim.
- `확인 필요`: plausible but incomplete or ambiguous.

Check:

- project and employer classification
- dates and periods
- candidate versus team ownership
- technologies actually used
- metric baseline, change, after-state, and measurement scope
- causal wording
- production, PoC, education, and planned-work boundaries
- rejected claims leaking back into the draft

Any `모순` or `근거 없음` blocks completion.

## Review B — Blind Recruiter/Hiring-Manager Scan

Inputs:

- JD
- rendered resume only

Do not consult the source record during this pass. Evaluate what an external reader can infer:

### Top-third scan

- Is the target role obvious?
- Are direct qualification proofs visible before project details?
- Is the current status and most relevant experience clear?

### 30-second scan

- Which three facts remain memorable?
- Are the strongest points distinct or repeated in different words?
- Are technology names attached to actions and outcomes?
- Is any section too dense to scan?

### 2-minute scan

- Does the evidence cover the role's hard requirements?
- Are gaps honestly scoped?
- Do project bullets show judgment, implementation, and result?
- What interview questions or doubts remain?

Return findings as `critical / important / optional`. Do not invent ATS compatibility percentages, pass probabilities, or recruiter certainty.

## Review C — Parse and Artifact QA

Check:

- PDF exists only after successful compile
- extracted text preserves section order and important characters
- headings are not stranded or clipped
- links are specific, clickable, and relevant
- no unresolved placeholders, internal comments, or management labels appear
- filenames and folder paths follow `AGENTS.md`
- every JD atom has one final disposition
- required application artifacts exist and optional ones are not fabricated

## Consolidated Revision

Merge findings once in this order:

1. factual contradictions and unsupported claims
2. hard-qualification or instruction omissions
3. ownership, metric, or causal overstatement
4. weak first-page prioritization
5. duplication and readability
6. layout defects
7. optional polish

Make one consolidated revision and rerun all three reviews once. Continue beyond that only when a factual, parse, compile, or visible-layout failure remains.

## Optional Multi-reviewer Use

Use separate reviewers or subagents only when the user requests them or the application is high risk. Give each reviewer one lens—evidence, recruiter scan, technical depth, Korean writing, or layout—and require cited findings. Do not average arbitrary scores; reconcile findings against the JD and source ledger.
