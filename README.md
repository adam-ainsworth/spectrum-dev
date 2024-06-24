# Spectrum Dev

Here is a semi automated environment for building Spectrum machine code programs. It is quite limited at the moment, but you can build it using ```docker compose up``` (add ```--build``` to rebuild it) and once it is ready you can visit [localhost](http://localhost) to load a local version of JSSpeccy3.

## Usage

Once the container is built and you have it running in your browser, you need to create a config file in /src for the blocks to go on the tape. By default this is named ```program.conf``` but you can set it to anything you like via an environment variable (see below), meaning you can develop multiple programs with the same setup. The config file is of the format

```filename:headername:start```

The filename can be anything you choose but the extension will determine how it is treated;

* .bas - BASIC program, start signifies the line number to auto run from
* .scr / .bin / .txt - raw binary (or text), will be added as-is, start is where to place the code within RAM
* .asm - Z80 code to be assembled, start is where to place the code within RAM

For code files, put the start as 99999 to create a headerless file.

It is advisable to keep all the files within /src and not to put spaces in the filenames - you can use subfolders if you wish. The header name (ie. the program name when loading) cannot have spaces in.

If you are developing multiple programs, you can keep them in subfolders. Just use the FOLDER variable in ```.env```. If you wish to change which program you are working on, just change this value and restart the container.

Whenever any files in /src (or selected subfolder) are changed, the tap will be rebuilt and automatically reloaded in the browser.

This can be prevented however by adding ```PAUSE``` on its own line anywhere within the config file, which will abort the compilation when it is reached (and therefore it is best to put it as the first line). If you are updating several files at the same time and don't want the browser to keep refreshing everytime you save a file, this is helpful. Simple remove the line to resume compilation.

If you have tapeTrapsEnabled set to true, you won't see the screen as everything autoloads, but there is a link in the top right for you to download the built tap file.

To SSH into the container run ```docker exec -it spectrum-dev /bin/bash```

There is a set of example files in /example. Feel free to submit any suggestions, and let me know if you find this useful. 

## Components

The following tools are used

* [Docker](https://www.docker.com/) with the [ubuntu/nginx image](https://hub.docker.com/r/ubuntu/nginx)
* [zmakebas](https://github.com/z00m128/zmakebas)
* ~~[pasmo](https://pasmo.speccy.org/)~~
* ~~[bin2tap](http://zeroteam.sk/bin2tap.html)~~
* [SjASMPlus](https://github.com/z00m128/sjasmplus) / [docs](https://z00m128.github.io/sjasmplus/documentation.html)
* [taput](https://github.com/Sivvus/taput)
* [JSSpeccy 3](https://github.com/gasman/jsspeccy3)

I also relied heavily on code / advice from [this gist](https://gist.github.com/wesort/fabf99b0d4c06093057ac7e3cdcd38fd), and [this tutorial](https://benjamin.computer/posts/2022-04-22-ZX-coding.html) with the [accompanying code](https://github.com/OniDaito/speccy).

## Environment variables

You can can a file named .env with the following environment variables

* PROGRAM - the name of your config file (defaults to program.conf if omitted)
* FOLDER - subfolder within /src
* MACHINE - 48, 128, 5
* AUTOLOADTAPES - 0, 1
* TAPEAUTOLOADMODE - default, usr0
* KEYBOARDENABLED - 0, 1
* UIENABLED - 0, 1
* TAPETRAPSENABLED - 0, 1

Please see the [JSSpeccy 3 readme](https://github.com/gasman/jsspeccy3#embedding) for valid values.

**Note** even if you don't need to use it, you must copy .env.example to .env or Docker won't start.

## Notes

I had a couple of false starts, initially using lando and trying to run it with Webpack but it was just too fiddly and like trying to fit square pegs into round holes, so I've gone back to basics with bash scripts.

I have included a prebuilt version of taput but you can change the Dockerfile to rebuild it if you wish.

Some of the arguments weren't working with this latest release of JSSpeccy, although they are included in the source code. While I could clone it and build it within the container, it would be very bloated, so I've decided to build it once myself and include it here for now.

I originally used Pasmo for compilation, and that was fine until I started using sources from the web that use directives it didn't recognise. Therefore I have changed it over to SjASMPlus. I have left the Pasmo infrastructure in there and will enable its usage via an env variable at some point.

## Licence

Spectrum Dev is licensed under the GPL version 3 - see LICENCE.
