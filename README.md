# snek
Simple snake game in fennel. Made with [Love](https://love2d.org/)

## Release build
Inside the `target` directory there is a `snek.love` executable.

## Developing
The `src/` directory contains the source code that can be compiled to lua via:
```
fennel --compile src/main.fnl > target/main.lua
fennel -- compile src/config.fnl > target/config.lua
```
To run the game (assuming you have the love binary installed) on Mac OS I use
```
open -n -a love ~/path/to/main.lua
```

To create a binary with the contents of the target directory, cd into `target`:
```
zip -9 -r snek.love .
```
