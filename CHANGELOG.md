# Changelog - OpenLoader FreeBSD Port

## [0.29.1] - FreeBSD Port Initial Release

### Added
- FreeBSD port Makefile for official package building
- FreeBSD-specific build scripts (`build.sh`, `publish_freebsd.sh`)
- Runtime support for `freebsd-x64` RID
- Installation scripts for manual and automated deployment
- Desktop integration (`.desktop` file)
- Configuration template for FreeBSD
- Comprehensive build and verification scripts
- Documentation (README, BUILD_GUIDE)

### Changed
- Adapted paths for FreeBSD hierarchy (`/usr/local` prefix)
- Updated environment variables for FreeBSD X11/Wayland
- Modified SDL configuration for FreeBSD

### Technical Details
- Runtime: .NET 8.0 / .NET 10.0
- Target RID: `freebsd-x64`
- Framework: `net10.0`
- Dependencies: `dotnet-sdk80`, `sdl2`, `portaudio`

### Compatibility
- FreeBSD 13.2-STABLE+
- FreeBSD 14.0-RELEASE+
- Architecture: x86_64 (amd64)

### Known Issues
- HWId spoofing features primarily designed for Linux
- Some hardware acceleration may require additional configuration
- Audio output may need manual configuration for certain setups

## Future Plans

### Planned Features
- Native FreeBSD audio backend support
- Improved Wayland integration
- FreeBSD-specific performance optimizations
- Automated package repository integration

### Under Consideration
- FreeBSD 12.x support (EOL consideration)
- ARM64 architecture support
- pkgng package repository
