#import "./layout/layout.typ": *

#import "@preview/roremu:0.1.0": *

#import "@preview/in-dexter:0.7.2": *

#import "@preview/enja-bib:0.1.0": *
#import bib-setting-plain: *
#show: bib-init

#show: init

#show: set-layout(matter: "front-matter")

#outline()

#show: body-matter

= いい感じの章

以下の数式を参照：@Eq1

$ E = m c^2 $ <Eq1>

= ああああああ
以下の数式を参照：@Eq2

$ E = m c^2 $ <Eq2>

#roremu(500)

== fuga

以下の数式を参照：@Eq3

$ E = m c^2 $ <Eq3>

#roremu(300)

=== fgfff

#index-main(display: "数式")[$E = m c^2$]
以下の数式を参照：@Eq4

$ E = m c^2 $ <Eq4>

#roremu(500)

==== red

以下の数式を参照：@Eq5

$ E = m c^2 $ <Eq5>

#roremu(900)

= hhhh
以下の数式を参照：@Eq6

$ E = m c^2 $ <Eq6>

#roremu(1100)

== fdjfdjkl
以下の数式を参照：@Eq7

$ E = m c^2 $ <Eq7>

#roremu(4000)

== fjkdlfkldkf

以下の数式を参照：@Eq8

$ E = m c^2 $ <Eq8>

#roremu(3000)

本文$x = y$ああああ

いいいい
ｋｆｌｋｆｋｌｄｆｆｄｆｄｋｆｄｋｄｆｌｋｆｄｋｌｄｆｌｋｋｌｆｄｋｌｄｆｌｄｋｆｋｌｄｆｌｋｄｆｋｌｆｄｌｋｄｆｋｌｆｄｌｋｋｌ
ｋｆｌｋｆｋｌｄｆｆｄｆｄｋｆｄｋｄｆｌｋｆｄｋｌｄｆｌｋｋｌｆｄｋｌｄｆｌｄｋｆｋｌｄｆｌｋｄｆｋｌｆｄｌｋｄｆｋｌｆｄｌｋｋｌ

ｋｆｌｄｆｄｌｋｋｄｆｌｆｌ

// --- Typst Markup Syntax Examples ---
// https://typst.app/docs/reference/syntax/

ああああああ \
あああああああ

これは_強調_です。
これは*強い強調*です。
これは#link("https://example.com")への#link("https://example.com")[リンク]です。
これは`Raw Text`です。
#index(display: "Raw Text")[$12$]

- 箇条書き1
- 箇条書き2
  - ネストされた項目

1. 番号付きリスト1
2. 番号付きリスト2

#index(display: "寿司")[すし]

#table(
  columns: 2,
  [セル1, セル2], [セル3, セル4],
)

#list(
  [リスト項目A],
  [リスト項目B],
)

#enum(
  [番号付きA],
  [番号付きB],
)

#quote[
  これはTypstの引用ブロックです。
]

以下の数式を参照：@Eq

#index(display: $E = m c^2$)[すうしき]
$ E = m c^2 $ <Eq>

#show: back-matter

= 索引




#columns(2)[
  #make-index(title: none, outlined: true, section-title: section-title, section-body: (letter, counter, body) => {
    block(inset: (left: .5em, right: .5em), body)
  })
]

#bibliography-list(
  title: "参考文献",
  bib-item(
    label: <Reynolds:PhilTransRoySoc1883>,
    author: "Reynolds",
    year: "1883",
    yomi: "reynolds, o.",
    (
      [Reynolds, O., An experimental investigation of the circumstances which determine whether the motion of water shall be direct or sinuous, and of the law of resistance in parallel channels, Philosophical Transactions of the Royal Society of London (1883],
      [), Vol. 174, pp. 935–982],
    ),
  ),
)
