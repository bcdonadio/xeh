#!/bin/bash

VERSION="0.1.1"

if [ "$1" == "build" ]; then
	mkdir -p package/DEBIAN
	mkdir -p package/usr/bin
	echo \
"Package: xeh
Version: $VERSION
Section: utils
Priority: optional
Architecture: all
Essential: no
Depends: bash, openssh-client, sshpass, xvnc4viewer, xcp-xe, coreutils, ncurses-bin, procps, grep, util-linux, stunnel
Maintainer: Bernardo Donadio <bcdonadio@propus.com.br>
Description: Helper for Xen's xe
 This is a helper script to ease the use of the Xen's administration tool xe.
" > package/DEBIAN/control
	chmod +x xeh
	cp xeh package/usr/bin/xeh
	fakeroot dpkg-deb --build package
	mv package.deb xeh-$VERSION.deb
elif [ "$1" == "clean" ]; then
	rm -Rf *.deb
	rm -Rf package
else
	echo "Action not recognized."
fi
