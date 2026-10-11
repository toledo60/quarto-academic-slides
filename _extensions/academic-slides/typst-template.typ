#let dark-blue = rgb(5%, 15%, 35%)
#let black-gray = rgb("262626")
#let dark-gray = rgb("acacac")
#let light-gray = rgb("d9d9d9")
#let al(body) = text(rgb("ed017d"), body)
#let alg(body) = text(rgb("00a64f"), body)
#let alr(body) = text(red, body)
#let alb(body) = text(rgb("006eb8"), body)
#let up = [↑#h(0.2em)]
#let down = [↓#h(0.2em)]
#let then = [⇝#h(0.2em)]
#let so = [⇒#h(0.2em)]
#let theme-block(title: [Theorem], body) = block(width: 100%, fill: light-gray,
  radius: 2mm, inset: 3mm, breakable: false)[
  #text(fill: dark-blue, weight: "semibold", title)
  #v(1mm)
  #text(fill: dark-blue, body)
]
#let slide(title: none, body) = {
  pagebreak(weak: true)
  if title != none {
    block(above: 3mm, below: 4mm)[
      #text(size: 19pt, fill: dark-blue, weight: "regular", title)
    ]
  }
  body
}
#let section-slide(title) = {
  pagebreak(weak: true)
  align(horizon)[#text(size: 26pt, fill: dark-blue, title)]
  pagebreak(weak: true)
}
#let lastslide() = {
  pagebreak(weak: true)
  page(fill: light-gray)[]
}
#let presentation(title: none, subtitle: none, authors: (), date: none,
  font: "Arial", codefont: "Menlo", mathfont: "STIX Two Math",
  fontsize: 14pt, aspect: "4:3", numbers: false, body) = {
  assert(aspect in ("4:3", "16:9"), message: "slide-aspect must be 4:3 or 16:9")
  set page(width: if aspect == "16:9" { 160mm } else { 128mm }, height: 96mm,
    margin: (left: 5mm, right: 5mm, top: 5mm, bottom: 7mm), numbering: none,
    footer: if numbers { align(right, text(size: 9pt, fill: dark-gray,
      context counter(page).display("1"))) } else { none })
  set text(font: font, size: fontsize, fill: black-gray, ligatures: false)
  set par(leading: 0.65em, spacing: 0.7em)
  set heading(numbering: none)
  show raw: set text(font: codefont, size: 0.8em)
  show math.equation: set text(font: mathfont)
  set list(marker: depth => text(fill: dark-gray,
    ("•", "–", "▪").at(calc.min(depth, 2))), indent: 0.5em, body-indent: 0.5em)
  set enum(numbering: (..nums) => {
    let values = nums.pos()
    numbering(if values.len() == 1 { "1." } else if values.len() == 2 { "a." } else { "i." }, values.last())
  }, indent: 0.5em, body-indent: 0.5em)
  set table(stroke: (x, y) => if y == 0 {
    (top: 0.7pt, bottom: 0.5pt)
  } else { (bottom: 0.3pt) }, inset: 3pt)
  show figure.caption: set text(size: 10pt, fill: dark-gray)
  show figure: set align(center)
  if title != none {
    v(3mm)
    text(size: 26pt, fill: dark-blue, title)
    v(1mm)
    line(length: 100%, stroke: (paint: dark-blue, thickness: 1.5pt))
    if subtitle != none { v(3mm); text(fill: dark-blue, subtitle) }
    v(15mm)
    for (i, author) in authors.enumerate() {
      if i > 0 { linebreak() }
      text(size: 17pt, author)
    }
    v(5mm)
    if date != none { text(size: 17pt, date) }
    pagebreak(weak: true)
  }
  body
}
