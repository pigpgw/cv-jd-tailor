#let accent = rgb("#2d5a9e")
#let subtle = luma(50%)
#let rule = luma(92%)

#set page(
  paper: "a4",
  margin: (
    left: 18mm,
    right: 18mm,
    top: 22mm,
    bottom: 22mm,
  ),
)

#set text(
  lang: "ko",
  size: 9.7pt,
  fill: luma(15%),
  font: "Apple SD Gothic Neo",
  fallback: true,
)

#set par(
  justify: false,
  leading: 0.86em,
)

#set block(breakable: true)

#set list(
  marker: [•],
  indent: 0.1em,
  body-indent: 0.48em,
  spacing: 0.74em,
)

#show link: set text(fill: accent)
#show link: underline.with(
  stroke: 0.7pt + accent,
  offset: 1.6pt,
)

#let section(title) = [
  #v(2.25em, weak: true)
  #text(size: 13pt, weight: "bold", fill: accent)[#title]
  #v(-1em)
  #line(length: 100%, stroke: 0.5pt + rule)
  #v(0.75em)
]

#let entry(date, role, title, subtitle, content) = [
  #block(breakable: true, width: 100%)[
    #grid(
      columns: (82pt, 1fr),
      gutter: 10pt,
      [
        #text(weight: "semibold", size: 9pt, fill: luma(45%))[#date]
        #if role != none [
          #v(0.28em)
          #block[
            #set text(weight: "medium", size: 8.5pt, fill: accent)
            #role
          ]
        ]
      ],
      [
        #text(weight: "bold", size: 10.7pt)[#title]
        #if subtitle != none [
          #v(0.16em)
          #text(fill: luma(40%), weight: "medium", size: 9.4pt)[#subtitle]
        ]
        #v(0.55em)
        #content
      ],
    )
  ]
  #v(1.12em)
]

#let meta_row(label, content) = [
  #grid(
    columns: (56pt, 1fr),
    gutter: 8pt,
    [
      #text(size: 9pt, weight: "semibold", fill: subtle)[#label]
    ],
    [
      #text(size: 9.2pt)[#content]
    ],
  )
]

#grid(
  columns: (1fr, auto),
  align: (left, bottom),
  [
    #text(size: 24pt, weight: "bold")[지원자명]
    #v(0.18em)
    #text(size: 11pt, weight: "medium", fill: subtle)[지원 직무명]
  ],
  [
    #text(size: 9.2pt, fill: luma(35%))[
      #link("mailto:email@example.com")[email\@example.com] | 010-0000-0000 | #link("https://github.com/example")[GitHub] | #link("https://example.com")[Blog]
    ]
  ],
)

#v(1.9em)
#text(size: 11.1pt, weight: "bold", fill: luma(10%))[
  JD에 맞춘 한 줄 후킹 문구를 작성합니다.
]

#section("자기소개(요청 시)")
팩트 기반 직무 강점, 검증된 AI 활용 방식, 가장 자신 있는 프로젝트 하나만 5줄 이내로 작성합니다. 자기평가와 성격 주장은 제외합니다.

#section("지원동기")
왜 이 회사인지, 왜 이 팀/제품 환경인지, 왜 이 직무인지가 모두 드러나게 작성합니다. 회사 칭찬보다 입사 후 수행할 일을 씁니다.

#section("핵심 기술 근거")
공고 자격요건·우대사항을 직접 증명하는 원천 경험만 3-5개 작성합니다. 각 항목은 문제/제약, 기술적 판단·구현, 수치 결과 또는 명확한 산출물이 드러나야 하며 `기본기 보유`처럼 추상적으로 쓰지 않습니다.

#section("경력")
#entry(
  "기간",
  "역할",
  "회사명",
  "회사/서비스 설명",
  [
    - *핵심 근거*: 도메인/기능, 문제 또는 제약, 분석/해결 기법, 수치 결과 또는 명확한 산출물이 드러나는 불릿을 작성합니다.
  ],
)

#section("주요 프로젝트")
#entry(
  "기간",
  "역할",
  "프로젝트명",
  "JD와 직접 맞거나 유사 역량으로 설명 가능한 기술 스택만 작성",
  [
    - 문제와 해결, 결과가 연결되는 프로젝트 불릿을 작성합니다.
  ],
)

#section("교육 및 활동")
#entry(
  "기간",
  none,
  "교육/활동명",
  none,
  [
    - 지원 직무와 연결되는 교육/활동 근거를 작성합니다.
  ],
)

#section("자격증 및 어학")
#meta_row([자격증], [
  - YYYY.MM.DD 자격증명
])
#v(0.54em)
#meta_row([어학], [
  - YYYY.MM.DD 어학 점수
])

#section("수상")
#meta_row([수상], [
  - YYYY.MM 수상명
])

#section("학력")
#meta_row([학력], [YYYY.MM - YYYY.MM 학교명 전공명])

#section("병역")
#meta_row([병역], [YYYY.MM - YYYY.MM 병역 이력])
