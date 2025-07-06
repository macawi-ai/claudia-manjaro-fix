  #!/bin/bash

  # Claudia WebKit Fix Installation Script for Manjaro Linux
  # Resolves WebKit compositing issues with Tauri applications
  #
  # Author: Jamie Saker <jamie.saker@macawi.ai>
  # Company: Macawi
  # License: Apache 2.0
  # Repository: https://github.com/[YOUR-USERNAME]/claudia-manjaro-fix

  # Removed set -e to allow better error handling

  # Self-validation function
  validate_script() {
      echo "🔍 Validating script syntax and structure..."
      
      # Check bash syntax
      if ! bash -n "$0" 2>/dev/null; then
          echo "❌ Script has syntax errors"
          bash -n "$0"
          return 1
      fi
      
      # Check heredoc EOF markers are balanced
      local heredoc_starts=$(grep "<<[[:space:]]*['\"].*EOF\|<<[[:space:]]*[A-Z_]*EOF[[:space:]]*$" "$0" 2>/dev/null | wc -l || echo "0")
      local heredoc_ends=$(grep "^[A-Z_]*EOF$" "$0" 2>/dev/null | wc -l || echo "0")
      if [ "$heredoc_starts" -ne "$heredoc_ends" ]; then
          echo "❌ Unbalanced heredoc blocks: $heredoc_starts starts, $heredoc_ends ends"
          echo "💡 Check these EOF markers:"
          grep -n "<<\|_EOF$" "$0"
          return 1
      fi
      
      # Check for common issues
      local issues=0
      if grep -q "<<[[:space:]]*[A-Z_]*EOF[[:space:]]*$" "$0" | grep -v "'.*EOF'"; then
          echo "⚠  Found unquoted heredoc markers (may cause variable expansion issues):"
          grep -n "<<[[:space:]]*[A-Z_]*EOF[[:space:]]*$" "$0" | grep -v "'.*EOF'"
          issues=$((issues + 1))
      fi
      
      if [ $issues -eq 0 ]; then
          echo "✅ Script validation passed"
          return 0
      else
          echo "⚠  Script validation completed with $issues warnings"
          return 0
      fi
  }

  # Handle validation flag
  if [[ "$1" == "--validate" ]] || [[ "$1" == "validate" ]]; then
      validate_script
      exit $?
  fi

  SCRIPT_VERSION="1.1.0"
  SCRIPT_AUTHOR="Jamie Saker <jamie.saker@macawi.ai>"
  SCRIPT_COMPANY="Macawi"
  SCRIPT_LICENSE="Apache 2.0"
  SCRIPT_REPO="https://github.com/macawi-ai/claudia-manjaro-fix"
  CLAUDIA_REPO="https://github.com/getAsterisk/claudia"
  RELEASE_DATE="2025-01-05"

  # Function to display version information
  show_version() {
      echo "╔════════════════════════════════════════════════════════════╗"
      echo "║              Claudia WebKit Fix for Manjaro Linux         ║"
      echo "╠════════════════════════════════════════════════════════════╣"
      echo "║ Version:     ${SCRIPT_VERSION}                                          ║"
      echo "║ Released:    ${RELEASE_DATE}                                    ║"
      echo "║ Author:      ${SCRIPT_AUTHOR}                   ║"
      echo "║ Company:     ${SCRIPT_COMPANY}                                        ║"
      echo "║ License:     ${SCRIPT_LICENSE}                                   ║"
      echo "╠════════════════════════════════════════════════════════════╣"
      echo "║ Repository:  ${SCRIPT_REPO}  ║"
      echo "║ Claudia:     ${CLAUDIA_REPO}        ║"
      echo "╠════════════════════════════════════════════════════════════╣"
      echo "║ FEATURES                                                   ║"
      echo "║ • WebKit compositing fix for Manjaro Linux                ║"
      echo "║ • Automated dependency installation                       ║"
      echo "║ • AppImage bundling workaround                            ║"
      echo "║ • Enhanced error handling and validation                  ║"
      echo "║ • Desktop integration and shell aliases                   ║"
      echo "╠════════════════════════════════════════════════════════════╣"
      echo "║ ENVIRONMENT FIXES                                          ║"
      echo "║ • WEBKIT_DISABLE_COMPOSITING_MODE=1                       ║"
      echo "║ • PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1                        ║"
      echo "║ • WEBKIT_DISABLE_DMABUF_RENDERER=1                        ║"
      echo "║ • WEBKIT_FORCE_SANDBOX=0                                  ║"
      echo "╠════════════════════════════════════════════════════════════╣"
      echo "║ SYSTEM REQUIREMENTS                                        ║"
      echo "║ • Manjaro Linux / Arch-based distribution                 ║"
      echo "║ • Internet connection for downloads                       ║"
      echo "║ • 2GB+ free disk space                                    ║"
      echo "║ • WebKit 2.48.3+ (automatically handled)                  ║"
      echo "╚════════════════════════════════════════════════════════════╝"
      echo ""
      echo "🔍 System Information:"
      echo "   OS: $(uname -s) $(uname -r)"
      echo "   Architecture: $(uname -m)"
      if command -v pacman &> /dev/null; then
          echo "   Package Manager: pacman ($(pacman --version | head -1))"
          if pacman -Q webkit2gtk-4.1 &> /dev/null; then
              echo "   WebKit: $(pacman -Q webkit2gtk-4.1)"
          else
              echo "   WebKit: Not installed"
          fi
      fi
      if command -v bun &> /dev/null; then
          echo "   Bun: $(bun --version)"
      else
          echo "   Bun: Not installed"
      fi
      if command -v node &> /dev/null; then
          echo "   Node.js: $(node --version)"
      else
          echo "   Node.js: Not installed"
      fi
      echo ""
      echo "📞 Support: ${SCRIPT_AUTHOR}"
      echo "🌐 Documentation: ${SCRIPT_REPO}/blob/main/README.md"
      echo ""
      exit 0
  }

  # Function to show help information
  show_help() {
      echo "╔════════════════════════════════════════════════════════════╗"
      echo "║         Claudia WebKit Fix Installer - Help Guide         ║"
      echo "╚════════════════════════════════════════════════════════════╝"
      echo ""
      echo "USAGE:"
      echo "  ./install.sh [OPTIONS]"
      echo ""
      echo "OPTIONS:"
      echo "  --version, -v, version    Show version information and system details"
      echo "  --help, -h, help         Show this help message"
      echo "  --validate, validate     Validate script syntax and structure"
      echo ""
      echo "DESCRIPTION:"
      echo "  This script automatically installs and configures Claudia with WebKit"
      echo "  compatibility fixes for Manjaro Linux and other Arch-based distributions."
      echo ""
      echo "FEATURES:"
      echo "  • Detects and installs required system dependencies"
      echo "  • Downloads and installs Bun JavaScript runtime"
      echo "  • Clones or copies Claudia repository"
      echo "  • Creates WebKit-compatible launcher script"
      echo "  • Sets up desktop integration and shell aliases"
      echo "  • Provides comprehensive error handling"
      echo ""
      echo "INTERACTIVE PROMPTS:"
      echo "  • Installation directory (default: ./claudia)"
      echo "  • Repository source (official, custom URL, or local path)"
      echo ""
      echo "POST-INSTALLATION COMMANDS:"
      echo "  claudia-dev         Start development server"
      echo "  claudia-build       Build executable only"
      echo "  claudia-build-full  Build with all bundles"
      echo "  claudia-clean       Clean build artifacts"
      echo ""
      echo "EXAMPLES:"
      echo "  ./install.sh                  # Run interactive installation"
      echo "  ./install.sh --version        # Show version information"
      echo "  ./install.sh --help           # Show this help"
      echo ""
      echo "SUPPORT:"
      echo "  Repository: ${SCRIPT_REPO}"
      echo "  Email:      ${SCRIPT_AUTHOR}"
      echo "  Issues:     ${SCRIPT_REPO}/issues"
      echo ""
      exit 0
  }

  # Check for help and version flags before main execution
  if [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]] || [[ "$1" == "help" ]]; then
      show_help
  fi

  if [[ "$1" == "--version" ]] || [[ "$1" == "-v" ]] || [[ "$1" == "version" ]]; then
      show_version
  fi

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
      
      # Add bun to PATH for this session
      export BUN_INSTALL="$HOME/.bun"
      export PATH="$BUN_INSTALL/bin:$PATH"
      
      # Verify bun is now available
      if command -v bun &> /dev/null; then
          echo "✅ Bun installed successfully: $(bun --version)"
      else
          echo "⚠️  Bun installation completed but binary not found in PATH"
          echo "💡 You may need to restart your terminal or run: source ~/.bashrc"
          echo "💡 Continuing with npm as fallback..."
      fi
  else
      echo "✅ Bun already installed: $(bun --version)"
  fi

  # Check for required system packages
  echo "🔍 Checking system dependencies..."
  REQUIRED_PACKAGES=("webkit2gtk-4.1" "gtk3" "libayatana-appindicator" "rust" "nodejs" "npm")
  OPTIONAL_PACKAGES=("fuse2" "libfuse2" "appstream-glib")
  MISSING_PACKAGES=()
  MISSING_OPTIONAL=()

  for package in "${REQUIRED_PACKAGES[@]}"; do
      if ! pacman -Q "$package" &> /dev/null; then
          MISSING_PACKAGES+=("$package")
      else
          echo "✅ $package is already installed"
      fi
  done

  if [ ${#MISSING_PACKAGES[@]} -ne 0 ]; then
      echo "📦 Installing missing packages: ${MISSING_PACKAGES[*]}"
      if sudo pacman -S --needed "${MISSING_PACKAGES[@]}"; then
          echo "✅ System dependencies installed"
      else
          echo "❌ Failed to install some packages. Please check manually."
          echo "💡 Try: sudo pacman -S --needed ${MISSING_PACKAGES[*]}"
      fi
  else
      echo "✅ All required packages are already installed"
  fi
  
  # Check optional packages for AppImage bundling
  echo "🔍 Checking optional packages for AppImage bundling..."
  for package in "${OPTIONAL_PACKAGES[@]}"; do
      if ! pacman -Q "$package" &> /dev/null; then
          MISSING_OPTIONAL+=("$package")
      else
          echo "✅ $package is installed"
      fi
  done
  
  if [ ${#MISSING_OPTIONAL[@]} -ne 0 ]; then
      echo "⚠  Optional packages missing for AppImage bundling: ${MISSING_OPTIONAL[*]}"
      echo "💡 Install with: sudo pacman -S --needed ${MISSING_OPTIONAL[*]}"
      echo "💡 Or use 'claudia-build' instead of 'claudia-build-full' to skip AppImage creation"
  fi
  
  # Check for FUSE kernel module (required for AppImage execution)
  if ! lsmod | grep -q fuse && ! modinfo fuse &> /dev/null; then
      echo "⚠  FUSE kernel module not available - AppImage tools will use extract-and-run mode"
      echo "💡 This is normal on some systems and won't prevent AppImage bundling"
  else
      echo "✅ FUSE support detected"
  fi
  
  # Check for linuxdeploy (required for AppImage but not in pacman)
  LINUXDEPLOY_PATH=$(command -v linuxdeploy 2>/dev/null || echo "")
  if [ -z "$LINUXDEPLOY_PATH" ] || [ "$INSTALL_WRAPPER" = "1" ]; then
      if [ "$INSTALL_WRAPPER" = "1" ]; then
          echo "🔄 Force installing linuxdeploy wrapper (INSTALL_WRAPPER=1)"
      else
          echo "⚠  linuxdeploy not found (required for AppImage bundling)"
      fi
      echo "📦 Installing linuxdeploy automatically..."
      
      # Download and install linuxdeploy
      TEMP_DIR=$(mktemp -d)
      if wget -q -O "$TEMP_DIR/linuxdeploy-x86_64.AppImage" \
         "https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage"; then
          chmod +x "$TEMP_DIR/linuxdeploy-x86_64.AppImage"
          
          # Create a wrapper script that handles AppImage execution properly
          cat > "$TEMP_DIR/linuxdeploy-wrapper" << 'WRAPPER_EOF'
#!/bin/bash
# linuxdeploy wrapper for Manjaro Linux
# Handles AppImage execution with proper FUSE support
APPIMAGE_PATH="/usr/local/bin/linuxdeploy-x86_64.AppImage"

# Check if we can run the AppImage directly
if [ -n "$APPIMAGE_EXTRACT_AND_RUN" ] || ! mountpoint -q /tmp 2>/dev/null; then
    # Use extract-and-run method for systems without FUSE
    APPIMAGE_EXTRACT_AND_RUN=1 "$APPIMAGE_PATH" "$@"
else
    # Try normal execution first
    if ! "$APPIMAGE_PATH" "$@" 2>/dev/null; then
        # Fallback to extract-and-run
        echo "⚠  AppImage execution failed, using extract-and-run method..." >&2
        APPIMAGE_EXTRACT_AND_RUN=1 "$APPIMAGE_PATH" "$@"
    fi
fi
WRAPPER_EOF
          
          chmod +x "$TEMP_DIR/linuxdeploy-wrapper"
          
          # Install both the AppImage and wrapper
          if sudo mv "$TEMP_DIR/linuxdeploy-x86_64.AppImage" /usr/local/bin/linuxdeploy-x86_64.AppImage && \
             sudo mv "$TEMP_DIR/linuxdeploy-wrapper" /usr/local/bin/linuxdeploy; then
              echo "✅ linuxdeploy installed successfully with wrapper"
          else
              echo "❌ Failed to install linuxdeploy (permission issue)"
              echo "💡 Run manually:"
              echo "   sudo mv $TEMP_DIR/linuxdeploy-x86_64.AppImage /usr/local/bin/"
              echo "   sudo mv $TEMP_DIR/linuxdeploy-wrapper /usr/local/bin/linuxdeploy"
          fi
      else
          echo "❌ Failed to download linuxdeploy"
          echo "💡 Manual installation:"
          echo "   wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage"
          echo "   chmod +x linuxdeploy-x86_64.AppImage"
          echo "   sudo mv linuxdeploy-x86_64.AppImage /usr/local/bin/"
          echo "   # Create wrapper script as shown in install.sh"
      fi
      rm -rf "$TEMP_DIR"
      echo "💡 Alternative: Use 'claudia-build' to create deb/rpm packages without AppImage"
  else
      echo "✅ linuxdeploy found at: $LINUXDEPLOY_PATH"
      
      # Test if existing linuxdeploy works
      if ! "$LINUXDEPLOY_PATH" --version &> /dev/null; then
          echo "⚠  Existing linuxdeploy appears to be broken (likely AppImage execution issue)"
          echo "💡 Options:"
          echo "   1. Install our wrapper: export INSTALL_WRAPPER=1 && ./install.sh"
          echo "   2. Use 'claudia-build' to skip AppImage creation"
          echo "   3. Set environment variable: export APPIMAGE_EXTRACT_AND_RUN=1"
      else
          echo "✅ Existing linuxdeploy is working"
      fi
  fi

  # Ask user for Claudia installation directory
  read -p "📁 Enter Claudia installation directory [current directory]: " CLAUDIA_DIR
  CLAUDIA_DIR=${CLAUDIA_DIR:-$(pwd)}
  CLAUDIA_DIR=$(realpath "$CLAUDIA_DIR")

  # Clone or navigate to Claudia
  # Check if directory exists AND contains a valid Claudia project
  if [ ! -d "$CLAUDIA_DIR" ] || [ ! -f "$CLAUDIA_DIR/package.json" ] || [ ! -d "$CLAUDIA_DIR/src-tauri" ]; then
      if [ -d "$CLAUDIA_DIR" ]; then
          echo "📥 Directory exists but doesn't contain a valid Claudia project at $CLAUDIA_DIR"
      else
          echo "📥 Claudia not found at $CLAUDIA_DIR"
      fi
      echo "🔗 Repository options:"
      echo "  1. Official Claudia repository (recommended)"
      echo "  2. Custom repository URL"
      echo "  3. Local directory path"
      read -p "Choose option [1]: " REPO_CHOICE
      REPO_CHOICE=${REPO_CHOICE:-1}
      
      case $REPO_CHOICE in
          1)
              CLAUDIA_SOURCE="https://github.com/getAsterisk/claudia.git"
              echo "📥 Cloning official Claudia repository..."
              ;;
          2)
              read -p "🔗 Enter custom repository URL: " CLAUDIA_SOURCE
              echo "📥 Cloning custom repository..."
              ;;
          3)
              read -p "📁 Enter local directory path: " CLAUDIA_SOURCE
              echo "📁 Copying from local directory..."
              ;;
          *)
              echo "❌ Invalid choice"
              exit 1
              ;;
      esac

      if [[ "$CLAUDIA_SOURCE" == http* ]] || [[ "$CLAUDIA_SOURCE" == git* ]]; then
          # If directory exists but is not a valid Claudia project, clone into it
          if [ -d "$CLAUDIA_DIR" ] && [ ! -f "$CLAUDIA_DIR/package.json" ]; then
              # Directory exists but is not a Claudia project - clone into a temp dir then move contents
              TEMP_DIR=$(mktemp -d)
              if git clone "$CLAUDIA_SOURCE" "$TEMP_DIR/claudia"; then
                  # Move contents from temp to target directory
                  cp -r "$TEMP_DIR/claudia"/* "$CLAUDIA_DIR/"
                  rm -rf "$TEMP_DIR"
                  echo "✅ Repository cloned successfully into existing directory"
              else
                  echo "❌ Failed to clone repository"
                  exit 1
              fi
          else
              # Normal clone to new directory
              if git clone "$CLAUDIA_SOURCE" "$CLAUDIA_DIR"; then
                  echo "✅ Repository cloned successfully"
              else
                  echo "❌ Failed to clone repository"
                  exit 1
              fi
          fi
      elif [ -d "$CLAUDIA_SOURCE" ]; then
          if cp -r "$CLAUDIA_SOURCE" "$CLAUDIA_DIR"; then
              echo "✅ Directory copied successfully"
          else
              echo "❌ Failed to copy directory"
              exit 1
          fi
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
  
  # Check which package manager to use
  if command -v bun &> /dev/null; then
      echo "🔧 Using Bun to install dependencies..."
      if bun install; then
          echo "✅ Dependencies installed successfully with Bun"
      else
          echo "⚠️  Bun install failed, trying npm as fallback..."
          if command -v npm &> /dev/null; then
              npm install
              echo "✅ Dependencies installed with npm"
          else
              echo "❌ Both bun and npm failed. Please install dependencies manually."
              exit 1
          fi
      fi
  elif command -v npm &> /dev/null; then
      echo "🔧 Bun not available, using npm to install dependencies..."
      if npm install; then
          echo "✅ Dependencies installed successfully with npm"
      else
          echo "❌ npm install failed. Please install dependencies manually."
          exit 1
      fi
  else
      echo "❌ No JavaScript package manager found (neither bun nor npm)."
      echo "💡 Please install either bun or npm and try again."
      exit 1
  fi

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

  # Detect available package manager
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
          echo ""
          echo "✅ Build complete! Package files are in: ./src-tauri/target/release/bundle/"
          echo ""
          echo "📦 To install the .deb package:"
          echo "   sudo dpkg -i ./src-tauri/target/release/bundle/deb/*.deb"
          echo ""
          echo "🚀 To run the executable directly, use:"
          echo "   ./launch-production.sh"
          echo ""
          echo "⚠️  DO NOT run the executable directly - it needs WebKit environment variables!"
          ;;
      "build-exe"|"executable")
          echo "🏗  Building executable only..."
          $PKG_MANAGER run tauri build --no-bundle
          echo ""
          echo "✅ Build complete! The executable is at: ./src-tauri/target/release/claudia"
          echo ""
          echo "🚀 To run the production build, use:"
          echo "   ./launch-production.sh"
          echo ""
          echo "⚠️  DO NOT run the executable directly - it needs WebKit environment variables!"
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
          
          # Ensure APPIMAGE_EXTRACT_AND_RUN is set for Tauri's execution
          echo "🔧 Configuring AppImage environment for Tauri..."
          export APPIMAGE_EXTRACT_AND_RUN=1
          
          if [ -f "src-tauri/tauri.conf.appimage.json" ]; then
              echo "🚀 Starting AppImage build with configuration..."
              $PKG_MANAGER run tauri build --config src-tauri/tauri.conf.appimage.json
          else
              echo "🚀 Starting AppImage build with default configuration..."
              $PKG_MANAGER run tauri build
          fi
          echo ""
          echo "✅ Build complete! Output files are in: ./src-tauri/target/release/"
          echo ""
          echo "🚀 To run the production executable, use:"
          echo "   ./launch-production.sh"
          echo ""
          echo "📦 AppImage files (if built) are in: ./src-tauri/target/release/bundle/appimage/"
          echo "⚠️  DO NOT run the executable directly - it needs WebKit environment variables!"
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
LAUNCHER_EOF

  # Set executable permissions with explicit error checking
  echo "🔧 Setting executable permissions..."
  if chmod +x claudia-manjaro.sh 2>/dev/null; then
      echo "✅ Launch script created and made executable: claudia-manjaro.sh"
  else
      echo "❌ Failed to make launch script executable with chmod"
      echo "🔍 Attempting alternative permission setting..."
      # Try with full path
      chmod 755 claudia-manjaro.sh 2>/dev/null
      # Verify it worked
      if [ -x claudia-manjaro.sh ]; then
          echo "✅ Permissions set successfully with chmod 755"
      else
          echo "❌ Both chmod methods failed"
          echo "💡 Current directory: $(pwd)"
          echo "💡 File exists: $(ls -la claudia-manjaro.sh 2>/dev/null || echo 'NOT FOUND')"
          echo "💡 Manually run: chmod +x claudia-manjaro.sh"
          exit 1
      fi
  fi

  # Create production launcher script
  echo "🔧 Creating production launcher script..."
  cat > launch-production.sh << 'PROD_LAUNCHER_EOF'
#!/bin/bash

# Claudia Production Launcher Script
# This script sets the required WebKit environment variables to prevent black screen issues

# Critical WebKit fixes for Manjaro/Arch Linux
export WEBKIT_DISABLE_COMPOSITING_MODE=1
export PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1
export WEBKIT_DISABLE_DMABUF_RENDERER=1
export WEBKIT_DISABLE_SANDBOX_THIS_IS_DANGEROUS=1
export APPIMAGE_EXTRACT_AND_RUN=1

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

echo "Launching Claudia from: $CLAUDIA_EXEC"
echo "WebKit environment variables set:"
echo "  WEBKIT_DISABLE_COMPOSITING_MODE=1"
echo "  WEBKIT_DISABLE_DMABUF_RENDERER=1"
echo "  WEBKIT_DISABLE_SANDBOX_THIS_IS_DANGEROUS=1"

# Launch Claudia with all fixes applied
exec "$CLAUDIA_EXEC" "$@"
PROD_LAUNCHER_EOF

  chmod +x launch-production.sh
  echo "✅ Production launcher created: launch-production.sh"
  
  # Create AppImage configuration for build-full option
  echo "🔧 Creating AppImage configuration..."
  cat > src-tauri/tauri.conf.appimage.json << 'APPIMAGE_EOF'
{
  "$schema": "https://schema.tauri.app/config/2",
  "productName": "Claudia",
  "version": "0.1.0",
  "identifier": "claudia.asterisk.so",
  "build": {
    "beforeDevCommand": "bun run dev",
    "devUrl": "http://127.0.0.1:1420",
    "beforeBuildCommand": "bun run build",
    "frontendDist": "../dist"
  },
  "app": {
    "windows": [
      {
        "title": "Claudia",
        "width": 1200,
        "height": 800,
        "visible": true,
        "center": true,
        "resizable": true,
        "decorations": true,
        "url": "http://127.0.0.1:1420"
      }
    ],
    "security": {
      "csp": null,
      "assetProtocol": {
        "enable": true,
        "scope": [
          "**"
        ]
      }
    }
  },
  "plugins": {
    "fs": {
      "scope": [
        "$HOME/**"
      ],
      "allow": [
        "readFile",
        "writeFile",
        "readDir",
        "copyFile",
        "createDir",
        "removeDir",
        "removeFile",
        "renameFile",
        "exists"
      ]
    },
    "shell": {
      "open": true
    }
  },
  "bundle": {
    "active": true,
    "targets": "all",
    "icon": [
      "icons/32x32.png",
      "icons/128x128.png",
      "icons/128x128@2x.png",
      "icons/icon.icns",
      "icons/icon.png"
    ],
    "externalBin": [
      "binaries/claude-code"
    ]
  }
}
APPIMAGE_EOF
  echo "✅ AppImage configuration created"
  
  # Update main Tauri configuration to disable AppImage by default
  echo "🔧 Updating main Tauri configuration..."
  if [ -f "src-tauri/tauri.conf.json" ]; then
      # Create backup
      cp src-tauri/tauri.conf.json src-tauri/tauri.conf.json.backup
      
      # Update the configuration to exclude AppImage from default builds
      sed -i 's/"targets": "all"/"targets": ["deb", "rpm"]/' src-tauri/tauri.conf.json
      echo "✅ Main Tauri configuration updated (AppImage disabled by default)"
  else
      echo "⚠️  tauri.conf.json not found, skipping configuration update"
  fi

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
          echo "alias claudia-build-exe='cd $CLAUDIA_DIR && ./claudia-manjaro.sh build-exe'" >> "$SHELL_RC"
          echo "alias claudia-build-full='cd $CLAUDIA_DIR && ./claudia-manjaro.sh build-full'" >> "$SHELL_RC"
          echo "alias claudia-clean='cd $CLAUDIA_DIR && ./claudia-manjaro.sh clean'" >> "$SHELL_RC"
          echo "✅ Added aliases to $SHELL_RC"
          echo "💡 Restart your terminal or run: source $SHELL_RC"
      else
          echo "⚠  Aliases already exist in $SHELL_RC"
      fi
  fi

  # Create uninstall script
  cat > uninstall-claudia-manjaro.sh << 'UNINSTALL_EOF'
#!/bin/bash
# Uninstaller for Claudia Manjaro fix by Jamie Saker <jamie.saker@macawi.ai>

echo "🗑  Uninstalling Claudia Manjaro compatibility setup..."
echo "Fix originally by: Jamie Saker <jamie.saker@macawi.ai> (Macawi)"
rm -f ~/.local/share/applications/claudia.desktop
sed -i '/# Claudia Manjaro aliases (Jamie Saker\/Macawi)/,+3d' "$SHELL_RC" 2>/dev/null || true
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
  echo "   claudia-dev         # Start development server"
  echo "   claudia-build       # Build with deb and rpm packages"
  echo "   claudia-build-exe   # Build executable only (no bundles)"
  echo "   claudia-build-full  # Build with AppImage (requires dependencies)"
  echo "   claudia-clean       # Clean build artifacts"
  echo ""
  echo "ℹ️  Other useful commands:"
  echo "   ./claudia-manjaro.sh version  # Show launcher version info"
  echo "   ./claudia-manjaro.sh help     # Show launcher help"
  echo "   ./install.sh --version        # Show installer version info"
  echo ""
  echo "🖥  Desktop entry created - search for 'Claudia' in your application menu"
  echo ""
  echo "⚠  Important: Always use these scripts instead of 'bun run tauri dev' directly"
  echo "💡 The scripts automatically apply WebKit compatibility fixes for Manjaro"
  echo ""
  echo "🗑  To uninstall: ./uninstall-claudia-manjaro.sh"
  echo ""
  echo "📧 Support: jamie.saker@macawi.ai"
  echo ""
  
  # Final validation
  echo "🔍 Validating installation..."
  if [ -f "$CLAUDIA_DIR/claudia-manjaro.sh" ]; then
      if [ -x "$CLAUDIA_DIR/claudia-manjaro.sh" ]; then
          echo "✅ Launch script is executable"
      else
          echo "❌ Launch script exists but is not executable"
          echo "🔍 Current permissions: $(ls -la "$CLAUDIA_DIR/claudia-manjaro.sh")"
          echo "💡 Fixing permissions..."
          chmod +x "$CLAUDIA_DIR/claudia-manjaro.sh"
          if [ -x "$CLAUDIA_DIR/claudia-manjaro.sh" ]; then
              echo "✅ Permissions fixed successfully"
          else
              echo "❌ Failed to fix permissions"
              exit 1
          fi
      fi
  else
      echo "❌ Launch script file not found at: $CLAUDIA_DIR/claudia-manjaro.sh"
      exit 1
  fi
  
  if command -v bun &> /dev/null; then
      echo "✅ Bun is accessible: $(bun --version)"
  else
      echo "❌ Bun installation validation failed"
      exit 1
  fi
  
  echo "✅ Installation validation completed successfully"
  echo ""
  echo "📋 Troubleshooting Tips:"
  echo "• If AppImage bundling fails, use 'claudia-build' instead of 'claudia-build-full'"
  echo "• If you get WebKit errors, the launcher script applies the necessary fixes"
  echo "• For permission issues, ensure the script is executable: chmod +x claudia-manjaro.sh"
  echo "• For missing dependencies, check the output above and install manually with pacman"
  echo "• If Bun fails, npm can be used as a fallback for dependency installation"
echo "• Report issues at: https://github.com/macawi-ai/claudia-manjaro-fix/issues"

echo ""
echo "🎯 INSTALLATION COMPLETED SUCCESSFULLY!"
echo "========================================"
echo ""
echo "📋 Available Build Commands:"
echo "   ./claudia-manjaro.sh dev         # Start development server"
echo "   ./claudia-manjaro.sh build       # Build with deb and rpm packages"
echo "   ./claudia-manjaro.sh build-exe   # Build executable only (no bundles)"
echo "   ./claudia-manjaro.sh build-full  # Build with AppImage (requires dependencies)"
echo "   ./claudia-manjaro.sh clean       # Clean build artifacts"
echo ""
echo "💡 Quick Start:"
echo "   cd $CLAUDIA_DIR && ./claudia-manjaro.sh dev"
echo ""
echo "✅ Ready to build Claudia with Manjaro compatibility fixes!"

# Final permission fix as backup
echo "🔧 Final permission check..."
chmod +x "$CLAUDIA_DIR/claudia-manjaro.sh" 2>/dev/null
if [ -x "$CLAUDIA_DIR/claudia-manjaro.sh" ]; then
    echo "✅ Launch script is executable and ready to use"
else
    echo "⚠️  Permission issue detected - manually run: chmod +x claudia-manjaro.sh"
fi

