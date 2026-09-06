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
  font: ("Pretendard", "Apple SD Gothic Neo", "NanumGothic", "Noto Sans CJK KR"),
  fallback: true,
)

#set par(
  justify: false,
  leading: 0.88em,
)

#set block(breakable: true)

#set list(
  marker: [•],
  indent: 0.1em,
  body-indent: 0.48em,
  spacing: 0.78em,
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
#box(
  stroke: (left: 2pt + accent),
  inset: (left: 12pt, y: 6pt),
  fill: luma(99%),
)[
  #text(size: 11.1pt, weight: "bold", fill: luma(10%))[
    JD에 맞춘 한 줄 후킹 문구를 작성합니다.
  ]
]

#section("지원동기")
회사/JD/역할과 내 경험이 왜 맞는지 자연스럽게 작성합니다.

#section("소개")
내가 어떤 사람인지와 일하는 강점이 보이도록 작성합니다. 지원동기와 같은 문장을 반복하지 않습니다.

#section("핵심 역량")
공고가 요구하고 원천 근거로 뒷받침되는 역량만 자연스럽게 작성합니다. 근거가 약한 항목은 넣지 않습니다.

#section("경력")
#entry(
  "기간",
  "역할",
  "회사명",
  "회사/서비스 설명",
  [
    - *핵심 근거*: 문제, 해결, 결과가 드러나는 불릿을 작성합니다.
  ],
)

#section("주요 프로젝트")
#entry(
  "기간",
  "역할",
  "프로젝트명",
  "기술 스택 또는 프로젝트 설명",
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

#block(breakable: false)[
  #v(0.72em, weak: true)
  #text(size: 13pt, weight: "bold", fill: accent)[수상 및 기타]
  #v(0.4em)
  #line(length: 100%, stroke: 0.5pt + rule)
  #v(0.75em)
  #meta_row([오픈소스], [관련 기여가 있으면 작성합니다.])
  #v(0.54em)
  #meta_row([수상], [관련 수상 이력이 있으면 작성합니다.])
  #v(0.54em)
  #meta_row([학력], [학력 정보를 작성합니다.])
]
