#!/bin/bash

set -e

echo "Building OpenLoader FreeBSD port..."

cd "$(dirname "$0")"

if [ ! -d "../OpenLoader-main" ]; then
    echo "Error: OpenLoader-main directory not found"
    exit 1
fi

echo "Creating FreeBSD-specific build..."

mkdir -p bin/publish/FreeBSD
mkdir -p bin/publish/FreeBSD/bin
mkdir -p bin/publish/FreeBSD/bin/loader
mkdir -p bin/publish/FreeBSD/Marsey/Mods
mkdir -p bin/publish/FreeBSD/Marsey/ResourcePacks

echo "Publishing SS14.Launcher for FreeBSD..."
dotnet publish ../OpenLoader-main/SS14.Launcher/SS14.Launcher.csproj \
    /p:FullRelease=True -c Release --no-self-contained -r freebsd-x64 /nologo /p:RobustILLink=true

echo "Publishing SS14.Loader for FreeBSD..."
dotnet publish ../OpenLoader-main/SS14.Loader/SS14.Loader.csproj \
    -c Release --no-self-contained -r freebsd-x64 /nologo

echo "Copying files..."
cp ../OpenLoader-main/PublishFiles/SS14.Launcher bin/publish/FreeBSD/
cp ../OpenLoader-main/SS14.Launcher/bin/Release/net10.0/freebsd-x64/publish/* bin/publish/FreeBSD/bin/
cp ../OpenLoader-main/SS14.Loader/bin/Release/net10.0/freebsd-x64/publish/* bin/publish/FreeBSD/bin/loader/
cp ../OpenLoader-main/SS14.Launcher/signing_key bin/publish/FreeBSD/bin/

echo "Creating FreeBSD archive..."
cd bin/publish/FreeBSD
zip -r ../../../OpenLoader_FreeBSD.tar.gz *
cd ../..

echo "FreeBSD build complete!"
echo "Archive created: OpenLoader_FreeBSD.tar.gz"
echo "Location: $(pwd)/OpenLoader_FreeBSD.tar.gz"
