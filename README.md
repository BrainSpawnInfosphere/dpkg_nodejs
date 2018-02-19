# [dpkg_nodejs](https://nodejs.org/en/)

node package for ARM6. nodejs already supports the latest versions on ARM7 (Pi 3 and up) with debian packages, but the Pi Zero is still an ARM6.

## Package Setup

- DEBIAN
    - control (required)
    - templates (optional)
    - preinst (optional, chmod 0755)
    - postinst (optional, chmod 0755)
    - prerm (optional, chmod 0755)
    - postrm (optional, chmod 0755)

 where:

**preinst** – this script executes before that package will be unpacked from its Debian archive (“.deb”) file. Many ‘preinst’ scripts stop services for packages which are being upgraded until their installation or upgrade is completed (following the successful execution of the ‘postinst’ script).

**postinst** – this script typically completes any required configuration of the package foo once it has been unpacked from its Debian archive (“.deb”) file. Often ‘postinst’ scripts ask the user for input, and/or warn the user that if they accept the default values, they should remember to go back and re-configure that package as the situation warrants. Many ‘postinst’ scripts then execute any commands necessary to start or restart a service once a new package has been installed or upgraded.

**prerm** – this script typically stops any daemons which are associated with a package. It is executed before the removal of files associated with the package.

**postrm** – this script typically modifies links or other files associated with foo, and/or removes files created by the package.

## Build the Package

You should be able to use the package already built in this
repo, but if you want/need to build it, do:

	./build-pkg.sh 3.4.0

Note, you pass the version number to `build-opencv.sh` and it gets appended
onto the packages name. After, running the above commands, you should 
now have a shiny new debian package.

## Check

You can double check your package with: `dpkg-deb --info <deb file>`

```bash
pi@mario opencv3 $ dpkg-deb --info nodejs-3.4.0.deb 
 new debian package, version 2.0.
 size 7369108 bytes: control archive=651 bytes.
     159 bytes,     7 lines   *  control              
     292 bytes,    10 lines      copyright            
       6 bytes,     1 lines   *  install              
     512 bytes,    25 lines   *  postinst             #!/bin/bash
 Package: nodejs
 Architecture: all
 Maintainer: Kevin
 Depends: debconf (>= 0.5.00)
 Priority: optional
 Version: 3.4.0
 Description: Kevins nodejs
 ```

## Install

Make sure to run update opencv script so you have the right libraries installed and setup.

	sudo dpkg -i nodejs-3.4.0.deb

## References

 [Package setup details](https://www.leaseweb.com/labs/2013/06/creating-custom-debian-packages/)

# Licenses

## MIT License for build scripts

Copyright (c) 2016 Kevin

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Documentation

 <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" align="middle"/></a><br />This documentation is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.
