# Discord RPC macOS Auto-Start

This script helps run Discord Rich Presence on macOS automatically.  
It sets permissions and configures auto-start with a single command.

## Quick Setup

1. **Install the Discord RPC extension in your browser:**  
   - [Chrome](https://chrome.google.com/webstore/detail/discord-rich-presence/agnaejlkbiiggajjmnpmeheigkflbnoo)  
   - [Firefox](https://addons.mozilla.org/firefox/addon/discord-rich-presence/)

2. **Download the original Discord RPC files from the official release:**  
   - [GitHub Release 0.3.0](https://github.com/lolamtisch/Discord-RPC-Extension/releases/tag/0.3.0)  
   Extract the macOS zip - it contains:  
   - `server_macos_debug`
   - `start.sh` 

3. **Download `install.sh` from this fork** and place it in the **same folder** as the extracted files.

4. **Open Terminal in that folder** and run:
   ```bash
   chmod +x install.sh
   ```**
   Then**
   ```bash
   ./install.sh
   ```

That's it! The server will automatically run every time you log in.

## Verify

Check if the server is running:
```bash
ps aux | grep server_macos_debug
```

If you see a process for `server_macos_debug`, it's working.

## Logs

Output logs are saved in the same folder:
- `discord-rpc.log` - Standard output
- `discord-rpc-error.log` - Error messages

## Uninstall

To remove the auto-start:
```bash
launchctl unload ~/Library/LaunchAgents/com.discord.rpc.autorun.plist
rm ~/Library/LaunchAgents/com.discord.rpc.autorun.plist
```

- **One command** - Just run `./install.sh` once
- **Better logging** - Logs go to files instead of cluttering `nohup.out`
- **Auto-restart** - Restarts automatically if it crashes
