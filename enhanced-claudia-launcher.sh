#!/bin/bash

# Enhanced Claudia Production Launcher
# Addresses WebKit/Tauri communication issues on Manjaro Linux

echo "🚀 Enhanced Claudia Launcher - WebKit/Tauri Communication Fix"
echo "============================================================"

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
export RUST_LOG=tauri=debug,wry=debug
export TAURI_DEBUG=1

# Disable problematic WebKit features that can block IPC
export WEBKIT_DISABLE_WEB_SECURITY=1
export WEBKIT_DISABLE_FEATURES=WebGPU,WebRTC

# Network and localhost fixes
export NO_PROXY=127.0.0.1,localhost
export WEBKIT_IGNORE_TLS_ERRORS=1

CLAUDIA_HOME="${1:-./}"
CLAUDIA_EXEC="$CLAUDIA_HOME/src-tauri/target/release/claudia"

echo "🏠 Claudia Home: $CLAUDIA_HOME"
echo "🚀 Executable: $CLAUDIA_EXEC"
echo ""

# Comprehensive validation
if [ ! -d "$CLAUDIA_HOME" ]; then
    echo "❌ Error: Claudia home directory not found: $CLAUDIA_HOME"
    exit 1
fi

if [ ! -f "$CLAUDIA_EXEC" ]; then
    echo "❌ Error: Claudia executable not found: $CLAUDIA_EXEC"
    echo "💡 Run './claudia-manjaro.sh build-exe' to build it"
    exit 1
fi

if [ ! -d "$CLAUDIA_HOME/dist" ]; then
    echo "❌ Error: Frontend dist directory not found: $CLAUDIA_HOME/dist"
    echo "💡 Run 'bun run build' to build the frontend"
    exit 1
fi

if [ ! -f "$CLAUDIA_HOME/dist/index.html" ]; then
    echo "❌ Error: Frontend index.html not found"
    exit 1
fi

echo "✅ All paths and assets verified"
echo ""

echo "🔧 Environment variables set:"
echo "  WEBKIT_DISABLE_COMPOSITING_MODE=1"
echo "  WEBKIT_DISABLE_DMABUF_RENDERER=1" 
echo "  WEBKIT_DISABLE_SANDBOX_THIS_IS_DANGEROUS=1"
echo "  GTK_USE_PORTAL=0"
echo "  GDK_BACKEND=x11"
echo "  WEBKIT_PROCESS_MODEL=multiple-secondary-processes"
echo "  WEBKIT_DISABLE_WEB_SECURITY=1"
echo ""

# Change to Claudia home to ensure all relative paths work
cd "$CLAUDIA_HOME" || exit 1

echo "🔍 Frontend assets:"
ls -la dist/ | head -5
echo ""

echo "🚀 Launching Claudia with enhanced WebKit/Tauri fixes..."
echo "======================================================="
echo ""

# Pre-launch backend validation
echo "🔧 Validating Tauri backend compatibility..."

# Check if claude-code binary is accessible (needed by Tauri)
CLAUDE_CODE_BINARY="$CLAUDIA_HOME/src-tauri/target/release/claude-code"
if [ -f "$CLAUDE_CODE_BINARY" ]; then
    echo "✅ Claude Code backend binary found: $CLAUDE_CODE_BINARY"
    
    # Test if the binary is functional
    if "$CLAUDE_CODE_BINARY" --version >/dev/null 2>&1; then
        echo "✅ Claude Code backend is functional"
    else
        echo "⚠️  Claude Code backend may have issues"
    fi
else
    echo "⚠️  Claude Code backend binary not found: $CLAUDE_CODE_BINARY"
fi

echo ""

# Launch with comprehensive debugging if needed
if [ "$2" = "--debug" ]; then
    echo "🐛 Debug mode enabled - output will be verbose"
    exec "$CLAUDIA_EXEC" 2>&1
else
    # Normal launch with error capture
    echo "🚀 Starting Claudia..."
    exec "$CLAUDIA_EXEC" 2>&1
fi