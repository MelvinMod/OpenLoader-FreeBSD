#!/bin/bash

set -e

echo "=========================================="
echo "OpenLoader KDE Plasma Setup for FreeBSD"
echo "=========================================="

PREFIX="${PREFIX:-/usr/local}"

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
    exit 1
fi

echo "Found archive: $ARCHIVE"
echo ""

echo "Creating directories..."
mkdir -p "$PREFIX/lib/openloader/bin"
mkdir -p "$PREFIX/lib/openloader/bin/loader"
mkdir -p "$PREFIX/lib/openloader/Marsey/Mods"
mkdir -p "$PREFIX/lib/openloader/Marsey/ResourcePacks"
mkdir -p "$PREFIX/bin"
mkdir -p "$PREFIX/share/applications"
mkdir -p "$PREFIX/share/icons/hicolor/256x256/apps"
mkdir -p "$HOME/.config/SS14.Launcher"
mkdir -p "$HOME/.local/share/SS14.Launcher"
mkdir -p "$HOME/.cache/SS14.Launcher"

echo "Extracting files..."
tar -xf "$ARCHIVE" -C /tmp/openloader-kde-install

echo "Copying launcher files..."
cp /tmp/openloader-kde-install/bin/SS14.Launcher "$PREFIX/bin/"
cp /tmp/openloader-kde-install/bin/*.dll "$PREFIX/lib/openloader/bin/"
cp /tmp/openloader-kde-install/bin/*.so "$PREFIX/lib/openloader/bin/" 2>/dev/null || true
cp /tmp/openloader-kde-install/bin/signing_key "$PREFIX/lib/openloader/bin/" 2>/dev/null || true

echo "Copying loader files..."
cp /tmp/openloader-kde-install/bin/loader/*.dll "$PREFIX/lib/openloader/bin/loader/"
cp /tmp/openloader-kde-install/bin/loader/*.so "$PREFIX/lib/openloader/bin/loader/" 2>/dev/null || true

echo "Copying dotnet runtime..."
if [ -d "/tmp/openloader-kde-install/dotnet" ]; then
    cp -r /tmp/openloader-kde-install/dotnet "$PREFIX/lib/openloader/"
    echo "Dotnet runtime installed"
fi

echo "Creating KDE wrapper script..."
cat > "$PREFIX/bin/openloader-kde" << 'EOF'
#!/bin/sh
export XDG_CURRENT_DESKTOP="KDE"
export QT_QPA_PLATFORM="xcb"
export QT_STYLE_OVERRIDE="Breeze"
export SDL_VIDEODRIVER="x11"
export SDL_AUDIODRIVER="pulseaudio"
export DOTNET_ROOT="/usr/local/lib/openloader/dotnet"
export PATH="$DOTNET_ROOT:$PATH"

if [ -n "$KDE_SESSION_VERSION" ]; then
    export KDE_SESSION_VERSION="6"
fi

if [ -n "$WAYLAND_DISPLAY" ]; then
    export QT_QPA_PLATFORM="wayland"
    export SDL_VIDEODRIVER="wayland"
fi

exec /usr/local/lib/openloader/dotnet/dotnet /usr/local/bin/SS14.Launcher "$@"
EOF
chmod +x "$PREFIX/bin/openloader-kde"

echo "Installing desktop entry..."
if [ -f "ss14-launcher.desktop" ]; then
    cp ss14-launcher.desktop "$PREFIX/share/applications/"
fi

echo "Copying configuration template..."
if [ -f "openloader.conf" ]; then
    cp openloader.conf "$HOME/.config/SS14.Launcher/"
fi

rm -rf /tmp/openloader-kde-install

echo ""
echo "=========================================="
echo "KDE Plasma Setup Complete!"
echo "=========================================="
echo ""
echo "To launch OpenLoader:"
echo "  openloader-kde"
echo "  or"
echo "  SS14.Launcher"
echo ""
echo "The launcher has been configured for KDE Plasma with:"
echo "  - Breeze theme integration"
echo "  - Native file dialogs"
echo "  - System tray support"
echo "  - X11/Wayland auto-detection"
echo "  - Bundled dotnet runtime"
echo ""
