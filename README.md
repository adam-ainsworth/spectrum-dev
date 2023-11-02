# Spectrum Dev

Here is a semi automated environment for building Spectrum machine code programs. It is quite limited at the moment, but you can build it using ```docker compose up``` (add ```--build``` to rebuild it) and once it is ready you can visit [localhost](http://localhost) to load a local version of JSSpeccy3.

# Usage

Once the container is built and you have it running in your browser, you can add a single program.bas (a BASIC loader), program.scr (a standard 6912 byte loading screen) and program.asm - your assembly program in Z80 assembler. Save this in /src and whenever any of them are changed, it will automatically reload in the browser.

If you have tapeTrapsEnabled set to true, you won't see the screen as everything autoloads, but there is a link in the top right for you to download the built tap file.

## Components

The following tools are used

* [Docker](https://www.docker.com/) with the [ubuntu/nginx image](https://hub.docker.com/r/ubuntu/nginx)
* [zmakebas](https://github.com/z00m128/zmakebas)
* [pasmo](https://pasmo.speccy.org/)
* [bin2tap](http://zeroteam.sk/bin2tap.html) (albeit an old version and building it from source)
* [JSSpeccy 3](https://github.com/gasman/jsspeccy3)

I also relied heavily on code / advice from [this gist](https://gist.github.com/wesort/fabf99b0d4c06093057ac7e3cdcd38fd), and [this tutorial](https://benjamin.computer/posts/2022-04-22-ZX-coding.html) with the [accompanying code](https://github.com/OniDaito/speccy).

## Environment variables

You can can a file named .env with the following environment variables

* MACHINE - 48, 128, 5
* AUTOLOADTAPES - 0, 1
* TAPEAUTOLOADMODE - default, usr0
* KEYBOARDENABLED - 0, 1
* UIENABLED - 0, 1
* TAPETRAPSENABLED - 0, 1

Please see the [JSSpeccy 3 readme](https://github.com/gasman/jsspeccy3#embedding) for valid values.

**Note** even if you don't need to use it, you must rename .env.example to .env or Docker won't start.

## Notes

I had a couple of false starts, initially using lando and trying to run it with Webpack but it was just too fiddly and like trying to fit square pegs into round holes, so I've gone back to basics with bash scripts.

I have included a prebuilt version of bin2tap (v1.3), which is the newest that I can gett building. If you want to try newer versions, you can do so within the container by updating bin2tap.c and uncommenting the build line in the Dockerfile. You will need to copy this file to /root/src to easily get it back out of the container. *Please let me know if you manage this :-)*

Some of the arguments weren't working with this latest release of JSSpeccy, although they are included in the source code. While I could clone it and build it within the container, it would be very bloated, so I've decided to build it once myself and include it here for now.

## TODO

* Allow more flexibility with the compile options & allow multi load tape images
* Add options for including basic and screen files

Feel free to submit any suggestions, and let me know if you find this useful. 

## Example ASM program to get you started

```
org 32768

ld hl, $0000
ld de, $4000
ld bc, $1800
ldir
di
halt
```

## Licence

Spectrum Dev is licensed under the GPL version 3 - see LICENCE.
