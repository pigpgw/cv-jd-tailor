# 박건우 이력서·포트폴리오 작업 공간

실제 기준 폴더는 `cv-jd-tailor`입니다. 바탕화면 `이력서`에는 이동 안내 파일만 남겼습니다. 자료는 이 폴더에 통합되어 있습니다.

| 자료 | 위치 |
|---|---|
| 최신 공용 포트폴리오 PDF | [PDF](assets/portfolio/typst/박건우_포트폴리오.pdf) |
| 수정할 Typst 원본 | [main.typ](assets/portfolio/typst/main.typ) |
| 원본 이미지 8개·한글 글꼴 | `assets/portfolio/typst/assets/` |
| typst.app 업로드용 ZIP | `assets/portfolio/exports/박건우_포트폴리오_Typst_원본.zip` |
| 이전 포트폴리오·이력서 | `assets/portfolio/original/`, `assets/resume/original/` |
| 편집 가능한 아키텍처 자료 | `assets/portfolio/architecture/` |
| 테라다인 지원·면접·코딩 준비 | `workflow/지원후/teradyne_application/` |
| JD별 지원 준비 / 제출 보관본 | `workflow/지원전/`, `workflow/지원후/` |
| 경력 원천 fallback | `db/` |
| 공용 템플릿 | `templates/public/` |

포트폴리오는 기존 PDF의 6개 사례와 원본 이미지 8개를 옮긴 버전입니다. 사실·수치에 대한 추가 원천 검증이나 typst.app 계정 내 프로젝트 생성까지 수행한 것은 아닙니다.

`db/`, `workflow/`, `assets/`는 로컬 전용입니다. Git에는 공용 지침과 템플릿만 관리합니다.

## 포트폴리오 다시 생성

```sh
cd assets/portfolio/typst
typst compile --font-path assets main.typ 박건우_포트폴리오.pdf
```

임시 렌더 이미지, 중복 추출 이미지 폴더와 중복 이미지 ZIP은 제거했습니다. 원본 문서·녹음·영상·코딩 기록은 보존했습니다.
