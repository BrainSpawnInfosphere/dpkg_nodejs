#!/bin/bash

PICHIP=$(uname -m);
if [ "$EUID" -ne 0 ]
    then echo "You need to install as root by using sudo ./Install-Node.sh";
    exit
fi

if [[ $# -ne 1 ]]; then
    echo "Please supply an Nodejs version number"
    echo "ex: ./build-pkg.sh 3.4.0"
    exit
fi

ROOT=`pwd`

VERSION=$1

# if the dir exists, remove it ... going to dynamically create it
if [[ -d "nodejs-dpkg" ]]; then
	rm -fr nodejs-dpkg
fi

mkdir -p nodejs-dpkg
mkdir -p nodejs-dpkg/DEBIAN

cat <<EOF >"nodejs-dpkg/DEBIAN/control"
Package: nodejs
Architecture: all
Maintainer: Kevin
Depends: debconf (>= 0.5.00)
Priority: optional
Version: ${VERSION}
Description: kevin's node package
EOF

cat <<EOF >"nodejs-dpkg/DEBIAN/install"
/usr/local/*
EOF

cat <<EOF >"nodejs-dpkg/DEBIAN/postinst"
#!/bin/bash
set -e

echo ""
echo "============================="
echo "| Clean up and fix perms    |"
echo "============================="
echo ""

chown -R pi:pi /home/pi
chown -R pi:pi /usr/local

echo ""
echo "============================="
echo "|      <<< Done >>>         |"
echo "============================="
echo ""
EOF

LINKTONODE=$(curl -G https://nodejs.org/dist/latest-v9.x/ | awk '{print $2}' | grep -P 'href=\"node-v9\.\d{1,}\.\d{1,}-linux-'$PICHIP'\.tar\.gz' | sed 's/href="//' | sed 's/<\/a>//' | sed 's/">.*//');
# curl -G https://nodejs.org/dist/latest-v9.x/ | awk '{print $2}' | grep -P 'href=\"node-v9\.\d{1,}\.\d{1,}-linux-armv9l\.tar\.gz' | sed 's/href="//' | sed 's/<\/a>//' | sed 's/">.*//'

NODEFOLDER=$(echo $LINKTONODE | sed 's/.tar.gz/\//');

#Next, Creates directory for downloads, and downloads node 8.x
mkdir -p tempNode && cd tempNode && wget https://nodejs.org/dist/latest-v9.x/$LINKTONODE;
tar -xzf $LINKTONODE;

#Remove the tar after extracing it.
rm $LINKTONODE;

#This next line will copy Node over to the appropriate folder.
mv ./$NODEFOLDER ../nodejs-dpkg/usr

cd ${ROOT}
#chmod 0755 nodejs-dpkg/DEBIAN/preinst
chmod 0755 nodejs-dpkg/DEBIAN/postinst


echo "building Nodejs ${VERSION}"
dpkg-deb -v --build nodejs-dpkg nodejs-${VERSION}.deb

echo ""
echo "reading debian package: \n"
dpkg-deb --info nodejs-${VERSION}.deb

rm -fr nodejs-dpkg
rm -fr tempNode
