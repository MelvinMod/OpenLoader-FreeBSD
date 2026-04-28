#!/bin/bash

set -e

echo "=========================================="
echo "OpenLoader FreeBSD Build Script"
echo "=========================================="

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")/OpenLoader-main"

cd "$PROJECT_DIR"

echo "Project directory: $PROJECT_DIR"
echo ""

if [ ! -d "$PROJECT_DIR" ]; then
    echo "Error: Project directory not found!"
    exit 1
fi

if [ ! -f "$PROJECT_DIR/SS14.Launcher/SS14.Launcher.csproj" ]; then
    echo "Error: SS14.Launcher.csproj not found!"
    exit 1
fi

cd "$PROJECT_DIR"

if [ -f ".gitmodules" ]; then
    echo "Initializing git submodules..."
    git submodule update --init --recursive 2>/dev/null || true
fi

if ! command -v dotnet &> /dev/null; then
    echo "Error: .NET SDK not found!"
    echo "Install it with: pkg install dotnet-sdk80"
    exit 1
fi

echo ".NET SDK version:"
dotnet --version
echo ""

if ! command -v tar &> /dev/null; then
    echo "Error: tar utility not found!"
    echo "Install it with: pkg install tar"
    exit 1
fi

echo "Cleaning previous builds..."
rm -rf **/bin **/obj bin/publish/FreeBSD 2>/dev/null || true
rm -f SS14.Launcher_FreeBSD.tar.* 2>/dev/null || true

echo "Restoring NuGet packages..."
dotnet restore OpenLoader.slnx

echo "Building SS14.Launcher for FreeBSD..."
dotnet publish SS14.Launcher/SS14.Launcher.csproj \
    /p:FullRelease=True \
    -c Release \
    --no-self-contained \
    -r linux-x64 \
    /nologo \
    /p:RobustILLink=true

echo "Building SS14.Loader for FreeBSD..."
dotnet publish SS14.Loader/SS14.Loader.csproj \
    -c Release \
    --no-self-contained \
    -r linux-x64 \
    /nologo

echo "Creating output directory structure..."
mkdir -p bin/publish/FreeBSD/bin
mkdir -p bin/publish/FreeBSD/bin/loader
mkdir -p bin/publish/FreeBSD/Marsey/Mods
mkdir -p bin/publish/FreeBSD/Marsey/ResourcePacks
mkdir -p bin/publish/FreeBSD/dotnet

echo "Copying built files..."
if [ -f "PublishFiles/SS14.Launcher" ]; then
    cp PublishFiles/SS14.Launcher bin/publish/FreeBSD/
else
    echo "Warning: PublishFiles/SS14.Launcher not found, creating launcher script"
    cat > bin/publish/FreeBSD/SS14.Launcher << 'EOF'
#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
export XDG_CURRENT_DESKTOP="KDE"
export QT_QPA_PLATFORM="xcb"
export DOTNET_ROOT="$SCRIPT_DIR/dotnet"
export PATH="$DOTNET_ROOT:$PATH"
exec "$DOTNET_ROOT/dotnet" "$SCRIPT_DIR/bin/SS14.Launcher.dll" "$@"
EOF
    chmod +x bin/publish/FreeBSD/SS14.Launcher
fi

cp SS14.Launcher/bin/Release/net10.0/linux-x64/publish/* bin/publish/FreeBSD/bin/
cp SS14.Loader/bin/Release/net10.0/linux-x64/publish/* bin/publish/FreeBSD/bin/loader/

if [ -f "SS14.Launcher/signing_key" ]; then
    cp SS14.Launcher/signing_key bin/publish/FreeBSD/bin/
else
    echo "Warning: signing_key not found"
fi

echo "Copying dotnet runtime from folder 1..."
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
if [ -d "$SCRIPT_DIR/1/dotnet" ]; then
    cp -r "$SCRIPT_DIR/1/dotnet/"* bin/publish/FreeBSD/dotnet/
    echo "Dotnet runtime copied successfully"
else
    echo "Warning: 1/dotnet folder not found at $SCRIPT_DIR/1/dotnet"
    echo "The launcher may require system-wide dotnet installation"
fi

echo "Creating FreeBSD archives..."
cd bin/publish/FreeBSD
tar -czvf ../../../SS14.Launcher_FreeBSD.tar.gz .
tar --zstd -cvf ../../../SS14.Launcher_FreeBSD.tar.zst .
cd ../../..

rm -rf bin/publish/FreeBSD

echo ""
echo "=========================================="
echo "Build Complete!"
echo "=========================================="
echo "Output:"
echo "  $(pwd)/SS14.Launcher_FreeBSD.tar.gz"
echo "  $(pwd)/SS14.Launcher_FreeBSD.tar.zst"
echo ""
echo "To install:"
echo "  tar -xzf SS14.Launcher_FreeBSD.tar.gz -C /opt/openloader"
echo "  /opt/openloader/bin/SS14.Launcher"
echo ""
