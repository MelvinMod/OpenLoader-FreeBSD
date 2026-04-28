# OpenLoader FreeBSD Archives

## Archive Formats

The FreeBSD port is distributed in two archive formats:

### 1. tar.gz (gzip compressed)

**File**: `SS14.Launcher_FreeBSD.tar.gz`
**Size**: ~20MB
**Compression**: gzip
**Compatibility**: Universal

**Extract**:
```bash
tar -xzf SS14.Launcher_FreeBSD.tar.gz -C /opt/openloader
```

**Use when**:
- Maximum compatibility needed
- Older systems without zstd support
- Standard Unix environments

### 2. tar.zst (zstd compressed)

**File**: `SS14.Launcher_FreeBSD.tar.zst`
**Size**: ~20MB
**Compression**: zstd (Zstandard)
**Compatibility**: Modern systems

**Extract**:
```bash
tar --zstd -xf SS14.Launcher_FreeBSD.tar.zst -C /opt/openloader
```

**Use when**:
- Faster decompression desired
- Modern FreeBSD system (12+)
- Better compression ratio needed

## Archive Contents

Both archives contain identical files:

```
SS14.Launcher_FreeBSD.tar.*
├── bin/
│   ├── SS14.Launcher          # Main launcher script
│   ├── SS14.Launcher.dll      # Launcher assembly
│   ├── signing_key            # Code signing key
│   └── *.dll, *.so            # Dependencies
├── bin/loader/
│   ├── SS14.Loader            # Game loader
│   ├── SS14.Loader.dll        # Loader assembly
│   └── *.dll, *.so            # Loader dependencies
├── dotnet/
│   ├── dotnet                 # .NET runtime executable
│   ├── host/                  # Host framework
│   ├── shared/                # Shared frameworks
│   ├── LICENSE.txt            # .NET license
│   └── ThirdPartyNotices.txt  # Third party notices
├── Marsey/
│   ├── Mods/                  # Mods directory (empty)
│   └── ResourcePacks/         # Resource packs directory (empty)
└── SS14.Launcher              # Root launcher script
```

## Bundled .NET Runtime

The FreeBSD port includes a bundled .NET runtime in the `dotnet/` directory.

### Why Bundled?

- **No system dependencies** - Works without installing dotnet-sdk
- **Consistent version** - Always uses tested .NET 10.0
- **Portable** - Can run from any location
- **Isolated** - Doesn't conflict with system .NET

### Runtime Details

- **Version**: .NET 10.0
- **RID**: linux-x64
- **Location**: `dotnet/` subdirectory
- **Size**: ~70MB (included in archive)

### Using Bundled Runtime

The launcher script automatically uses the bundled runtime:

```bash
#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
export DOTNET_ROOT="$SCRIPT_DIR/dotnet"
export PATH="$DOTNET_ROOT:$PATH"
exec "$DOTNET_ROOT/dotnet" "$SCRIPT_DIR/bin/SS14.Launcher.dll" "$@"
```

### Using System Runtime (Alternative)

If you prefer to use system-wide .NET:

```bash
pkg install dotnet-sdk80
export DOTNET_ROOT=/usr/local/share/dotnet
/opt/openloader/bin/SS14.Launcher
```

## Installation Methods

### Method 1: Extract to /opt

```bash
sudo tar -xzf SS14.Launcher_FreeBSD.tar.gz -C /opt
ln -sf /opt/bin/SS14.Launcher /usr/local/bin/openloader
openloader
```

### Method 2: Extract to /usr/local

```bash
sudo tar -xzf SS14.Launcher_FreeBSD.tar.gz -C /usr/local
openloader
```

### Method 3: User Directory

```bash
tar -xzf SS14.Launcher_FreeBSD.tar.gz -C ~/.local/opt
~/.local/opt/bin/SS14.Launcher
```

## Verification

### Check Archive Integrity

```bash
# Verify tar.gz
tar -tzf SS14.Launcher_FreeBSD.tar.gz | head -20

# Verify tar.zst
tar --zstd -tf SS14.Launcher_FreeBSD.tar.zst | head -20
```

### Check Contents

```bash
tar -tzf SS14.Launcher_FreeBSD.tar.gz | grep -E "^(bin/|dotnet/|Marsey/)"
```

### Verify dotnet Runtime

After extraction:

```bash
/opt/openloader/dotnet/dotnet --version
# Should output: 10.0.x
```

## Compression Comparison

| Format | Compressed Size | Decompression Speed | Compatibility |
|--------|----------------|---------------------|---------------|
| tar.gz | ~20MB | Standard | Universal |
| tar.zst | ~20MB | Faster | Modern systems |

## File Permissions

After extraction, ensure proper permissions:

```bash
chmod +x /opt/openloader/bin/SS14.Launcher
chmod +x /opt/openloader/dotnet/dotnet
```

## Cleanup

### Remove Archive After Installation

```bash
rm SS14.Launcher_FreeBSD.tar.gz
rm SS14.Launcher_FreeBSD.tar.zst
```

### Remove Old Versions

```bash
rm -rf /opt/openloader
rm /usr/local/bin/openloader
```

## Building Your Own Archive

To create custom archives:

```bash
cd OpenLoader-BSD
./build.sh
```

This produces both `tar.gz` and `tar.zst` formats.

## Support

For archive-related issues:

- **Matrix**: https://matrix.to/#/#The-Robuster's-Workshop:matrix.org
- **Telegram**: https://t.me/+sBRp7Yyzvx5hZWNi

## License

MIT License - See LICENSE in the main repository

---

**Both archive formats contain identical content - choose based on your preference!**
