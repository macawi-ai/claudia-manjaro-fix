#!/bin/bash

# Enhanced Claudia Production Launcher
# Addresses WebKit/Tauri communication issues on Manjaro Linux
# v2.0 - Comprehensive fixes for "Connection refused on 127.0.0.1" errors

echo "🚀 Claudia Manjaro Production Launcher v2.0"
echo "==========================================="

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

# Network and localhost fixes
export NO_PROXY=127.0.0.1,localhost
export WEBKIT_IGNORE_TLS_ERRORS=1

# AppImage build compatibility
export NO_STRIP=1

# Find the executable path - check multiple possible locations
if [ -f "./src-tauri/target/release/claudia" ]; then
    CLAUDIA_EXEC="./src-tauri/target/release/claudia"
elif [ -f "./claudia" ]; then
    CLAUDIA_EXEC="./claudia"
elif [ -f "../claudia" ]; then
    CLAUDIA_EXEC="../claudia"
else
    # Allow specifying path as first argument
    if [ -n "$1" ] && [ -f "$1" ]; then
        CLAUDIA_EXEC="$1"
        shift  # Remove the path from arguments
    else
        echo "Error: Could not find Claudia executable"
        echo "Usage: $0 [path-to-claudia-executable] [claudia-args...]"
        echo ""
        echo "The executable is typically at: ./src-tauri/target/release/claudia"
        echo "after running 'build-exe' or 'build-full'"
        exit 1
    fi
fi

# Pre-flight checks
echo "🔍 Pre-flight checks:"
echo "  Executable: $CLAUDIA_EXEC"

# Check if dist directory exists (production builds need this)
if [ -d "./dist" ]; then
    echo "  Frontend: ./dist (found)"
else
    echo "  Frontend: ./dist (not found - may cause issues)"
fi

# Check if claude-code binary exists (Tauri may need this)
if [ -f "./src-tauri/target/release/claude-code" ]; then
    echo "  Backend: ./src-tauri/target/release/claude-code (found)"
elif [ -f "./src-tauri/binaries/claude-code-x86_64-unknown-linux-gnu" ]; then
    echo "  Backend: ./src-tauri/binaries/claude-code* (found)"
else
    echo "  Backend: claude-code binary not found (may be normal)"
fi

echo ""
echo "🔧 WebKit environment variables set:"
echo "  WEBKIT_DISABLE_COMPOSITING_MODE=1"
echo "  WEBKIT_DISABLE_DMABUF_RENDERER=1"
echo "  WEBKIT_DISABLE_SANDBOX_THIS_IS_DANGEROUS=1"
echo "  GTK_USE_PORTAL=0"
echo "  GDK_BACKEND=x11"
echo "  + Additional IPC communication fixes"
echo ""

# Launch Claudia with all fixes applied
echo "🚀 Starting Claudia..."
exec "$CLAUDIA_EXEC" "$@"
