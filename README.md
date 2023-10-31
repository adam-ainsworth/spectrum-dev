# Spectrum dev environment

Here is a semi automated environment for building Spectrum machine code programs. It is quite limited at the moment, but you can build it using ```docker compose up``` and once it is ready you can visit [localhost](http://localhost) to load a local version of JSSpeccy3.

To deploy your development, simply save a text assembly program (named program.asm) in /src, and it will automatically reload in the browser.

The following tools are used

* [Docker](https://www.docker.com/) with the [ubuntu/nginx image](https://hub.docker.com/r/ubuntu/nginx)
* [pasmo](https://pasmo.speccy.org/)
* [bin2tap](http://zeroteam.sk/bin2tap.html) (albeit using an old version and building it from scratch)
* [JSSpeccy 3](https://github.com/gasman/jsspeccy3)

I also relied heavily on code / advice from [this gist](https://gist.github.com/wesort/fabf99b0d4c06093057ac7e3cdcd38fd) and [this tutorial](https://github.com/OniDaito/speccy).

I had a couple of false starts, initially using lando and trying to run it with Webpack but it was just too fiddly and like trying to fit square pegs into round holes, so I've gon back to basics with bash scripts.

There's plenty I can do to improve it;

* Separate the docker containers out
* Get a more up-to-date version of bin2tap
* Allow more flexibility with the compile options and emulator setting (probably via a .env file)
* Find a more elegant way of refreshing the browser than merely checking once a second for a file change
* Sort out the GPL licensing

Feel free to submit any suggestions, and let me know if you find this useful. 

## Example ASM program to get you started

```
org 32768

ld hl, $0000
ld de, $4000
ld bc, $1800
ldir
ret
```