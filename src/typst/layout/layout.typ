// 『統計学は最強の学問ではない』用typstレイアウトファイル
#import "@preview/hydra:0.6.2": *
#import "@preview/cjk-spacer:0.1.0": cjk-spacer

#let Fonts = (
  main: ("XITS", "Noto Serif CJK JP"),
  sans: ("Fira Sans", "Noto Sans CJK JP"),
  mono: ("Fira Mono", "Noto Sans Mono CJK JP"),
  math: "XITS Math",
)



// 見出しラベル用汎用関数
#let heading-label(level: int, counter-label: str, matter-state: str) = {
  let prefix = ("第", "§", "§§", "§§§").at(level - 1)
  let suffix = ("章", "", "", "").at(level - 1)
  if matter-state == "front-matter" {
    return ""
  } else if matter-state == "back-matter" {
    return ""
  } else if matter-state == "appendix" {
    return "付録" + counter-label
  }
  return prefix + counter-label + suffix
}

#let init = body => {
  show: cjk-spacer
  set page(
    paper: "a5",
    flipped: false,
    binding: left,
    margin: (
      top: 25mm,
      bottom: 25mm,
      inside: 15mm,
      outside: 15mm,
    ),
    // ページヘッダーにページ番号を出すのでここでは不要
    numbering: none,
  )

  set text(
    size: 11pt,
    lang: "ja",
    font: Fonts.main,
  )
  // 段落設定
  set par(
    leading: .8em,
    justify: true,
    linebreaks: "simple",
    first-line-indent: (amount: 1em, all: true),
  )
  set outline(indent: 0em)

  show outline.entry: it => context {
    let matter = if it.element.body == [目次] or it.element.body == [はじめに] {
      "front-matter"
    } else if it.element.body == [参考文献] or it.element.body == [索引] {
      "back-matter"
    } else {
      "body-matter"
    }

    let counter-label = if matter == "front-matter" or matter == "back-matter" {
      ""
    } else if matter == "appendix" {
      it.prefix()
    } else {
      it.prefix()
    }

    let label = heading-label(level: it.level, counter-label: counter-label, matter-state: matter)
    link(
      it.element.location(),
      it.indented(label, it.inner()),
    )
    v(.1em)
  }

  show outline.entry.where(level: 1): it => {
    set text(weight: "regular", font: Fonts.sans, size: 12pt)
    set block(above: 1.5em)
    it
  }
  set outline.entry(fill: repeat([.], gap: .4em))

  set math.equation(
    numbering: num => numbering("(1.1)", counter(heading).get().first(), num),
    number-align: bottom,
  )
  set figure(
    numbering: num => numbering("1.1", counter(heading).get().first(), num),
  )
  show math.equation: set text(font: Fonts.math)
  body
}



#let set-layout(matter: str) = body => {
  let header-numbering = if matter == "front-matter" {
    none
  } else if matter == "body-matter" {
    "1.1"
  } else if matter == "appendix" {
    "1.1"
  } else {
    none
  }
  set heading(numbering: header-numbering)
  // ページ上端に見出しの情報を追加
  set page(
    header: context {
      let is-chapter-page = query(heading.where(level: 1)).map(h => h.location().page()).contains(here().page())
      let left-text = ""
      let right-text = ""
      let cont = query(heading.where(level: 1)).map(h => h.body).at(2)
      let chaptercount = counter(heading.where(level: 1)).display()
      let body = query(heading.where(level: 1)).map(h => h.body).at(int(counter(heading.where(level: 1)).display()))
      if calc.even(here().page()) and hydra(1) != [目次] {
        left-text = if is-chapter-page { "" } else { text(weight: "semibold", font: Fonts.main)[#here().page()] }
        right-text = (
          heading-label(
            level: 1,
            counter-label: counter(heading.where(level: 1)).display(),
            matter-state: matter,
          )
            + h(.5em)
            + body
        )
      } else {
        left-text = if is-chapter-page { "" } else {
          heading-label(level: 2, counter-label: hydra(2), matter-state: matter)
        }
        right-text = text(weight: "semibold", font: Fonts.main)[#here().page()]
      }
      stack(
        dir: ltr,
        spacing: 1fr,
        [#left-text],
        [#right-text],
      )
      v(-1.5mm)
      if not is-chapter-page {
        line(length: 100%)
      }
    },
  )

  // 見出し設定
  show heading: it => {
    for level in range(it.level + 1, 5) {
      counter(heading.where(level: level)).update(0)
    }
    let size = (24pt, 18pt, 14pt, 12pt).at(it.level - 1)
    let vspace = (.5em, 0em, 0em, 0em).at(it.level - 1)
    let weight = ("semibold", "medium", "medium", "medium").at(it.level - 1)
    set par(first-line-indent: (amount: 0em, all: true))
    let label = heading-label(level: it.level, counter-label: counter(heading).display(), matter-state: matter)
    let format(contents) = if it.body == [目次] {
      text(size: size, font: Fonts.sans, weight: weight)[#contents]
    } else {
      text(
        size: size,
        font: Fonts.sans,
        weight: weight,
      )[#label#if it.level == 1 { linebreak() } else { " " }#it.body]
    }
    if it.level == 1 {
      counter(math.equation).update(0)
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
      counter(figure.where(kind: raw)).update(0)
      set page(header: context {})
      pagebreak(weak: true, to: "odd")
    }
    v(vspace) + (format(it.body)) + v(vspace)
  }
  body
}



#let front-matter = body => {
  show: set-layout(matter: "front-matter")
  body
}

#let body-matter = body => {
  show: set-layout(matter: "body-matter")
  body
}

#let back-matter = body => {
  show: set-layout(matter: "back-matter")
  body
}

#let section-title(letter, counter) = {
  set align(center + horizon)
  set text(weight: "regular", font: Fonts.sans, size: 10pt)
  block(above: 1.1em, below: .4em)[#box(baseline: -.06em)[#text(size: 6pt, color.luma(110))[■]]#h(.5em)#letter#h(
      .5em,
    )#box(
      baseline: -.06em,
    )[#text(
      size: 6pt,
      color.luma(110),
    )[■]]]
  line(length: 100%, stroke: (thickness: .6pt))
}
