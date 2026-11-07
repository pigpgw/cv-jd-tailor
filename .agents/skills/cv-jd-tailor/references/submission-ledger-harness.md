# Submission Ledger Harness

Use this harness to prevent duplicate job applications across computers without publishing private application history to Git.

## Storage boundary

- Local evidence index: `workflow/지원후/00_지원이력.md`
- Submitted artifacts: `workflow/지원후/<회사명>_<공고ID>/`
- Cross-device index: the user's Notion application-complete list
- Git-tracked content: this schema and procedure only. Never commit actual application rows or submitted artifacts.

## Canonical row

```markdown
| 지원일자(KST) | 회사 | 직무 | 공고 ID | 원문 공고 URL | 플랫폼 | 제출 이력서 | 상태 |
|---|---|---|---|---|---|---|---|
| 2026-11-07 | 예시회사 | AI 서비스 개발자 | 12345678 | https://example.com/jobs/12345678 | 사람인 | workflow/지원후/예시회사_12345678/박건우_이력서.pdf | 지원완료 |
```

## Pre-submit duplicate check

1. Remove tracking parameters from the posting URL.
2. Extract the platform posting ID or official requisition ID.
3. Search the local ledger for the canonical URL and ID.
4. Search submitted folder names and their analysis files for the same ID.
5. Search the Notion application-complete list for the same URL and ID.
6. If any verified record says `지원완료`, stop. Do not open or submit the form again.
7. If only a legacy folder exists, classify it as `기존 보관본·일자 확인 필요` and verify the platform support history before deciding.

## Post-submit write gate

Write a row only after the platform visibly confirms submission or its support-history page shows the posting as submitted. Record the current Asia/Seoul date, exact company and role, canonical URL, posting ID, platform, and the exact submitted resume path. Then append the equivalent record to Notion. Opening a form, uploading a file, saving a draft, or clicking a submit button without a success result is not completion.
