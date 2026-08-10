#import "../src/lib.typ": colorize-equation

#set page(width: 180pt, height: 50pt)
#set align(horizon)

#colorize-equation($ A + (B + (C + (D + E))) + F $)

#colorize-equation(
  $ A + (B + (C + (D + E))) + F $,
  bracket-colors: (rgb("#ffd700"), rgb("#da70d6"), rgb("#179fff")),
)
