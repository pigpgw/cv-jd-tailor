# Tailoring Pipeline

Use this file as the operational checklist for one posting. Keep phase outputs compact and do not draft ahead of unresolved source questions.

## Phase 0 — Preflight

Create an inventory before analysis:

| Field | Required evidence |
| --- | --- |
| Company | live posting text |
| Role | official title |
| Posting ID | official ID or canonical URL suffix |
| Status | open/closed and deadline when shown |
| Route | platform or company site |
| Existing work | matching `지원전` folder |
| Prior submission | ledger and `지원후` folder |
| Role lens | responsibilities and required stack |

Stop on closed, duplicate, inaccessible, or mandatory-eligibility failures. Do not create a new folder until identity is stable.

## Phase 1 — JD Atomization

Preserve the complete posting long enough to split it into one row per requirement:

| ID | Type | Exact requirement | Mandatory | Verification target |
| --- | --- | --- | --- | --- |
| R1 | responsibility | ... | yes/no | action/result evidence |
| Q1 | qualification | ... | yes/no | eligibility and depth |
| P1 | preference | ... | no | direct or adjacent evidence |
| I1 | instruction | ... | yes/no | artifact or form rule |
| C1 | condition | ... | yes/no | deadline, location, status |

Do not merge separate technologies, actions, user groups, or conditions into one row when they may map to different evidence.

## Phase 2 — Candidate Evidence Ingestion

1. Read the canonical Notion Developer page through Composio.
2. Build a child-source manifest for candidate experiences that may match the JD.
3. Read the narrow source for every retained experience.
4. Capture only facts needed for this posting:

| Experience | Period | Candidate-owned action | Result/deliverable | Source | Conflict |
| --- | --- | --- | --- | --- | --- |

If using local fallback, state the snapshot path and possible staleness.

## Phase 3 — Gap Matrix and Eligibility Gate

Map each JD atom:

| JD ID | Evidence state | Eligibility | Source | Decision |
| --- | --- | --- | --- | --- |
| R1 | 직접 근거/인접 근거/근거 부족/확인 필요 | 충족/미충족/확인 필요/해당 없음 | page or record | use/narrow/exclude/verify |

Rules:

- A hard qualification marked `미충족` ends tailoring unless the posting explicitly permits an alternative.
- `인접 근거` may support a transferability statement but cannot be promoted to exact production experience.
- `확인 필요` remains outside submitted text until resolved.
- A user-requested percentage threshold must show the atom-level calculation; never hide judgment behind one score.

## Phase 4 — Claim Ledger and Metric Cards

Before prose, register every claim likely to appear:

| Claim | Experience | Ownership | Source | Evidence state | Allowed wording |
| --- | --- | --- | --- | --- | --- |

For every number:

| Metric | Measured workflow | Baseline | Change | After | Scope/caveat |
| --- | --- | --- | --- | --- | --- |

Remove a metric if its baseline, changed implementation, or measurement scope cannot be explained in an interview.

## Phase 5 — Strategy and Top-Third Plan

Decide before editing Typst:

- one-line positioning statement for this JD
- three strongest first-page proofs
- project order
- supporting experience order
- excluded experiences and why
- optional artifacts actually required

The first-page top third must answer:

1. What role is this person applying for?
2. What direct evidence proves fit?
3. What is distinctive enough to continue reading?

## Phase 6 — Draft and Render

Write bullets as:

`problem/constraint → candidate decision and implementation → verified result or deliverable`

Then:

1. compile Typst
2. verify PDF creation
3. extract text
4. inspect the rendered first page and all page breaks
5. compare final text with the claim ledger and JD crosswalk

## Phase 7 — Review and One Revision

Run the evidence audit, recruiter scan, and artifact QA from `review-protocol.md` as separate passes. Merge findings in this order:

1. unsupported or contradictory facts
2. mandatory JD omissions
3. ownership or causality overstatement
4. weak top-third prioritization
5. repetition and wording
6. visual defects

Apply one consolidated revision, then rerun the same checks once. Additional cycles are allowed only for remaining factual or rendering failures.

## Phase 8 — Completion Report

Report:

- source route used
- posting status and identity
- files created
- direct and adjacent evidence used
- gaps or exclusions
- compile and validation results
- unrelated pre-existing repository failures separately

Do not imply submission, upload, or archive completion unless that action was separately requested and verified.
