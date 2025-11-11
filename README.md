# Discord RPC macOS Auto-Start

This script helps run Discord Rich Presence on macOS automatically.  
It sets permissions, fixes line endings, and configures auto-start.

## Quick Setup

1. Download the Discord RPC extension for your browser:  
[Chrome](https://chrome.google.com/webstore/detail/discord-rich-presence/agnaejlkbiiggajjmnpmeheigkflbnoo)  
[Firefox](https://addons.mozilla.org/firefox/addon/discord-rich-presence/)

2. Download the original Discord RPC files from the official release:  
[GitHub Release 0.3.0](https://github.com/lolamtisch/Discord-RPC-Extension/releases/tag/0.3.0)  

  The folder should contain:  
  - `start.sh`  
  - `server_macos_debug`

3. Download `setup.sh` from this fork and place it in the same folder as the original files.

4. Open Terminal in that folder and run:

```bash
./setup.sh
```

The server will now run automatically every time you log in.

## Verify

```bash
ps aux | grep server_macos_debug
```

If you see a process for `server_macos_debug`, it’s running.
