#!/bin/bash
set -e

echo "⚙️ Setting up Discord RPC on macOS..."

APP_DIR="$(cd "$(dirname "$0")" && pwd)"
PLIST_PATH="$HOME/Library/LaunchAgents/com.discord.rpc.autorun.plist"

# Remove quarantine bit so macOS allows auto-start
xattr -dr com.apple.quarantine "$APP_DIR" 2>/dev/null || true

# Ensure server binary exists
if [ ! -f "$APP_DIR/server_macos_debug" ]; then
  echo "❌ Error: server_macos_debug must be in this folder."
  exit 1
fi

# Set executable permission
chmod +x "$APP_DIR/server_macos_debug"

# Create LaunchAgent plist that runs the server directly
cat <<EOF > "$PLIST_PATH"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.discord.rpc.autorun</string>

    <key>ProgramArguments</key>
    <array>
        <string>$APP_DIR/server_macos_debug</string>
    </array>

    <key>WorkingDirectory</key>
    <string>$APP_DIR</string>

    <key>RunAtLoad</key>
    <true/>

    <key>KeepAlive</key>
    <true/>

    <key>StandardOutPath</key>
    <string>$APP_DIR/discord-rpc.log</string>

    <key>StandardErrorPath</key>
    <string>$APP_DIR/discord-rpc-error.log</string>
</dict>
</plist>
EOF

# Reload the agent
launchctl unload "$PLIST_PATH" 2>/dev/null || true
launchctl load "$PLIST_PATH"

echo "✅ Done! Discord RPC will now auto-start every login."
echo "📊 Logs: $APP_DIR/discord-rpc.log"
echo "🔍 Test with: ps aux | grep server_macos_debug"
echo ""
echo "To uninstall: launchctl unload '$PLIST_PATH' && rm '$PLIST_PATH'"
