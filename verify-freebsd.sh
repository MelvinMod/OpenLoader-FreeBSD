#!/bin/bash

echo "=========================================="
echo "OpenLoader FreeBSD Verification Script"
echo "=========================================="
echo ""

ERRORS=0

# Check FreeBSD version
echo "1. Checking FreeBSD version..."
if [ -f /etc/os-release ]; then
    FREEBSD_VERSION=$(grep -oP 'VERSION_ID=\K[^"]+' /etc/os-release 2>/dev/null || true)
    if [ -n "$FREEBSD_VERSION" ]; then
        echo "   FreeBSD version: $FREEBSD_VERSION"
        if [ "$(echo $FREEBSD_VERSION | cut -d. -f1)" -lt 13 ]; then
            echo "   WARNING: FreeBSD 13.2 or later recommended"
            ((ERRORS++))
        fi
    else
        echo "   WARNING: Could not determine FreeBSD version"
        ((ERRORS++))
    fi
else
    echo "   ERROR: Not running on FreeBSD or /etc/os-release missing"
    ((ERRORS++))
fi
echo ""

# Check architecture
echo "2. Checking system architecture..."
ARCH=$(uname -m)
echo "   Architecture: $ARCH"
if [ "$ARCH" != "x86_64" ]; then
    echo "   WARNING: x86_64 architecture recommended"
    ((ERRORS++))
fi
echo ""

# Check .NET SDK
echo "3. Checking .NET SDK..."
if command -v dotnet &> /dev/null; then
    DOTNET_VERSION=$(dotnet --version 2>/dev/null | head -n1)
    echo "   .NET SDK version: $DOTNET_VERSION"
    MAJOR_VERSION=$(echo $DOTNET_VERSION | cut -d. -f1)
    if [ "$MAJOR_VERSION" -lt 8 ]; then
        echo "   ERROR: .NET SDK 8.0 or later required"
        ((ERRORS++))
    else
        echo "   OK: .NET SDK version is compatible"
    fi
else
    echo "   ERROR: .NET SDK not installed"
    echo "   Install with: pkg install dotnet-sdk80"
    ((ERRORS++))
fi
echo ""

# Check zip utility
echo "4. Checking zip utility..."
if command -v zip &> /dev/null; then
    echo "   zip: installed"
else
    echo "   WARNING: zip not found"
    echo "   Install with: pkg install zip"
    ((ERRORS++))
fi
echo ""

# Check unzip utility
echo "5. Checking unzip utility..."
if command -v unzip &> /dev/null; then
    echo "   unzip: installed"
else
    echo "   WARNING: unzip not found"
    echo "   Install with: pkg install unzip"
    ((ERRORS++))
fi
echo ""

# Check SDL2
echo "6. Checking SDL2..."
if pkg info sdl2 &> /dev/null; then
    echo "   SDL2: installed"
else
    echo "   WARNING: SDL2 not installed"
    echo "   Install with: pkg install sdl2"
    ((ERRORS++))
fi
echo ""

# Check display server
echo "7. Checking display server..."
if [ -n "$DISPLAY" ] || [ -n "$WAYLAND_DISPLAY" ]; then
    if [ -n "$DISPLAY" ]; then
        echo "   X11: DISPLAY=$DISPLAY"
    fi
    if [ -n "$WAYLAND_DISPLAY" ]; then
        echo "   Wayland: $WAYLAND_DISPLAY"
    fi
else
    echo "   WARNING: No display server detected"
    echo "   Make sure X11 or Wayland is running"
    ((ERRORS++))
fi
echo ""

# Check X11 libraries
echo "8. Checking X11 libraries..."
if pkg info xorg &> /dev/null; then
    echo "   Xorg: installed"
else
    echo "   WARNING: Xorg not fully installed"
    echo "   Install with: pkg install xorg"
    ((ERRORS++))
fi
echo ""

# Check audio
echo "9. Checking audio system..."
if pkg info portaudio &> /dev/null; then
    echo "   PortAudio: installed"
else
    echo "   INFO: PortAudio not installed (optional)"
    echo "   Install with: pkg install portaudio"
fi
echo ""

# Check build tools
echo "10. Checking build tools..."
if command -v gmake &> /dev/null; then
    echo "   gmake: installed"
else
    echo "   INFO: gmake not found (optional for basic build)"
fi

if command -v gcc &> /dev/null; then
    echo "   gcc: installed"
else
    echo "   WARNING: gcc not found"
    echo "   Install with: pkg install gcc"
    ((ERRORS++))
fi
echo ""

# Check git
echo "11. Checking git..."
if command -v git &> /dev/null; then
    echo "   git: installed"
else
    echo "   WARNING: git not found"
    echo "   Install with: pkg install git"
    ((ERRORS++))
fi
echo ""

# Check disk space
echo "12. Checking disk space..."
AVAILABLE_SPACE=$(df -h . | awk 'NR==2 {print $4}')
echo "   Available space: $AVAILABLE_SPACE"
echo ""

# Summary
echo "=========================================="
echo "Verification Summary"
echo "=========================================="
if [ $ERRORS -eq 0 ]; then
    echo "All checks passed! Your system is ready to build OpenLoader."
    echo ""
    echo "Next steps:"
    echo "  ./build.sh"
    exit 0
else
    echo "Found $ERRORS issue(s). Please address the errors above before building."
    echo ""
    echo "After fixing issues, run this script again to verify."
    exit 1
fi
