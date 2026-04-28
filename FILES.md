# OpenLoader FreeBSD Port - File Index

## Documentation Files

### Main Documentation
- **README.md** - Main documentation and quick start guide
- **README-KDE.md** - KDE Plasma specific setup and configuration
- **FREEBSD_PORT.md** - Detailed FreeBSD port information
- **FREEBSD_CHANGES.md** - Differences between Linux and FreeBSD versions
- **SECURITY.md** - Security features documentation
- **BUILD_GUIDE.md** - Comprehensive build instructions
- **BUILD_COMPLETE.md** - Build completion summary
- **CHANGELOG.md** - Version history and changes
- **FILES.md** - This file index

## Build Scripts

- **build.sh** - Main automated build script
- **build-port.sh** - FreeBSD ports build helper
- **publish_freebsd.sh** - Publishing script for releases
- **setup-kde.sh** - KDE Plasma installation script
- **install-freebsd.sh** - General installation script
- **verify-freebsd.sh** - System verification script

## Configuration Files

- **Makefile** - FreeBSD ports system makefile
- **Makefile.freebsd** - Manual build makefile
- **openloader.conf** - Configuration template
- **ss14-launcher** - Launcher wrapper script
- **ss14-launcher.desktop** - Desktop entry file

## Package Files

- **distinfo** - Package checksums
- **pkg-descr** - Package description
- **pkg-plist** - Package file list

## Build Artifacts

- **SS14.Launcher_FreeBSD.zip** - Built launcher archive (~20MB)
- **1/** - Temporary build directory (can be removed after build)

## File Purposes

### Documentation

| File | Purpose |
|------|---------|
| README.md | Quick start, features, installation |
| README-KDE.md | KDE Plasma integration guide |
| FREEBSD_PORT.md | Port technical details |
| FREEBSD_CHANGES.md | Linux vs FreeBSD comparison |
| SECURITY.md | Security features guide |
| BUILD_GUIDE.md | Step-by-step build instructions |
| BUILD_COMPLETE.md | Build status and next steps |
| CHANGELOG.md | Version history |
| FILES.md | File index (this file) |

### Scripts

| Script | Purpose |
|--------|---------|
| build.sh | Main build automation |
| build-port.sh | Ports tree building |
| publish_freebsd.sh | Release publishing |
| setup-kde.sh | KDE setup and install |
| install-freebsd.sh | General installation |
| verify-freebsd.sh | System compatibility check |

### Configuration

| File | Purpose |
|------|---------|
| Makefile | FreeBSD ports integration |
| Makefile.freebsd | Manual build system |
| openloader.conf | User configuration template |
| ss14-launcher | Wrapper script with env vars |
| ss14-launcher.desktop | Desktop menu entry |

## Installation Files

After installation, these files are placed:

```
/usr/local/bin/SS14.Launcher      # Main launcher
/usr/local/bin/openloader          # Symlink
/usr/local/bin/openloader-kde      # KDE wrapper
/usr/local/lib/openloader/         # Libraries and loader
/usr/local/share/applications/     # Desktop entries
```

## User Data Paths

```
~/.config/SS14.Launcher/           # Configuration
~/.local/share/SS14.Launcher/      # User data
~/.cache/SS14.Launcher/            # Cache
~/.local/share/SS14.Launcher/Marsey/Mods/      # Mods
~/.local/share/SS14.Launcher/Marsey/ResourcePacks/  # Resource packs
```

## Build Output

After running `./build.sh`:

```
SS14.Launcher_FreeBSD.zip          # Main archive (~20MB)
bin/publish/FreeBSD/               # Unpacked build
  bin/                             # Launcher binaries
  bin/loader/                      # Loader binaries
  Marsey/Mods/                     # Mods directory
  Marsey/ResourcePacks/            # Resource packs directory
```

## Cleanup

Safe to remove after build:
- `1/` - Temporary build directory
- `bin/` - If you have the ZIP archive
- `**/obj/` - Build intermediates
- `**/bin/` - Build outputs (if ZIP exists)

Keep:
- `SS14.Launcher_FreeBSD.zip` - Main distribution
- All `.md` files - Documentation
- All `.sh` scripts - Build/install tools
- Configuration files - For reference

## Version Information

- **Port Version**: 0.29.1
- **Build Date**: 2024-04-28
- **Archive Size**: ~20MB
- **Total Files**: 25+
- **Documentation**: 9 MD files
- **Scripts**: 6 shell scripts

## Support Files

For support and questions:
- Matrix: https://matrix.to/#/#The-Robuster's-Workshop:matrix.org
- Telegram: https://t.me/+sBRp7Yyzvx5hZWNi
- GitHub: https://github.com/NLP-Core-Team/OpenLoader

## License

MIT License - See LICENSE in main repository

---

**Complete FreeBSD Port Package**
