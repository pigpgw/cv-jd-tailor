# Project Evidence Schema

Use this schema when recording or reviewing any project in the Notion Developer source. It is an evidence index, not a resume draft.

## Required fields

- `project`: project name, period, product or learning context
- `role`: candidate's verified role and team context
- `stack`: technologies directly used in the project
- `user_or_business_context`: who used it and what workflow it supported
- `candidate_scope`: only work personally written, changed, configured, integrated, or verified
- `problem_constraint`: observed problem, requirement, or technical constraint
- `decision_implementation`: candidate-owned design and implementation decisions
- `code_evidence`: repository, file path, function/component/module, commit, PR, or issue
- `result_validation`: metric, behavior change, test, build, deployment, or manual verification
- `jd_tags`: capability tags, not company-specific application decisions
- `usable_phrasing`: truthful resume/portfolio wording
- `forbidden_phrasing`: claims that exceed the evidence
- `team_boundary`: work owned by teammates or the whole team
- `confidence`: confirmed, limited, draft, or needs confirmation
- `publicity`: public, restricted, or private

## Code review procedure

1. Inspect the repository tree and project README.
2. Inspect complete Git history, author identity, changed files, and relevant PRs.
3. Read the candidate-authored files and trace the surrounding call/data flow.
4. Separate library or managed-service behavior from candidate-authored integration, UI, state, error handling, and validation.
5. Record only code paths that can be tied to the candidate's commits or explicit source evidence.
6. Record team-owned features separately and exclude them from individual achievement claims.

## JD matching procedure

For each new posting, create a temporary mapping:

`JD wording -> requirement type -> evidence records -> evidence level -> selected project(s) -> resume location`

- `direct`: the project evidence satisfies the same responsibility or technology.
- `adjacent`: the project demonstrates the underlying capability but not the exact domain or tool.
- `none`: no source-backed evidence; do not use the keyword in submitted claims.

Project selection is recomputed for every JD. Never encode a universal project priority or require a named project in every application.

## Selection rules

- Select one or more projects when each adds a distinct JD requirement or stronger evidence.
- Prefer the smallest set that covers the important JD requirements without repeating the same story.
- Rank by directness, candidate ownership, specificity of implementation, measurable validation, and public usability.
- Do not merge facts from different projects into one causal chain.
- Keep the evidence records reusable; keep the selected combination and ordering only in the company-specific strategy.

## Final audit

- Every selected project appears in the final artifact or has an explicit reason for exclusion.
- Every directly evidenced JD requirement is represented in a truthful bullet, core capability, or required form answer.
- Every core capability maps back to at least one evidence record.
- No teammate-owned code, unsupported keyword, duplicate story, stale activity, or private detail is exposed.
- The strategy, resume, portfolio candidate list, and source evidence agree on project names, roles, scope, and results.
