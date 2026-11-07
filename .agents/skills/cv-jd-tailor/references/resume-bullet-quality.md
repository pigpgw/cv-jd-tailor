# JD-Tailored Resume Bullet Quality

Read this reference whenever selecting or rewriting resume bullets, reviewing a weak draft, or deciding whether a tailored resume has enough evidence and detail.

## 1. Start with the posting, then the evidence

1. Turn each responsibility, required qualification, preferred qualification, and required technology into a separate JD checklist item.
2. Treat the Notion Developer page and its linked experience records as the user's factual career record. Search that complete experience index and relevant child sources for evidence that directly proves each item; do not stop at the analyzer's recommended projects or the first obvious match. A recorded experience remains a fact even when it is omitted from this JD's resume for relevance or space priority.
3. Build a coverage map before drafting: `JD item / exact source / candidate-owned action / project and role / strength (direct or adjacent) / planned resume location / omit reason`.
4. Include only JD-relevant experience, except the separately required, source-verified AI-development practice line. A true but unrelated stack, project, or duty does not belong in the detailed resume merely because it exists in Notion.
5. Keep role lenses distinct. For frontend, foreground screen implementation, user flows, UI state, API integration, navigation, rendering, performance, accessibility/responsiveness, collaboration UI, and verified AI workflow only where evidenced. For fullstack, show the connected UI-to-API-to-data/deployment path when the JD asks for it. For AI/AX, foreground the relevant product implementation and verified AI process. Do not let an attractive adjacent project redefine the target job.

## 2. Decide bullet count from coverage, not a quota

- There is no universal maximum or minimum. Do not force a fixed number of performance, feature, infrastructure, or AI bullets.
- First include every distinct, strong piece of evidence needed to make the required and preferred qualifications legible. Split independently useful facts into separate bullets when they prove different skills, decisions, user-visible states, or outcomes.
- Merge details only when they describe one same-project, same-context chain and the sentence remains easy to scan. Never merge separate projects, problems, measurements, ownership boundaries, or causal outcomes to save space.
- Remove a bullet only when it is unsupported, outside the JD, redundant with a stronger bullet, or too weak to add interview-defensible evidence. Do not remove a strong distinct proof point just to hit one page or an arbitrary short list.
- As a normal planning check, a primary role/project should expose roughly 4–8 distinct evidence bullets when the source supports that many and the JD can use them. This is a prompt to inspect for missing evidence, not a quota: fewer is correct when evidence is thin; more is acceptable when each item proves a different high-priority requirement and remains readable.
- For each directly evidenced core requirement, the resume must show an exact technical proof in a detailed bullet or a clearly named first-page evidence item. A technology name by itself is not proof. For each unproven requirement, record `전략 리스크` or `제출 제외` and why; never disguise the gap with an adjacent technology.
- Keep the detailed bullets and the first-page `핵심 기술 근거` complementary. The summary should make the strongest 3–5 proofs easy to scan; detailed entries should explain the distinct work behind them without repeating the same sentence.

## 3. Build each bullet around one evidence chain

Use the pattern that fits the source; do not force every bullet into the same template:

`same-project user/task context or verified problem/constraint -> candidate-owned judgment/action -> implementation or collaboration -> measured result, verified behavior, or concrete artifact`

- If the source documents a problem, state the observable symptom or constraint before the action. Name the analysis method or decision criterion only when recorded.
- If the source documents a feature but no originating problem, do not invent one. State who needed the flow, what the candidate built or connected, and the user-visible behavior or artifact that resulted.
- Keep the candidate's own work separate from team outcomes, default framework behavior, managed-service features, and teammate implementation. Prefer precise verbs such as `구현`, `연동`, `화면에 표시`, `상태 처리`, `분석`, or `검증` at the supported ownership level.
- End with the strongest verified result available: scoped Before→After metric, bounded test/measurement, handled edge state, completed screen/API flow, or named artifact. Avoid empty endings such as `UX 향상`, `생산성 증대`, `협업에 기여`, `서비스 안정화`, or `성능 개선` unless evidence makes the outcome concrete.
- Preserve technical reasoning when the source records it: why this approach fit the constraint, what trade-off or failure path it handled, and what alternative it avoided. Do not invent a sophisticated rationale after the fact to make routine implementation sound novel.
- Attach every metric to its own project, changed implementation, measured request/workflow, baseline, after value, and scope/caveat. Never transfer a metric from one feature or project to another.
- Avoid noun stacks and technology inventories. Name only the technology needed to explain the action or prove a JD requirement; put eligible stack names in the stack line, not in every bullet.

## 4. Find role-specific distinction and technical depth

Before drafting, run a separate **distinctive-strength pass** over the full source experience index and the linked records for every JD-matched project. Do not stop after finding generic fit such as `React 사용`, `API 연동`, or `협업`.

For each relevant experience, look for source-backed details that show why this candidate's work is unusually useful or technically deep for this role:

- **Role-specific leverage:** a concrete user or product outcome the implementation enabled (for example, a clearer next action during a long-running task, fewer repeat requests, or a faster first route load).
- **Non-obvious mechanism:** an implementation choice that required handling lifecycle, ordering, concurrency, state synchronization, failure, or performance constraints (for example, singleton event ownership with explicit subscribe/unsubscribe, staged WebSocket trace rendering, route-level lazy loading, or a Y.Doc snapshot boundary).
- **Depth and ownership:** what the candidate personally traced, designed, implemented, connected, or verified; distinguish this from a team result or a library's default behavior.
- **Evidence boundary:** the source passage, metric scope, and caveat; whether the outcome is measured, observed, or only a delivered artifact.

Record a compact `JD need → distinctive source evidence → candidate-owned mechanism → user/product result → resume location` map before writing. Rank proof chains by (1) directness to the target role, (2) technical depth and ownership, and (3) strength of the verified outcome. Put the strongest role-defining proofs on page one and let the detailed project section explain the mechanism. Do not allow an adjacent metric or an impressive but off-role technology to displace a stronger direct proof.

Write the strength as a claim a hiring manager can recognize, not as a label: name the user/product consequence where verified, then the distinctive implementation that supports it. For example, a frontend strength can connect reduced uncertainty or abandonment inquiries to a progress/trace UI and the event lifecycle that kept updates coherent. A claim such as `싱글톤을 적용해 이탈 문의를 줄임` is invalid unless the source ties that implementation to that outcome; split the mechanism and outcome into separate, correctly scoped evidence when causality is not established.

The resume must show **both** the candidate's role-relevant advantage and enough implementation detail to defend it in an interview. Do not replace details with a catchy headline, and do not bury the unique decision under a generic result statement. If the source contains no differentiating mechanism or outcome for a JD item, use the strongest ordinary verified evidence and mark the gap; never manufacture novelty, seniority, or impact.

## 5. Tune detail for the resume and portfolio separately

- A resume bullet should be compact but retain its proof chain. As an editing check, aim for one or two rendered lines in the chosen template; shorten incidental context or stack names first. Do not truncate the action, result, measurement scope, or ownership qualifier to meet a line target. If it still needs more room, let it wrap or move secondary explanation to the portfolio.
- The portfolio should expand, not duplicate, the resume: explain the user/task context, technical decision and alternatives when evidenced, candidate-owned implementation, validation, outcome, and remaining limitation or learning. Use diagrams/screenshots only when they prove the specific case.
- Project sections should keep each project and its role, period, team context, and owned scope separate. Do not turn an employer's product domain into a claim that the candidate implemented a domain workflow.

## 6. Review as a skeptical interviewer

For every bullet, answer all of these before keeping it:

1. Which exact JD checklist item does this prove?
2. Where is the supporting source passage, and does it name the candidate's action?
3. What did the candidate decide, implement, connect, measure, or deliver personally?
4. Why is the chosen technique meaningful for this JD, and is that reason actually evidenced?
5. What verifiable state changed? Is the number tied to the right request and scope?
6. Does another bullet already prove the same thing? If so, which version gives stronger or distinct evidence?
7. Would a frontend/fullstack/AI engineer reading only page one immediately identify the target role and the candidate's strongest matching work?

Then perform three independent passes:

- **Evidence/JD pass:** verify relevance, ownership, factual scope, technical choice, result, metric provenance, and coverage. Correct facts before polishing prose.
- **Distinctiveness pass:** verify that the first page surfaces the strongest target-role-specific advantage, that its technical mechanism is visible in the detailed section, and that the user/product result is not misattributed or overstated. Compare it against generic candidates with the same stack: can the reader identify a concrete reason to remember this candidate?
- **Language/volume pass:** read every bullet aloud; split mixed chains, replace vague endings, preserve useful implementation detail, remove duplicate claims and awkward noun stacks. Recheck whether any distinct direct qualification was accidentally dropped during compression.

Score each bullet from 0–2 on `JD fit`, `source/ownership clarity`, `technical specificity`, and `result/artifact clarity`. A score of 0 on JD fit or source/ownership is a hard exclusion. Any other 0 requires rewriting or a strategy note explaining why a weaker adjacent proof is still useful. The score is a review aid, not a way to legitimize unsupported claims.

## 7. Use the supplied resume-writing notes as heuristics, not facts

The user's supplied `생각등대` notes emphasize interviewer's first-page scan, concrete project context, why/how/result rather than technology labels, sourced trade-offs, distinct AI workflow evidence, and company/team/role-specific motivation. Apply those principles only when consistent with the JD and the user's factual Notion record. The notes' example metrics, project names, technologies, AI process labels, and sample sentences are writing examples; do not mistake those examples for the user's own experience. This does not weaken or make conditional any experience already recorded in Notion. Do not interpret "include AI across fields" as permission to claim AI work beyond the recorded facts; bring forward the verified AI-development practice where relevant to the software role.
