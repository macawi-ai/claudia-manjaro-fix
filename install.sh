  #!/bin/bash

  # Claudia WebKit Fix Installation Script for Manjaro Linux
  # Resolves WebKit compositing issues with Tauri applications
  #
  # Author: Jamie Saker <jamie.saker@macawi.ai>
  # Company: Macawi
  # License: Apache 2.0
  # Repository: https://github.com/[YOUR-USERNAME]/claudia-manjaro-fix

  set -e

  SCRIPT_VERSION="1.0.0"
  SCRIPT_AUTHOR="Jamie Saker <jamie.saker@macawi.ai>"
  SCRIPT_COMPANY="Macawi"

  echo "🚀 Claudia WebKit Fix Installer v${SCRIPT_VERSION}"
  echo "=================================================="
  echo "Author: ${SCRIPT_AUTHOR}"
  echo "Company: ${SCRIPT_COMPANY}"
  echo ""
  echo "This script resolves WebKit compositing issues on Manjaro Linux"
  echo ""

  # Check if we're on a compatible system
  if ! command -v pacman &> /dev/null; then
      echo "❌ Error: This script is designed for Manjaro/Arch-based systems"
      echo "💡 For other distributions, manually set: WEBKIT_DISABLE_COMPOSITING_MODE=1"
      exit 1
  fi

  # Detect WebKit version
  WEBKIT_VERSION=$(pacman -Q webkit2gtk-4.1 2>/dev/null | awk '{print $2}' || echo "not found")
  echo "🔍 Detected WebKit version: $WEBKIT_VERSION"

  if [[ "$WEBKIT_VERSION" == "not found" ]]; then
      echo "⚠  WebKit not found, will install required packages"
  fi

  # Check if bun is installed
  if ! command -v bun &> /dev/null; then
      echo "📦 Installing Bun JavaScript runtime..."
      curl -fsSL https://bun.sh/install | bash
      export PATH="$HOME/.bun/bin:$PATH"
      echo "✅ Bun installed successfully"
  fi

  # Check for required system packages
  echo "🔍 Checking system dependencies..."
  REQUIRED_PACKAGES=("webkit2gtk-4.1" "gtk3" "libayatana-appindicator" "rust" "nodejs" "npm")
  MISSING_PACKAGES=()

  for package in "${REQUIRED_PACKAGES[@]}"; do
      if ! pacman -Q "$package" &> /dev/null 2>&1; then
          MISSING_PACKAGES+=("$package")
      fi
  done

  if [ ${#MISSING_PACKAGES[@]} -ne 0 ]; then
      echo "📦 Installing missing packages: ${MISSING_PACKAGES[*]}"
      sudo pacman -S --needed "${MISSING_PACKAGES[@]}"
      echo "✅ System dependencies installed"
  fi

  # Ask user for Claudia installation directory
  read -p "📁 Enter Claudia installation directory [./claudia]: " CLAUDIA_DIR
  CLAUDIA_DIR=${CLAUDIA_DIR:-./claudia}
  CLAUDIA_DIR=$(realpath "$CLAUDIA_DIR")

  # Clone or navigate to Claudia
  if [ ! -d "$CLAUDIA_DIR" ]; then
      echo "📥 Claudia not found. Please provide the repository URL or local path:"
      read -p "🔗 Claudia repository URL or local path: " CLAUDIA_SOURCE

      if [[ "$CLAUDIA_SOURCE" == http* ]] || [[ "$CLAUDIA_SOURCE" == git* ]]; then
          echo "📥 Cloning Claudia from repository..."
          git clone "$CLAUDIA_SOURCE" "$CLAUDIA_DIR"
      elif [ -d "$CLAUDIA_SOURCE" ]; then
          echo "📁 Copying Claudia from local directory..."
          cp -r "$CLAUDIA_SOURCE" "$CLAUDIA_DIR"
      else
          echo "❌ Invalid repository URL or directory path"
          exit 1
      fi
  else
      echo "📁 Using existing Claudia directory: $CLAUDIA_DIR"
  fi

  cd "$CLAUDIA_DIR"

  # Install dependencies
  echo "📦 Installing Claudia dependencies..."
  bun install
  echo "✅ Dependencies installed"

  # Create WebKit-compatible launch script
  echo "🔧 Creating WebKit-compatible launch script..."
  cat > claudia-manjaro.sh << 'LAUNCHER_EOF'
  #!/bin/bash

  # Claudia Launcher for Manjaro Linux
  # Automatically applies WebKit compatibility fixes
  #
  # Author: Jamie Saker <jamie.saker@macawi.ai>
  # Company: Macawi
  # License: Apache 2.0

  export WEBKIT_DISABLE_COMPOSITING_MODE=1
  export PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1

  # Additional WebKit stability flags
  export WEBKIT_DISABLE_DMABUF_RENDERER=1
  export WEBKIT_FORCE_SANDBOX=0

  echo "🚀 Claudia Manjaro Launcher"
  echo "Author: Jamie Saker <jamie.saker@macawi.ai>"
  echo "Company: Macawi"
  echo ""
  echo "💡 WebKit compositing disabled for Manjaro compatibility"
  echo "📍 Working directory: $(pwd)"
  echo ""

  case "$1" in
      "dev"|"development"|"")
          echo "🔧 Starting development server..."
          bun run tauri dev
          ;;
      "build"|"production")
          echo "🏗  Building production version..."
          bun run tauri build
          ;;
      "clean")
          echo "🧹 Cleaning build artifacts..."
          rm -rf dist/ target/ node_modules/.cache/
          echo "✅ Clean complete"
          ;;
      *)
          echo "Usage: $0 [command]"
          echo ""
          echo "Commands:"
          echo "  dev       Start development server (default)"
          echo "  build     Build production version"
          echo "  clean     Clean build artifacts"
          echo ""
          echo "Environment variables applied:"
          echo "  WEBKIT_DISABLE_COMPOSITING_MODE=1"
          echo "  PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1"
          echo "  WEBKIT_DISABLE_DMABUF_RENDERER=1"
          echo "  WEBKIT_FORCE_SANDBOX=0"
          echo ""
          echo "Fix developed by: Jamie Saker <jamie.saker@macawi.ai>"
          exit 1
          ;;
  esac
  LAUNCHER_EOF

  chmod +x claudia-manjaro.sh
  echo "✅ Launch script created: claudia-manjaro.sh"

  # Create desktop entry
  echo "🖥  Creating desktop entry..."
  mkdir -p ~/.local/share/applications

  ICON_PATH="$CLAUDIA_DIR/src-tauri/icons/icon.png"
  if [ ! -f "$ICON_PATH" ]; then
      ICON_PATH="applications-development"  # Fallback to system icon
  fi

  cat > ~/.local/share/applications/claudia.desktop << DESKTOP_EOF
  [Desktop Entry]
  Version=1.0
  Type=Application
  Name=Claudia
  Comment=Claude Code Session Browser (Manjaro Compatible - Fix by Jamie Saker/Macawi)
  Exec=$CLAUDIA_DIR/claudia-manjaro.sh dev
  Icon=$ICON_PATH
  Terminal=true
  Categories=Development;IDE;
  Keywords=claude;ai;development;tauri;manjaro;
  StartupNotify=true
  DESKTOP_EOF

  echo "✅ Desktop entry created"

  # Set up shell aliases
  echo "🔗 Setting up shell aliases..."
  SHELL_RC=""
  if [ -n "$ZSH_VERSION" ]; then
      SHELL_RC="$HOME/.zshrc"
  elif [ -n "$BASH_VERSION" ]; then
      SHELL_RC="$HOME/.bashrc"
  elif [ -f "$HOME/.zshrc" ]; then
      SHELL_RC="$HOME/.zshrc"
  elif [ -f "$HOME/.bashrc" ]; then
      SHELL_RC="$HOME/.bashrc"
  fi

  if [ -n "$SHELL_RC" ]; then
      if ! grep -q "# Claudia Manjaro aliases (Jamie Saker/Macawi)" "$SHELL_RC" 2>/dev/null; then
          echo "" >> "$SHELL_RC"
          echo "# Claudia Manjaro aliases (Jamie Saker/Macawi)" >> "$SHELL_RC"
          echo "alias claudia-dev='cd $CLAUDIA_DIR && ./claudia-manjaro.sh dev'" >> "$SHELL_RC"
          echo "alias claudia-build='cd $CLAUDIA_DIR && ./claudia-manjaro.sh build'" >> "$SHELL_RC"
          echo "alias claudia-clean='cd $CLAUDIA_DIR && ./claudia-manjaro.sh clean'" >> "$SHELL_RC"
          echo "✅ Added aliases to $SHELL_RC"
          echo "💡 Restart your terminal or run: source $SHELL_RC"
      else
          echo "⚠  Aliases already exist in $SHELL_RC"
      fi
  fi

  # Create uninstall script
  cat > uninstall-claudia-manjaro.sh << UNINSTALL_EOF
  #!/bin/bash
  # Uninstaller for Claudia Manjaro fix by Jamie Saker <jamie.saker@macawi.ai>

  echo "🗑  Uninstalling Claudia Manjaro compatibility setup..."
  echo "Fix originally by: Jamie Saker <jamie.saker@macawi.ai> (Macawi)"
  rm -f ~/.local/share/applications/claudia.desktop
  sed -i '/# Claudia Manjaro aliases (Jamie Saker\/Macawi)/,+3d' $SHELL_RC 2>/dev/null || true
  echo "✅ Uninstall complete"
  echo "💡 Claudia directory preserved at: $CLAUDIA_DIR"
  UNINSTALL_EOF
  chmod +x uninstall-claudia-manjaro.sh

  echo ""
  echo "🎉 Installation Complete!"
  echo "========================"
  echo "Fix by: Jamie Saker <jamie.saker@macawi.ai> (Macawi)"
  echo ""
  echo "📍 Claudia installed at: $CLAUDIA_DIR"
  echo ""
  echo "🚀 To start Claudia:"
  echo "   cd $CLAUDIA_DIR"
  echo "   ./claudia-manjaro.sh dev"
  echo ""
  echo "📝 Or use aliases (after restarting terminal):"
  echo "   claudia-dev      # Start development server"
  echo "   claudia-build    # Build production version"
  echo "   claudia-clean    # Clean build artifacts"
  echo ""
  echo "🖥  Desktop entry created - search for 'Claudia' in your application menu"
  echo ""
  echo "⚠  Important: Always use these scripts instead of 'bun run tauri dev' directly"
  echo "💡 The scripts automatically apply WebKit compatibility fixes for Manjaro"
  echo ""
  echo "🗑  To uninstall: ./uninstall-claudia-manjaro.sh"
  echo ""
  echo "📧 Support: jamie.saker@macawi.ai"

  This is the main installation script that automates the WebKit fix setup for Manjaro users. It detects
  the system, installs dependencies, creates the compatibility launcher, and sets up convenient aliases
  and desktop entries.

