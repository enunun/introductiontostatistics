#import "./layout/layout.typ": *

#import "@preview/roremu:0.1.0": *

#import "@preview/in-dexter:0.7.2": *

#import "@preview/enja-bib:0.1.0": *
#import bib-setting-plain: *
#show: bib-init

#show: init

#show: set-layout(matter: "front-matter")

#outline()

#include "contents/introduction.typ"

#show: body-matter

#show: back-matter

= 索引




#columns(2)[
  #make-index(title: none, outlined: true, section-title: section-title, section-body: (letter, counter, body) => {
    block(inset: (left: .5em, right: .5em), body)
  })
]

#bibliography-list(
  title: "参考文献",
  ..bib-file(read("reference/reference.bib")),
)
