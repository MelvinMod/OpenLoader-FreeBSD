#!/bin/bash

set -e

cd "$(dirname "$0")/.."

echo "Publishing OpenLoader for FreeBSD..."

rm -rf **/bin bin/publish/FreeBSD
rm -f SS14.Launcher_FreeBSD.tar.*

dotnet publish SS14.Launcher/SS14.Launcher.csproj \
    /p:FullRelease=True -c Release --no-self-contained -r linux-x64 /nologo /p:RobustILLink=true
dotnet publish SS14.Loader/SS14.Loader.csproj \
    -c Release --no-self-contained -r linux-x64 /nologo

mkdir -p bin/publish/FreeBSD/bin
mkdir -p bin/publish/FreeBSD/bin/loader
mkdir -p bin/publish/FreeBSD/Marsey/Mods
mkdir -p bin/publish/FreeBSD/Marsey/ResourcePacks
mkdir -p bin/publish/FreeBSD/dotnet

cp PublishFiles/SS14.Launcher bin/publish/FreeBSD/
cp SS14.Launcher/bin/Release/net10.0/linux-x64/publish/* bin/publish/FreeBSD/bin/
cp SS14.Loader/bin/Release/net10.0/linux-x64/publish/* bin/publish/FreeBSD/bin/loader/
cp SS14.Launcher/signing_key bin/publish/FreeBSD/bin/

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
if [ -d "$SCRIPT_DIR/1/dotnet" ]; then
    cp -r "$SCRIPT_DIR/1/dotnet/"* bin/publish/FreeBSD/dotnet/
fi

cd bin/publish/FreeBSD
tar -czvf ../../../SS14.Launcher_FreeBSD.tar.gz .
tar --zstd -cvf ../../../SS14.Launcher_FreeBSD.tar.zst .
cd ../..

rm -rf bin/publish/FreeBSD

echo "FreeBSD publish complete:"
echo "  SS14.Launcher_FreeBSD.tar.gz"
echo "  SS14.Launcher_FreeBSD.tar.zst"
