#!/bin/bash

# Claudia Development Mode Launcher
# Uses development mode which works around production WebView/IPC issues

echo "🚀 Claudia Development Mode Launcher"
echo "===================================="
echo ""

# Comprehensive WebKit fixes for Manjaro/Arch Linux
export WEBKIT_DISABLE_COMPOSITING_MODE=1
export PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1
export WEBKIT_DISABLE_DMABUF_RENDERER=1
export WEBKIT_DISABLE_SANDBOX_THIS_IS_DANGEROUS=1
export APPIMAGE_EXTRACT_AND_RUN=1

# WebKit IPC and communication fixes
export GTK_USE_PORTAL=0
export GDK_BACKEND=x11
export WEBKIT_PROCESS_MODEL=multiple-secondary-processes

# Additional Tauri/WebView communication fixes
export WEBKIT_DISABLE_WEB_SECURITY=1
export WEBKIT_DISABLE_FEATURES=WebGPU,WebRTC

echo "🔧 WebKit environment variables set for Manjaro compatibility"
echo "💡 Using development mode to bypass production WebView/IPC issues"
echo ""

# Make sure we're in the right directory
if [ ! -f "./src-tauri/Cargo.toml" ]; then
    echo "❌ Not in Claudia directory. Please run from the Claudia installation directory."
    exit 1
fi

# Ensure bun is available
if ! command -v bun &> /dev/null; then
    echo "❌ Bun not found. Please ensure Bun is installed and in PATH."
    exit 1
fi

echo "🚀 Starting Claudia in development mode..."
echo "📍 This avoids the production WebView/IPC issues on Manjaro"
echo ""

# Start development mode
exec bun run tauri dev