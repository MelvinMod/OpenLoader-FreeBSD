# OpenLoader FreeBSD Port

## Overview

This is the official FreeBSD port of OpenLoader, a mod loader for Space Station 14. This port provides native FreeBSD compatibility while maintaining feature parity with the Linux version.

## Key Differences from Linux Version

### Runtime Target

- **Linux Version**: Uses `linux-x64` runtime with native Linux libraries
- **FreeBSD Version**: Uses `linux-x64` runtime via FreeBSD's Linux compatibility layer (Linuxulator)

### Operating System Detection

- **Linux Version**: Reports as Linux to servers
- **FreeBSD Version**: Can report as FreeBSD or spoof as MacOS Yosemite (10.10) when enabled

### HWID Implementation

- **Linux Version**: HWID2 works with Linux-specific system calls
- **FreeBSD Version**: Uses alternative FreeBSD-compatible methods; HWID2 functionality differs due to kernel differences

### System Integration

- **Linux Version**: Uses XDG standards, PulseAudio, X11/Wayland natively
- **FreeBSD Version**: Uses XDG standards with FreeBSD paths, PulseAudio/OSS, X11/Wayland via compatibility

### Security Features

- **Linux Version**: Standard security model
- **FreeBSD Version**: Enhanced security options including:
  - Secure Mode (blocks info harvesting)
  - Hide System Info (always reports FreeBSD)
  - Block Remote Execute (prevents unauthorized commands)

## FreeBSD-Specific Features

### OS Spoofing

The FreeBSD port includes enhanced OS spoofing capabilities:

- **MacOS Spoof**: Makes your system appear as MacOS Yosemite (10.10) to servers
- **FreeBSD Detection**: Servers can be configured to always see FreeBSD
- **Admin Visibility**: Only authorized admins can detect FreeBSD usage

### Security Enhancements

```
Secure Mode          - Blocks server-side info harvesting
Hide System Info     - Hides detailed system information
Block Remote Exec    - Prevents remote command execution
```

### KDE Plasma Integration

The FreeBSD port includes native KDE Plasma support:

- Breeze theme integration
- Native file dialogs
- System tray support
- X11/Wayland auto-detection

## Installation

### Quick Install

```bash
unzip SS14.Launcher_FreeBSD.tar.gz -d /opt/openloader
/opt/openloader/bin/SS14.Launcher
```

### KDE Plasma Install

```bash
./setup-kde.sh
openloader-kde
```

## Configuration Paths

| Type | Linux Path | FreeBSD Path |
|------|-----------|--------------|
| Config | `~/.config/SS14.Launcher/` | `~/.config/SS14.Launcher/` |
| Data | `~/.local/share/SS14.Launcher/` | `~/.local/share/SS14.Launcher/` |
| Cache | `~/.cache/SS14.Launcher/` | `~/.cache/SS14.Launcher/` |
| Mods | `~/.local/share/SS14.Launcher/Marsey/Mods/` | `~/.local/share/SS14.Launcher/Marsey/Mods/` |

## Building from Source

### Prerequisites

```bash
# FreeBSD
pkg install dotnet-sdk80 git zip unzip

# Linux (for cross-compilation)
sudo apt install dotnet-sdk-8.0 git zip unzip
```

### Build Commands

```bash
cd OpenLoader-BSD
./build.sh
```

This produces `SS14.Launcher_FreeBSD.tar.gz` ready for deployment.

## Known Limitations

### HWID2 Compatibility

HWID2 on FreeBSD works differently than on Linux due to:

- Different kernel interfaces
- No direct access to Linux-specific hardware information
- FreeBSD's security model restrictions

### Linux Compatibility Layer

The FreeBSD port relies on FreeBSD's Linuxulator:

- Requires Linux compatibility to be enabled
- Some Linux-specific features may not work
- Performance may vary compared to native Linux

## Troubleshooting

### Common Issues

**Linuxulator not enabled:**
```bash
# Enable Linux compatibility
kldload linux64
sysctl compat.linux.enable=1
```

**Missing dependencies:**
```bash
pkg install dotnet-sdk80 sdl2 portaudio
```

**Display issues:**
```bash
export SDL_VIDEODRIVER=x11
export QT_QPA_PLATFORM=xcb
```

## Version Information

- **Port Version**: 0.29.1
- **Compatible OpenLoader**: 0.29.1
- **Runtime**: .NET 10.0
- **Target**: linux-x64 (FreeBSD Linuxulator)
- **Minimum FreeBSD**: 13.2-STABLE

## Support

- **Matrix Chat**: https://matrix.to/#/#The-Robuster's-Workshop:matrix.org
- **Telegram**: https://t.me/+sBRp7Yyzvx5hZWNi
- **GitHub**: https://github.com/NLP-Core-Team/OpenLoader

## License

MIT License - See LICENSE in the main repository

## Credits

- Original OpenLoader developers
- FreeBSD ports team
- Space Station 14 community
- Robust Toolbox team
