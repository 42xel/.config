# remaps
## arrowkeys in insert mode
map global insert <s-left>  "<a-;>H"
map global insert <s-down>  "<a-;>J"
map global insert <s-up>    "<a-;>K"
map global insert <s-right> "<a-;>L"

map global insert <c-left>  "<a-;>b<a-;>;"
map global insert <c-down>  "<a-;>]p"
map global insert <c-up>    "<a-;>[p"
map global insert <c-right> "<a-;>w<a-;>;"

map global insert <c-s-left>  "<a-;>B"
map global insert <c-s-down>  "<a-;>}p"
map global insert <c-s-up>    "<a-;>{p"
map global insert <c-s-right> "<a-;>W"

map global insert <s-home>   "<a-;>Gh"
map global insert <s-end>    "<a-;>Gl"
map global insert <c-home>   "<a-;>gk"
map global insert <c-end>    "<a-;>ge"
map global insert <c-s-home> "<a-;>Gk"
map global insert <c-s-end>  "<a-;>Ge"

## ctrl arrowkeys in normal mode
map global normal <c-left>  "b;"
map global normal <c-down>  "]p"
map global normal <c-up>    "[p"
map global normal <c-right> "w;"

map global normal <c-s-left>  "B"
map global normal <c-s-down>  "}p"
map global normal <c-s-up>    "{p"
map global normal <c-s-right> "W"

map global normal <c-home>   "gk"
map global normal <c-end>    "ge"
map global normal <c-s-home> "Gk"
map global normal <c-s-end>  "Ge"

