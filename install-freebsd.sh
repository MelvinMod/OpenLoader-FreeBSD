#!/bin/bash

set -e

echo "Installing OpenLoader on FreeBSD..."

PREFIX="${PREFIX:-/usr/local}"

echo "Installation prefix: $PREFIX"

ARCHIVE=""
if [ -f "SS14.Launcher_FreeBSD.tar.gz" ]; then
    ARCHIVE="SS14.Launcher_FreeBSD.tar.gz"
elif [ -f "SS14.Launcher_FreeBSD.tar.zst" ]; then
    ARCHIVE="SS14.Launcher_FreeBSD.tar.zst"
elif [ -f "../SS14.Launcher_FreeBSD.tar.gz" ]; then
    ARCHIVE="../SS14.Launcher_FreeBSD.tar.gz"
elif [ -f "../SS14.Launcher_FreeBSD.tar.zst" ]; then
    ARCHIVE="../SS14.Launcher_FreeBSD.tar.zst"
else
    echo "Error: SS14.Launcher_FreeBSD.tar.* not found!"
    echo "Please run ./build.sh first"
    exit 1
fi

echo "Found archive: $ARCHIVE"

echo "Creating directories..."
mkdir -p "$PREFIX/lib/openloader/bin"
mkdir -p "$PREFIX/lib/openloader/bin/loader"
mkdir -p "$PREFIX/lib/openloader/Marsey/Mods"
mkdir -p "$PREFIX/lib/openloader/Marsey/ResourcePacks"
mkdir -p "$PREFIX/bin"
mkdir -p "$PREFIX/share/applications"
mkdir -p "$PREFIX/share/icons/hicolor/256x256/apps"

echo "Extracting files..."
tar -xf "$ARCHIVE" -C /tmp/openloader-install

echo "Copying launcher..."
cp /tmp/openloader-install/bin/SS14.Launcher "$PREFIX/bin/"
cp /tmp/openloader-install/bin/SS14.Launcher.dll "$PREFIX/lib/openloader/bin/"

echo "Copying loader..."
cp /tmp/openloader-install/bin/loader/SS14.Loader "$PREFIX/lib/openloader/bin/loader/"
cp /tmp/openloader-install/bin/loader/SS14.Loader.dll "$PREFIX/lib/openloader/bin/loader/"

echo "Copying dotnet runtime..."
if [ -d "/tmp/openloader-install/dotnet" ]; then
    cp -r /tmp/openloader-install/dotnet "$PREFIX/lib/openloader/"
fi

if [ -f "/tmp/openloader-install/bin/signing_key" ]; then
    cp /tmp/openloader-install/bin/signing_key "$PREFIX/lib/openloader/bin/"
fi

ln -sf "$PREFIX/bin/SS14.Launcher" "$PREFIX/bin/openloader"
ln -sf "$PREFIX/bin/SS14.Launcher" "$PREFIX/bin/openloader-kde"

if [ -f "ss14-launcher.desktop" ]; then
    cp ss14-launcher.desktop "$PREFIX/share/applications/"
fi

rm -rf /tmp/openloader-install

echo ""
echo "Installation complete!"
echo ""
echo "To launch OpenLoader, run:"
echo "  $PREFIX/bin/SS14.Launcher"
echo "  or"
echo "  openloader"
echo ""
echo "Add $PREFIX/bin to your PATH if not already done:"
echo "  echo 'export PATH=$PREFIX/bin:\$PATH' >> ~/.profile"
echo ""
