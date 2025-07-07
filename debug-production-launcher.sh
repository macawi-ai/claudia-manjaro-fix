#!/bin/bash

# Debug Claudia Production Launcher
# This script helps diagnose connection issues

echo "🔍 Claudia Debug Launcher"
echo "========================"

# Critical WebKit fixes for Manjaro/Arch Linux
export WEBKIT_DISABLE_COMPOSITING_MODE=1
export PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1
export WEBKIT_DISABLE_DMABUF_RENDERER=1
export WEBKIT_DISABLE_SANDBOX_THIS_IS_DANGEROUS=1
export APPIMAGE_EXTRACT_AND_RUN=1

# Additional debug flags
export WEBKIT_DEBUG=Network,Loading
export RUST_LOG=debug
export TAURI_LOG=debug

CLAUDIA_HOME="${1:-./}"
CLAUDIA_EXEC="$CLAUDIA_HOME/src-tauri/target/release/claudia"

echo "🏠 Claudia Home: $CLAUDIA_HOME"
echo "🚀 Executable: $CLAUDIA_EXEC"
echo ""

# Verify paths
if [ ! -d "$CLAUDIA_HOME" ]; then
    echo "❌ Error: Claudia home directory not found: $CLAUDIA_HOME"
    exit 1
fi

if [ ! -f "$CLAUDIA_EXEC" ]; then
    echo "❌ Error: Claudia executable not found: $CLAUDIA_EXEC"
    echo "💡 Run './claudia-manjaro.sh build-exe' to build it"
    exit 1
fi

# Check dist directory
if [ ! -d "$CLAUDIA_HOME/dist" ]; then
    echo "❌ Error: Frontend dist directory not found: $CLAUDIA_HOME/dist"
    echo "💡 Run 'bun run build' to build the frontend"
    exit 1
fi

echo "✅ All paths verified"
echo ""

# Check for index.html
if [ ! -f "$CLAUDIA_HOME/dist/index.html" ]; then
    echo "❌ Error: Frontend index.html not found"
    exit 1
fi

echo "📁 Frontend files:"
ls -la "$CLAUDIA_HOME/dist/" | head -10
echo ""

echo "🔧 Environment variables set:"
echo "  WEBKIT_DISABLE_COMPOSITING_MODE=1"
echo "  WEBKIT_DISABLE_DMABUF_RENDERER=1"
echo "  WEBKIT_DISABLE_SANDBOX_THIS_IS_DANGEROUS=1"
echo "  WEBKIT_DEBUG=Network,Loading"
echo "  RUST_LOG=debug"
echo ""

# Change to Claudia home to ensure relative paths work
cd "$CLAUDIA_HOME" || exit 1

echo "🚀 Launching Claudia with debug output..."
echo "========================================="
echo ""

# Launch with full debug output
exec "$CLAUDIA_EXEC" 2>&1