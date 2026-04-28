# FreeBSD Build Guide for OpenLoader

This guide explains how to build and install OpenLoader on FreeBSD.

## System Requirements

- **Operating System**: FreeBSD 13.2-STABLE or later (14.0+ recommended)
- **Architecture**: x86_64 (amd64)
- **Memory**: 4GB RAM minimum, 8GB recommended
- **Disk Space**: 2GB free space
- **Display**: X11 (works better with KDE Plasma) session, or Wayland (works weird on some Devices)

## Prerequisites Installation

### Method 1: Using pkg (Recommended)

```bash
# Update package database
pkg update

# Install .NET 8.0 SDK
pkg install dotnet-sdk80

# Install build tools
pkg install git zip unzip sdl2

# Install development dependencies
pkg install gmake gcc
```

### Method 2: From Ports

```bash
# Install .NET SDK from ports
cd /usr/ports/lang/dotnet-sdk80
make install clean

# Install other dependencies
cd /usr/ports/archivers/zip
make install clean

cd /usr/ports/devel/sdl2
make install clean
```

## Building OpenLoader

### Quick Build

```bash
cd OpenLoader-BSD
chmod +x build.sh
./build.sh
```

### Step-by-Step Build

1. **Clone the repository** (if not already done):
   ```bash
   git clone https://github.com/NLP-Core-Team/OpenLoader.git
   cd OpenLoader
   ```

2. **Restore dependencies**:
   ```bash
   dotnet restore
   ```

3. **Build Launcher**:
   ```bash
   dotnet publish SS14.Launcher/SS14.Launcher.csproj \
       /p:FullRelease=True \
       -c Release \
       --no-self-contained \
       -r freebsd-x64 \
       /nologo \
       /p:RobustILLink=true
   ```

4. **Build Loader**:
   ```bash
   dotnet publish SS14.Loader/SS14.Loader.csproj \
       -c Release \
       --no-self-contained \
       -r freebsd-x64 \
       /nologo
   ```

5. **Package**:
   ```bash
   mkdir -p bin/publish/FreeBSD/bin/loader
   cp SS14.Launcher/bin/Release/net10.0/freebsd-x64/publish/* bin/publish/FreeBSD/bin/
   cp SS14.Loader/bin/Release/net10.0/freebsd-x64/publish/* bin/publish/FreeBSD/bin/loader/
   cd bin/publish/FreeBSD && zip -r ../../../SS14.Launcher_FreeBSD.tar.gz * && cd ../..
   ```

## Installation

### Manual Installation

```bash
# Extract archive
unzip SS14.Launcher_FreeBSD.tar.gz -d /opt/openloader

# Create symlink
ln -sf /opt/openloader/bin/SS14.Launcher /usr/local/bin/openloader

# Run
openloader
```

### Port Installation (Advanced)

1. Copy port files to `/usr/ports/games/openloader/`
2. Run:
   ```bash
   cd /usr/ports/games/openloader
   make install clean
   ```

## Configuration

### Environment Variables

Set these in your shell profile (`~/.profile` or `~/.bashrc`):

```bash
export XDG_CONFIG_HOME=$HOME/.config/SS14.Launcher
export XDG_DATA_HOME=$HOME/.local/share/SS14.Launcher
export XDG_CACHE_HOME=$HOME/.cache/SS14.Launcher
export SDL_VIDEODRIVER=x11
export SDL_AUDIODRIVER=pa
```

### Custom Configuration

Create `~/.config/SS14.Launcher/openloader.conf`:

```ini
BaseDirectory = ~/.local/share/SS14.Launcher
DebugLogging = false
EnableHardwareAcceleration = true
```

## Troubleshooting

### Common Issues

#### .NET SDK Not Found

```bash
pkg install dotnet-sdk80
```

#### SDL2 Errors

```bash
pkg install sdl2
```

#### Missing Fonts

```bash
pkg install xorg-fonts
```

#### Audio Issues

```bash
pkg install portaudio
```

#### Permission Issues

Ensure you have execute permissions:
```bash
chmod +x /usr/local/bin/SS14.Launcher
```

### Debug Mode

Run with debug logging:
```bash
dotnet SS14.Launcher.dll --log-level debug
```

### Check Runtime

Verify .NET runtime:
```bash
dotnet --list-runtimes
```

Should show:
```
Microsoft.NETCore.App 8.0.x [/usr/local/share/dotnet/shared/Microsoft.NETCore.App]
```

## Performance Tuning

### Graphics Performance

For better graphics performance, ensure proper drivers are installed:

- **Intel**: `drm-kmod`
- **AMD**: `drm-kmod`
- **NVIDIA**: `nvidia-driver`

### Memory Optimization

Limit memory usage in configuration:
```ini
MaxDownloadThreads = 2
EnableHardwareAcceleration = true
```

## Upgrading

To upgrade to a newer version:

1. Build the new version
2. Stop any running instances
3. Replace files:
   ```bash
   cp -r bin/publish/FreeBSD/* /usr/local/lib/openloader/
   ```
4. Restart the launcher

## Uninstallation

```bash
# Remove binaries
rm -rf /usr/local/lib/openloader
rm /usr/local/bin/SS14.Launcher
rm /usr/local/bin/openloader

# Remove configuration (optional)
rm -rf ~/.config/SS14.Launcher
rm -rf ~/.local/share/SS14.Launcher
rm -rf ~/.cache/SS14.Launcher
```

## Contributing

For FreeBSD-specific issues:
1. Check existing GitHub issues
2. Create a new issue with:
   - FreeBSD version
   - .NET version
   - Error messages
   - Steps to reproduce

## Support Resources

- **Discord**: https://discord.gg/rDzUe3D9jm
- **GitHub**: https://github.com/NLP-Core-Team/OpenLoader
- **FreeBSD Forums**: https://forums.freebsd.org/

## Version History

- **0.29.1**: Initial FreeBSD port
  - Added freebsd-x64 runtime support
  - Created FreeBSD build scripts
  - Added port Makefile

## License

MIT License
