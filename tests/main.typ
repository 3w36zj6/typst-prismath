#import "../src/lib.typ": colorize-equation
#import "example-brackets.typ"

#let colors = (red, green, blue, orange)
#let delimiters = ($ (x) $).body.body.children
#let square-delimiters = ($ [x] $).body.body.children
#let plus = ($+$).body

#let round(body, color) = math.lr(
  text(fill: color, delimiters.first())
    + body
    + text(fill: color, delimiters.last()),
)

#let equation(body) = math.equation(body, block: true)
#let square(body) = math.lr(
  square-delimiters.first() + body + square-delimiters.last(),
)

#let test-no-brackets() = {
  assert.eq(colorize-equation($ x+y $, bracket-colors: colors), $ x+y $)
}

#let test-single-pair() = {
  let actual = colorize-equation($ (x) $, bracket-colors: colors)
  let expected = equation(round(($ x $).body, red))
  assert.eq(actual, expected)
}

#let test-empty-pair() = {
  let actual = colorize-equation($ () $, bracket-colors: colors)
  let expected = equation(round([], red))
  assert.eq(actual, expected)
}

#let test-nested-pairs() = {
  let actual = colorize-equation($ (((x))) $, bracket-colors: colors)
  let expected = equation(round(round(round(($ x $).body, blue), green), red))
  assert.eq(actual, expected)
}

#let test-color-cycle() = {
  let actual = colorize-equation($ (((((x))))) $, bracket-colors: colors)
  let expected = equation(
    round(
      round(round(round(round(($ x $).body, red), orange), blue), green),
      red,
    ),
  )
  assert.eq(actual, expected)
}

#let test-two-color-cycle() = {
  let actual = colorize-equation($ ((((x)))) $, bracket-colors: (red, green))
  let expected = equation(
    round(round(round(round(($ x $).body, green), red), green), red),
  )
  assert.eq(actual, expected)
}

#let test-sibling-pairs() = {
  let actual = colorize-equation($ (a)+(b) $, bracket-colors: colors)
  let expected = equation(
    round(($a$).body, red) + plus + round(($b$).body, red),
  )
  assert.eq(actual, expected)
}

#let test-square-does-not-increase-depth() = {
  let actual = colorize-equation($ [(x)] $, bracket-colors: colors)
  let expected = equation(square(round(($x$).body, red)))
  assert.eq(actual, expected)
}

#let test-fraction-pairs() = {
  let actual = colorize-equation($ frac((a), ((b))) $, bracket-colors: colors)
  let expected = equation(
    math.frac(
      round(($a$).body, red),
      round(round(($b$).body, green), red),
    ),
  )
  assert.eq(actual, expected)
}

#let test-root-pairs() = {
  let actual = colorize-equation($ root((n), ((x))) $, bracket-colors: colors)
  let expected = equation(
    math.root(
      round(($n$).body, red),
      round(round(($x$).body, green), red),
    ),
  )
  assert.eq(actual, expected)
}

#let check-equation(value) = assert.eq(
  colorize-equation(value, bracket-colors: colors).func(),
  math.equation,
)

#let test-accent() = check-equation($ accent((a + (b)), arrow) $)

#let test-attachments() = check-equation(
  $
    attach(x, t: ((a)), b: ((b)), tl: (c), tr: (d), bl: (e), br: (f))
  $,
)

#let test-binomial() = check-equation($ binom((n), ((k))) $)

#let test-cancel() = check-equation($ cancel((a + (b))) $)

#let test-cases() = check-equation($ cases((a), (b + (c))) $)

#let test-matrix() = check-equation($ mat((a), (b + (c)); ((d)), (e)) $)

#let test-decoration() = check-equation(
  $
    underbrace((a + (b)), (c + (d)))
  $,
)

#let test-vector() = check-equation($ vec((a), (b + (c))) $)

#let test-element-options() = {
  let body = ($ (a + (b)) $).body
  let elements = (
    math.accent(body, ($ arrow $).body, size: 1em),
    math.cancel(
      body,
      angle: 45deg,
      cross: true,
      inverted: true,
      length: 100%,
      stroke: 1pt,
    ),
    math.cases(body, body, delim: "{", gap: 0.5em, reverse: true),
    math.lr(body, size: 100%),
    math.mat(
      body,
      body,
      delim: "(",
      align: center,
      augment: none,
      gap: 0.5em,
      row-gap: 0.5em,
      column-gap: 0.5em,
    ),
    math.vec(body, body, align: center, delim: "(", gap: 0.5em),
  )
  for elem in elements {
    check-equation(math.equation(elem, block: true))
  }
}

#let test-equation-options() = {
  let original = math.equation(
    ($ (x) $).body,
    block: true,
    number-align: top,
    numbering: "(1)",
    supplement: [Equation],
  )
  let result = colorize-equation(original, bracket-colors: colors)
  assert.eq(result.number-align, top)
  assert.eq(result.numbering, "(1)")
  assert.eq(result.supplement, [Equation])
}

#let test-root-without-index() = check-equation($ sqrt((x)) $)

#let test-decoration-without-annotation() = check-equation($ underbrace((x)) $)
