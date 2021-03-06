# Examples

  1. [U.S. Presidents by Birth Place](https://akovacs.github.io/elm-sortable-table/presidents.html)
  2. [Travel Planner for the Mission District in San Francisco](https://akovacs.github.io/elm-sortable-table/travel.html)
  3. [Color Names and Hexadecimal Codes](https://akovacs.github.io/elm-sortable-table/colors.html)


## Build Instructions

Use [elm-github-install](https://github.com/gdotdesign/elm-github-install) to install unofficial packages which are not in the elm package registry.

```bash
npm install elm-github-install -g

git clone https://github.com/akovacs/elm-sortable-table.git
cd elm-sortable-table
cd examples
elm-github-install
elm-reactor
```

Then navigate to `1-presidents.elm`, `2-travel.elm`, or `3-colors.elm` from [localhost:8000](http://localhost:8000/). When using `elm-reactor`, refreshing a page that ends with `.elm` will recompile the code in that file and show you the new result.

To build a static HTML file, execute:

```bash
elm-make 3-colors.elm --output=colors.html
```
