#!/bin/bash
set -e

echo "⚙️ Setting up Discord RPC on macOS..."

# Get the folder where this script is located
APP_DIR="$(cd "$(dirname "$0")" && pwd)"
PLIST_PATH="$HOME/Library/LaunchAgents/com.discord.rpc.autorun.plist"

# Ensure dos2unix is installed
if ! command -v dos2unix &>/dev/null; then
  echo "📦 Installing dos2unix..."
  brew install dos2unix
fi

# Fix line endings for start.sh
if [ -f "$APP_DIR/start.sh" ]; then
  dos2unix "$APP_DIR/start.sh" >/dev/null 2>&1 || true
else
  echo "❌ Error: start.sh not found in this folder"
  exit 1
fi

# Make scripts executable
chmod +x "$APP_DIR/start.sh" "$APP_DIR/server_macos_debug"

# Create LaunchAgent for auto-start
cat <<EOF > "$PLIST_PATH"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN"
    "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.discord.rpc.autorun</string>
    <key>ProgramArguments</key>
    <array>
        <string>$APP_DIR/start.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
</dict>
</plist>
EOF

# Load it into launchd
launchctl unload "$PLIST_PATH" 2>/dev/null || true
launchctl load "$PLIST_PATH"

echo "✅ Setup complete! Discord RPC will now auto-start on login."
echo "🔍 To check if it's running: ps aux | grep server_macos_debug"