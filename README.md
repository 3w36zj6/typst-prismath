# prismath

A mathematical brackets colorizer for Typst.

## Usage

```typst
#import "@preview/prismath:0.1.0": *

#colorize-equation($ A + (B + (C + (D + E))) + F $)

#colorize-equation(
  $ A + (B + (C + (D + E))) + F $,
  bracket-colors: (rgb("#ffd700"), rgb("#da70d6"), rgb("#179fff")),
)
```
