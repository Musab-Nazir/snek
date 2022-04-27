# snek
Simple snake game in fennel. Made with [Love](https://love2d.org/)

## Release build
Inside the `target` directory there is a `snek.love` executable that can be run. Might need Love installed on the machine

## Developing
The `src/` directory contains the source code that can be compiled to lua via:
```
fennel --compile src/main.fnl > target/main.lua
fennel -- compile src/conf.fnl > target/conf.lua
```
To run the game (assuming you have the love binary installed) on Mac OS I use
```
open -n -a love ~/path/to/main.lua
```
