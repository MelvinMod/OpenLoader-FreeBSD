# Security Features - FreeBSD Port

## Overview

The FreeBSD port of OpenLoader includes enhanced security features designed to protect users from unauthorized data collection, admin abuse, and server-side exploits.

## Security Features

### Secure Mode

**Purpose**: Block server-side info harvesting attempts

**What it does**:
- Prevents servers from collecting detailed system information
- Blocks unauthorized data collection scripts
- Protects personal hardware information
- Masks system fingerprints

**Enable**: Check "Secure Mode" in Options > Security

### Hide System Info

**Purpose**: Hide detailed system information from servers

**What it does**:
- Always reports FreeBSD as the operating system
- Hides kernel version and patch level
- Masks hardware details
- Prevents system fingerprinting

**Enable**: Check "Hide System Info" in Options > Security

### Block Remote Execute

**Purpose**: Block remote execute commands from servers

**What it does**:
- Prevents servers from executing commands on your system
- Blocks unauthorized RemoteExecuteCommand usage
- Protects against admin abuse
- Prevents potential RCE exploits

**Enable**: Check "Block Remote Execute" in Options > Security

## OS Spoofing

### MacOS Spoofing

**Purpose**: Make your FreeBSD system appear as MacOS to servers

**What it does**:
- Reports OS as MacOS Yosemite (10.10)
- Bypasses OS-based restrictions
- Hides FreeBSD usage from servers
- Only authorized admins can detect FreeBSD

**Enable**: 
1. Go to Options > HWID
2. Enable "Force HWID"
3. Check "Spoof as MacOS Yosemite"

### Why MacOS Yosemite?

- Common enough to not raise suspicion
- Old enough to explain missing features
- Stable version with long support history
- Less likely to be blocked by servers

## Admin Visibility

### What Admins Can See

**Default (no spoofing)**:
- Operating System: FreeBSD
- Basic system info (if not hidden)

**With MacOS Spoof**:
- Operating System: MacOS Yosemite (10.10)
- No FreeBSD indicators visible

**With Hide System Info**:
- Operating System: FreeBSD
- Minimal system details
- No hardware information

### Authorized Admin Detection

Only admins with proper authorization can detect:
- Actual OS (FreeBSD vs spoofed)
- Hidden system information
- HWID spoofing status

## HWID Protection

### HWID Spoofing

**Purpose**: Change your hardware ID to protect privacy

**Features**:
- Generate random HWID
- Set custom HWID (hexadecimal)
- Bind HWID to account
- Opt-out of HWID2 sending

**Enable**:
1. Go to Options > HWID
2. Enable "Force HWID"
3. Click "Generate random" or set custom value

### HWID2 Opt-Out

**Purpose**: Prevent sending HWID to servers

**Note**: Because HWID2 only functions on Linux, FreeBSD may need an entirely different approach; current and future server updates might require the tracking of multiple hardware IDs (HWIDs).

**Enable**: Check "Explicitly disallow HWID" in Options

## Best Practices

### Maximum Privacy

For maximum privacy protection:

1. Enable Secure Mode
2. Enable Hide System Info
3. Enable Block Remote Execute
4. Enable Force HWID with random HWID
5. Enable MacOS Spoof (optional)
6. Opt-out of HWID2

### Balanced Approach

For normal use with good protection:

1. Enable Secure Mode
2. Enable Force HWID
3. Keep Hide System Info disabled (for compatibility)

### Server Compatibility

Some servers may require:
- Visible system information
- Specific HWID format
- No OS spoofing

Check server rules before enabling all security features.

## Technical Details

### Implementation

Security features are implemented through:

- Harmony patches for system calls
- Network traffic filtering
- OS detection interception
- HWID generation/modification

### Logging

All security actions are logged to:
- `~/.local/share/SS14.Launcher/logs/`
- Console output (if enabled)

### Performance Impact

Security features have minimal performance impact:
- Secure Mode: <1% overhead
- Hide System Info: No impact
- Block Remote Exec: No impact
- HWID Spoofing: One-time on join

## Known Limitations

### FreeBSD-Specific

- HWID2 works differently than on Linux
- Some Linux-specific protections not applicable
- Linuxulator may affect detection methods

### Server-Side

- Some servers may block spoofed systems
- Admin tools may detect inconsistencies
- Future updates may change detection methods

## Updates

Security features are regularly updated to:
- Counter new detection methods
- Fix potential vulnerabilities
- Improve compatibility
- Add new protection options

## Reporting Issues

If you find security vulnerabilities:

1. **Do not** disclose publicly
2. Contact via Matrix or Telegram
3. Provide detailed reproduction steps
4. Allow time for fix before disclosure

## Contact

- **Matrix**: https://matrix.to/#/#The-Robuster's-Workshop:matrix.org
- **Telegram**: https://t.me/+sBRp7Yyzvx5hZWNi

## Disclaimer

These security features are provided for privacy protection. Use responsibly and in accordance with server rules and applicable laws.
