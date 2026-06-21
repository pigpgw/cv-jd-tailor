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
    #text(size: 11pt, weight: "medium", fill: subtle)[Portfolio]
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
    JD에 맞춘 포트폴리오 핵심 메시지를 작성합니다.
  ]
]

#section("포트폴리오 요약")
지원 직무와 직접 연결되는 대표 문제 해결 경험을 요약합니다.

#section("대표 사례")
#entry(
  "기간",
  "역할",
  "사례명",
  "기술 스택 또는 도메인",
  [
    - *문제*: 해결한 문제를 작성합니다.
    - *해결*: 주요 판단과 구현 방식을 작성합니다.
    - *결과*: 검증 가능한 결과와 JD 연결성을 작성합니다.
  ],
)

#section("기술적 판단")
#entry(
  "범위",
  none,
  "판단 주제",
  none,
  [
    - 선택지, 선택 이유, 결과를 작성합니다.
  ],
)

#block(breakable: false)[
  #v(0.72em, weak: true)
  #text(size: 13pt, weight: "bold", fill: accent)[링크 및 자료]
  #v(0.4em)
  #line(length: 100%, stroke: 0.5pt + rule)
  #v(0.75em)
  #meta_row([GitHub], [관련 저장소 링크를 작성합니다.])
  #v(0.54em)
  #meta_row([Demo], [데모 또는 산출물 링크를 작성합니다.])
]
