A simple parser for converting svg graphics into JSON, to be used with d3.js


## Compiler

execute compiler: `./compiler.rb`

This takes all SVG files from `svg/` and renders `js/defs.js` for use with the app

## Saving SVG files

Adobe Illustrator save as svg default format *seems* pretty good as is.
From Inkscape, use `save as optomized svg format` as this puts one path per line. Also check `Enable Id stripping`
