# OpenLoader for FreeBSD with KDE Plasma

This guide covers installing and running OpenLoader on FreeBSD with KDE Plasma desktop environment.

## Quick Install for KDE Plasma

```bash
cd OpenLoader-BSD
chmod +x setup-kde.sh
sudo ./setup-kde.sh
```

Then launch with:
```bash
openloader-kde
```

## Prerequisites

Install required packages:

```bash
pkg install dotnet-sdk80 unzip zip
pkg install sdl2 portaudio
pkg install qt5-qtbase qt5-qtsvg
pkg install xorg-fonts
```

For Wayland support:
```bash
pkg install qt5-wayland
```

## KDE Plasma Integration

### Features

- Breeze theme support
- Native file dialogs
- System tray icon
- X11 and Wayland auto-detection
- KDE session integration

### Launch Options

**Standard Launch:**
```bash
SS14.Launcher
```

**KDE-Optimized Launch:**
```bash
openloader-kde
```

**Wayland Launch:**
```bash
env QT_QPA_PLATFORM=wayland SDL_VIDEODRIVER=wayland SS14.Launcher
```

### Desktop Entry

After installation, OpenLoader will appear in:
- Application Launcher > Games > Space Station 14 Launcher
- KRunner (Alt+Space): Type "Space Station 14"

## Configuration

### KDE-Specific Settings

Create `~/.config/SS14.Launcher/openloader.conf`:

```ini
DesktopEnvironment = KDE
QT_STYLE_OVERRIDE = Breeze
QT_QPA_PLATFORM = xcb
KDEIntegration = true
UseNativeFileDialogs = true
EnableSystemTray = true
```

### Environment Variables

Add to `~/.profile` or `~/.bashrc`:

```bash
export XDG_CURRENT_DESKTOP="KDE"
export QT_STYLE_OVERRIDE="Breeze"
export KDE_SESSION_VERSION="6"
```

## Troubleshooting KDE Issues

### Theme Issues

If the application doesn't match KDE theme:

```bash
export QT_QPA_PLATFORMTHEME=kde5
SS14.Launcher
```

### Scaling Issues

For HiDPI displays:

```bash
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_SCALE_FACTOR=1.5
SS14.Launcher
```

### System Tray Not Showing

Install libappindicator:

```bash
pkg install libappindicator
```

### Audio Issues on KDE

Ensure PulseAudio or PipeWire is running:

```bash
pkg install pulseaudio
pulseaudio --start
```

## Manual Installation

```bash
# Extract
unzip SS14.Launcher_FreeBSD.tar.gz -d /opt/openloader

# Create KDE wrapper
cat > /usr/local/bin/openloader-kde << 'EOF'
#!/bin/sh
export XDG_CURRENT_DESKTOP="KDE"
export QT_QPA_PLATFORM="xcb"
export QT_STYLE_OVERRIDE="Breeze"
exec /opt/openloader/bin/SS14.Launcher "$@"
EOF
chmod +x /usr/local/bin/openloader-kde

# Install desktop file
cp /opt/openloader/ss14-launcher.desktop /usr/local/share/applications/
```

## Uninstallation

```bash
rm -rf /usr/local/lib/openloader
rm /usr/local/bin/SS14.Launcher
rm /usr/local/bin/openloader-kde
rm /usr/local/share/applications/ss14-launcher.desktop
```

## Performance Tips for KDE

1. **Disable compositor for fullscreen:**
   - System Settings > Display and Monitor > Compositor
   - Check "Allow applications to block compositing"

2. **Enable hardware acceleration:**
   ```ini
   EnableHardwareAcceleration = true
   ```

3. **Limit download threads on slow connections:**
   ```ini
   MaxDownloadThreads = 2
   ```

## Known KDE-Specific Issues

- Global menu may not work (Avalonia limitation)
- Some keyboard shortcuts may conflict with KDE shortcuts
- System tray icon may require Status Notifier support

## Support

For KDE-specific issues:
- KDE Forums: https://forum.kde.org/
- FreeBSD KDE Team: https://wiki.freebsd.org/KDE
- OpenLoader Discord: https://discord.gg/rDzUe3D9jm
