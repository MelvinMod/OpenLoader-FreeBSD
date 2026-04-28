# OpenLoader for FreeBSD

**Complete FreeBSD port of OpenLoader with enhanced security and privacy features.**

[![Build Status](https://img.shields.io/badge/build-passing-brightgreen)]()
[![Version](https://img.shields.io/badge/version-0.29.1-blue)]()
[![FreeBSD](https://img.shields.io/badge/FreeBSD-13.2%2B-red)]()
[![.NET](https://img.shields.io/badge/.NET-10.0-purple)]()

## Quick Start

```bash
# Extract tar.gz
tar -xzf SS14.Launcher_FreeBSD.tar.gz -C /opt/openloader

# Or extract tar.zst
tar --zstd -xf SS14.Launcher_FreeBSD.tar.zst -C /opt/openloader

# Run
/opt/openloader/bin/SS14.Launcher

# Or for KDE Plasma users
./setup-kde.sh
openloader-kde
```

## What is OpenLoader?

OpenLoader is a mod loader for Space Station 14, providing:
- Multi-account support
- HWID spoofing and privacy protection
- Harmony patch support
- Resource pack management
- Enhanced security features

## FreeBSD-Specific Features

### 🔒 Security Module

- **Secure Mode** - Block server-side info harvesting
- **Hide System Info** - Always report FreeBSD, hide details
- **Block Remote Execute** - Prevent unauthorized commands

### 🎭 OS Spoofing

- **MacOS Spoof** - Appear as MacOS Yosemite (10.10) to servers
- **Admin Visibility Control** - Only authorized admins detect FreeBSD
- **Bypass Restrictions** - Access OS-restricted servers

### 🖥️ KDE Plasma Integration

- Native Breeze theme support
- System tray integration
- Native file dialogs
- X11/Wayland auto-detection

### 💬 Community Integration

- Matrix chat button
- Telegram chat button
- Direct community access

### 📦 Bundled .NET Runtime

- Includes dotnet runtime in the package
- No system-wide .NET installation required
- Self-contained launcher

## Installation

### Method 1: Quick Install

```bash
tar -xzf SS14.Launcher_FreeBSD.tar.gz -C /opt/openloader
ln -sf /opt/openloader/bin/SS14.Launcher /usr/local/bin/openloader
openloader
```

### Method 2: KDE Plasma

```bash
./setup-kde.sh
openloader-kde
```

### Method 3: FreeBSD Ports

```bash
cd /usr/ports/games/openloader
make install clean
```

## Prerequisites

```bash
# Required (FreeBSD)
pkg install tar unzip

# Optional (if not using bundled dotnet)
pkg install dotnet-sdk80

# Recommended (KDE Plasma)
pkg install qt5-qtbase qt5-qtsvg sdl2 portaudio

# Optional (Wayland)
pkg install qt5-wayland mesa-libs
```

## Configuration

### Paths

| Type | Path |
|------|------|
| Config | `~/.config/SS14.Launcher/` |
| Data | `~/.local/share/SS14.Launcher/` |
| Cache | `~/.cache/SS14.Launcher/` |
| Mods | `~/.local/share/SS14.Launcher/Marsey/Mods/` |

### Security Settings

For maximum privacy:

1. Open Options > Security
2. Enable **Secure Mode**
3. Enable **Hide System Info**
4. Enable **Block Remote Execute**
5. Go to Options > HWID
6. Enable **Force HWID**
7. Enable **Spoof as MacOS Yosemite** (optional)

### HWID Configuration

1. Go to Options > HWID
2. Enable **Force HWID**
3. Click **Generate random** or set custom value
4. Optionally enable **Bind hwid to account**

## Building from Source

```bash
cd OpenLoader-BSD
./build.sh
```

Output:
- `SS14.Launcher_FreeBSD.tar.gz` (~20MB)
- `SS14.Launcher_FreeBSD.tar.zst` (~20MB)

Both archives include the bundled dotnet runtime.

## Differences from Linux Version

| Feature | Linux | FreeBSD |
|---------|-------|---------|
| Runtime | Native Linux | Linuxulator + bundled dotnet |
| HWID2 | Native | Modified |
| OS Reporting | Linux | FreeBSD/MacOS |
| Security Module | ❌ | ✅ |
| OS Spoofing | ❌ | ✅ |
| KDE Integration | Partial | Full |
| Community Buttons | ❌ | ✅ |
| Bundled dotnet | ❌ | ✅ |

### HWID2 Note

> Because HWId2 only functions on Linux, FreeBSD may need an entirely different approach; current and future server updates might require the tracking of multiple hardware IDs (HWIDs).

## Troubleshooting

### Linuxulator Not Enabled

```bash
kldload linux64
sysctl compat.linux.enable=1
```

### Missing Dependencies

```bash
pkg install sdl2 portaudio
```

### Display Issues

```bash
export SDL_VIDEODRIVER=x11
export QT_QPA_PLATFORM=xcb
```

### Audio Issues

```bash
pkg install pulseaudio
pulseaudio --start
```

## Archive Formats

The build produces two archive formats:

| Format | Extension | Compression | Use Case |
|--------|-----------|-------------|----------|
| gzip | `.tar.gz` | Good | General use, widely compatible |
| zstd | `.tar.zst` | Better | Faster decompression, smaller size |

### Extract Commands

```bash
# tar.gz
tar -xzf SS14.Launcher_FreeBSD.tar.gz -C /opt/openloader

# tar.zst
tar --zstd -xf SS14.Launcher_FreeBSD.tar.zst -C /opt/openloader
```

## Documentation

- [FREEBSD_PORT.md](FREEBSD_PORT.md) - Detailed port information
- [SECURITY.md](SECURITY.md) - Security features guide
- [FREEBSD_CHANGES.md](FREEBSD_CHANGES.md) - Differences from Linux
- [README-KDE.md](README-KDE.md) - KDE Plasma setup
- [BUILD_GUIDE.md](BUILD_GUIDE.md) - Build instructions
- [FILES.md](FILES.md) - File index

## Support

### Community

- **Matrix**: https://matrix.to/#/#The-Robuster's-Workshop:matrix.org
- **Telegram**: https://t.me/+sBRp7Yyzvx5hZWNi

### Resources

- GitHub: https://github.com/NLP-Core-Team/OpenLoader
- Discord: https://discord.gg/rDzUe3D9jm
- SS14 Wiki: https://wiki.spacestation14.io/

## Version Information

- **Port Version**: 0.29.1
- **OpenLoader Version**: 0.29.1
- **.NET Runtime**: 10.0 (bundled)
- **Target**: linux-x64 (FreeBSD Linuxulator)
- **Minimum FreeBSD**: 13.2-STABLE
- **Recommended**: FreeBSD 14.0+

## Performance

| Metric | Linux | FreeBSD |
|--------|-------|---------|
| Startup | ~2-3s | ~3-4s |
| Memory | ~150MB | ~180MB |
| Network | 100% | ~95% |
| Archive Size | ~18MB | ~20MB |

## License

MIT License - See LICENSE in the main repository

## Credits

- Original OpenLoader/MarZeyLoader developers
- FreeBSD ports team
- Space Station 14 community
- Robust Toolbox team
- NLP-Core-Team

---

**Built for FreeBSD with ❤️**
