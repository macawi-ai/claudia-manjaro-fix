  #!/bin/bash

  # Claudia Launcher for Manjaro Linux
  # Automatically applies WebKit compatibility fixes
  #
  # Author: Jamie Saker <jamie.saker@macawi.ai>
  # Company: Macawi
  # License: Apache 2.0

  LAUNCHER_VERSION="1.1.0"
  LAUNCHER_AUTHOR="Jamie Saker <jamie.saker@macawi.ai>"
  LAUNCHER_COMPANY="Macawi"
  RELEASE_DATE="2025-01-05"

  # Function to show version information
  show_launcher_version() {
      echo "╔════════════════════════════════════════════════════════════╗"
      echo "║                Claudia Manjaro Launcher                   ║"
      echo "╠════════════════════════════════════════════════════════════╣"
      echo "║ Version:     ${LAUNCHER_VERSION}                                          ║"
      echo "║ Released:    ${RELEASE_DATE}                                    ║"
      echo "║ Author:      ${LAUNCHER_AUTHOR}                   ║"
      echo "║ Company:     ${LAUNCHER_COMPANY}                                        ║"
      echo "╠════════════════════════════════════════════════════════════╣"
      echo "║ PURPOSE                                                    ║"
      echo "║ Launches Claudia with WebKit fixes for Manjaro Linux      ║"
      echo "║ Applies environment variables to prevent white screen     ║"
      echo "║ Provides build options to avoid AppImage bundling issues  ║"
      echo "╠════════════════════════════════════════════════════════════╣"
      echo "║ ENVIRONMENT VARIABLES SET                                  ║"
      echo "║ • WEBKIT_DISABLE_COMPOSITING_MODE=1                       ║"
      echo "║ • PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1                        ║"
      echo "║ • WEBKIT_DISABLE_DMABUF_RENDERER=1                        ║"
      echo "║ • WEBKIT_FORCE_SANDBOX=0                                  ║"
      echo "╠════════════════════════════════════════════════════════════╣"
      if command -v bun &> /dev/null; then
          echo "║ Runtime:     Bun $(bun --version)                                   ║"
      elif command -v node &> /dev/null; then
          echo "║ Runtime:     Node.js $(node --version)                             ║"
      else
          echo "║ Runtime:     No JavaScript runtime found!                     ║"
      fi
      if [ -f "src-tauri/Cargo.toml" ]; then
          CLAUDIA_VERSION=$(grep '^version' src-tauri/Cargo.toml | head -1 | cut -d'"' -f2)
          echo "║ Claudia:     v${CLAUDIA_VERSION}                                          ║"
      else
          echo "║ Claudia:     Version unknown (Cargo.toml not found)           ║"
      fi
      echo "║ Directory:   $(pwd | sed 's|.*/||')                                     ║"
      echo "╚════════════════════════════════════════════════════════════╝"
      exit 0
  }

  # Check for version flag
  if [[ "$1" == "--version" ]] || [[ "$1" == "-v" ]] || [[ "$1" == "version" ]]; then
      show_launcher_version
  fi

  export WEBKIT_DISABLE_COMPOSITING_MODE=1
  export PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1

  # Additional WebKit stability flags
  export WEBKIT_DISABLE_DMABUF_RENDERER=1
  export WEBKIT_DISABLE_SANDBOX_THIS_IS_DANGEROUS=1
  
  # WebKit IPC and sandbox fixes for production builds
  export GTK_USE_PORTAL=0
  export GDK_BACKEND=x11
  
  # AppImage bundling fixes for Manjaro - CRITICAL for Tauri's cached linuxdeploy
  export APPIMAGE_EXTRACT_AND_RUN=1
  
  # Tauri Cache Governor: Ensure Tauri's own linuxdeploy cache uses extract-and-run
  if [ -d "$HOME/.cache/tauri" ]; then
      echo "🔧 Tauri cache detected - ensuring AppImage compatibility..."
      # Force all AppImage tools in Tauri's cache to use extract-and-run
      export APPIMAGE_EXTRACT_AND_RUN=1
  fi

  echo "🚀 Claudia Manjaro Launcher v${LAUNCHER_VERSION}"
  echo "Author: ${LAUNCHER_AUTHOR}"
  echo "Company: ${LAUNCHER_COMPANY}"
  echo ""
  echo "💡 WebKit compositing disabled for Manjaro compatibility"
  echo "📍 Working directory: $(pwd)"
  echo ""

  # Detect available package manager with fallback chain
  if command -v bun &> /dev/null; then
      PKG_MANAGER="bun"
      echo "📦 Using Bun package manager"
  elif command -v npm &> /dev/null; then
      PKG_MANAGER="npm"
      echo "📦 Using npm package manager"
  else
      echo "❌ No JavaScript package manager found (neither bun nor npm)"
      echo "💡 Please install bun or npm first"
      exit 1
  fi

  case "$1" in
      "dev"|"development"|"")
          echo "🔧 Starting development server..."
          $PKG_MANAGER run tauri dev
          ;;
      "build"|"production")
          echo "🏗  Building production version (deb, rpm)..."
          $PKG_MANAGER run tauri build
          ;;
      "build-exe"|"executable")
          echo "🏗  Building executable only..."
          $PKG_MANAGER run tauri build --no-bundle
          ;;
      "build-full"|"bundle"|"appimage")
          echo "🏗  Building with AppImage (requires fuse2, appstream-glib)..."
          
          # Cybernetic Governor: Validate environment before attempting build
          echo "🔍 Running pre-build validation..."
          
          # Check if we're in the right directory
          if [ ! -f "src-tauri/Cargo.toml" ]; then
              echo "❌ Not in Claudia project directory! Cannot build."
              echo "💡 Navigate to your Claudia installation directory first:"
              echo "   cd /path/to/claudia && ./claudia-manjaro.sh build-full"
              exit 1
          fi
          
          # Test linuxdeploy system installation (our wrapper)
          if ! command -v linuxdeploy &> /dev/null; then
              echo "⚠️  System linuxdeploy not found, but Tauri will download its own"
          else
              echo "✅ System linuxdeploy available"
          fi
          
          # Critical: Test Tauri's cached linuxdeploy with extract-and-run
          if [ -f "$HOME/.cache/tauri/linuxdeploy-x86_64.AppImage" ]; then
              echo "🔧 Testing Tauri's cached linuxdeploy with AppImage compatibility..."
              if APPIMAGE_EXTRACT_AND_RUN=1 "$HOME/.cache/tauri/linuxdeploy-x86_64.AppImage" --version >/dev/null 2>&1; then
                  echo "✅ Tauri's linuxdeploy works with extract-and-run mode"
              else
                  echo "❌ Tauri's linuxdeploy fails even with extract-and-run"
                  echo "💡 Clearing Tauri cache and letting it re-download..."
                  rm -f "$HOME/.cache/tauri/linuxdeploy"*
              fi
          fi
          
          # Critical AppImage Abstract Machine: Strip tool compatibility
          echo "🔧 Configuring AppImage environment for Tauri..."
          export APPIMAGE_EXTRACT_AND_RUN=1
          export NO_STRIP=1  # Essential: Bypass strip tool incompatibility with modern ELF formats
          
          if [ -f "src-tauri/tauri.conf.appimage.json" ]; then
              echo "🚀 Starting AppImage build with configuration..."
              $PKG_MANAGER run tauri build --config src-tauri/tauri.conf.appimage.json
          else
              echo "🚀 Starting AppImage build with default configuration..."
              $PKG_MANAGER run tauri build
          fi
          ;;
      "clean")
          echo "🧹 Cleaning build artifacts..."
          rm -rf dist/ target/ node_modules/.cache/
          echo "✅ Clean complete"
          ;;
      "help"|"-h"|"--help")
          echo "Usage: $0 [command]"
          echo ""
          echo "Commands:"
          echo "  dev         Start development server (default)"
          echo "  build       Build with deb and rpm packages"
          echo "  build-exe   Build executable only (no bundles)"
          echo "  build-full  Build with AppImage (requires dependencies)"
          echo "  clean       Clean build artifacts"
          echo "  version     Show version information"
          echo "  help        Show this help message"
          echo ""
          echo "Environment variables applied:"
          echo "  WEBKIT_DISABLE_COMPOSITING_MODE=1"
          echo "  PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1"
          echo "  WEBKIT_DISABLE_DMABUF_RENDERER=1"
          echo "  WEBKIT_FORCE_SANDBOX=0"
          echo ""
          echo "Fix developed by: ${LAUNCHER_AUTHOR}"
          ;;
      *)
          echo "❌ Unknown command: $1"
          echo ""
          echo "Usage: $0 [command]"
          echo ""
          echo "Commands:"
          echo "  dev         Start development server (default)"
          echo "  build       Build with deb and rpm packages"
          echo "  build-exe   Build executable only (no bundles)"
          echo "  build-full  Build with AppImage (requires dependencies)"
          echo "  clean       Clean build artifacts"
          echo "  version     Show version information"
          echo "  help        Show help message"
          echo ""
          echo "💡 Run '$0 help' for detailed information"
          echo "💡 Run '$0 version' for version details"
          exit 1
          ;;
  esac
