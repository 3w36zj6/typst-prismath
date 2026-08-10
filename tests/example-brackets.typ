#import "../src/lib.typ": colorize-equation

#set page(width: 18cm, height: auto, margin: 1cm)
#set text(size: 16pt)

#let colors = (red, green, blue, orange)
#let show-equation(body) = colorize-equation(body, bracket-colors: colors)

#show-equation($ (x) $)
#show-equation($ (((x))) $)
#show-equation($ (((((x))))) $)
#show-equation($ (a) + (b) + ((c)) $)
#show-equation($ [((x))] + {((y))} $)
#show-equation($ frac((a + (b)), ((c + (d)))) $)
#show-equation($ root((n + (1)), ((x + (y)))) $)
#show-equation($ cases((a + (b)), ((c)) + (d)) $)
#show-equation($ mat((a), ((b)); (((c))), (d)) $)
#show-equation($ vec((a), ((b)), (((c)))) $)
