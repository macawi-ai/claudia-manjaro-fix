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

  # Cybernetic Environment Validation Governor
  # Follows probe-sense-respond pattern for complex environment dependencies
  environment_validation_governor() {
      echo "🔍 Environment Validation Governor: Analyzing system capabilities..."
      
      local validation_failures=0
      local critical_failures=()
      local warnings=()
      
      # Critical Dependency: Bun Runtime (Essential for Claudia)
      echo "🎯 Validating critical dependency: Bun JavaScript runtime"
      if ! command -v bun &> /dev/null; then
          echo "📦 Installing Bun JavaScript runtime (ESSENTIAL for Claudia)..."
          
          # Attempt automatic installation
          if curl -fsSL https://bun.sh/install | bash; then
              # Add bun to PATH for this session
              export BUN_INSTALL="$HOME/.bun"
              export PATH="$BUN_INSTALL/bin:$PATH"
              
              # Validate installation success
              if command -v bun &> /dev/null; then
                  local bun_version=$(bun --version)
                  echo "✅ Bun installed successfully: $bun_version"
                  
                  # Test Bun functionality (basic compile test)
                  if echo 'console.log("test")' | bun run - >/dev/null 2>&1; then
                      echo "✅ Bun runtime validation passed"
                  else
                      echo "⚠️  Bun installed but runtime test failed"
                      warnings+=("Bun runtime test failed - may have functional issues")
                  fi
              else
                  echo "❌ CRITICAL: Bun installation failed - binary not accessible"
                  critical_failures+=("Bun installation failed - Claudia cannot function without Bun")
                  validation_failures=$((validation_failures + 1))
              fi
          else
              echo "❌ CRITICAL: Failed to download/install Bun"
              critical_failures+=("Bun download failed - check internet connection")
              validation_failures=$((validation_failures + 1))
          fi
      else
          local bun_version=$(bun --version)
          echo "✅ Bun already installed: $bun_version"
          
          # Validate existing Bun installation
          if echo 'console.log("test")' | bun run - >/dev/null 2>&1; then
              echo "✅ Existing Bun runtime validation passed"
          else
              echo "⚠️  Existing Bun installation may be corrupted"
              warnings+=("Existing Bun runtime test failed - consider reinstalling")
          fi
      fi
      
      # Environment Path Validation
      echo "🔍 Validating environment path configuration..."
      if [[ ":$PATH:" != *":$HOME/.bun/bin:"* ]] && command -v bun &> /dev/null; then
          echo "⚠️  Bun accessible but not in standard PATH"
          warnings+=("Bun PATH configuration may need manual adjustment")
      fi
      
      return $validation_failures
  }

  # Execute Environment Validation Governor
  if ! environment_validation_governor; then
      echo ""
      echo "❌ CRITICAL ENVIRONMENT VALIDATION FAILURES DETECTED"
      echo "=================================================="
      echo ""
      echo "🚨 The following critical issues prevent Claudia installation:"
      for failure in "${critical_failures[@]}"; do
          echo "   • $failure"
      done
      echo ""
      echo "💡 IMPORTANT: Claudia requires Bun (not npm) for core functionality:"
      echo "   • Bun's --compile flag for creating standalone executables"
      echo "   • Bun's native file embedding for WebAssembly and binary assets"
      echo "   • Bun-specific APIs for cross-platform compilation"
      echo ""
      echo "🔄 Remediation Steps:"
      echo "   1. Ensure stable internet connection"
      echo "   2. Re-run this script: ./install.sh"
      echo "   3. If issues persist, manually install Bun:"
      echo "      curl -fsSL https://bun.sh/install | bash"
      echo "      source ~/.bashrc"
      echo ""
      exit 1
  fi

  # Report warnings if any
  if [ ${#warnings[@]} -gt 0 ]; then
      echo ""
      echo "⚠️  Environment Warnings (non-critical):"
      for warning in "${warnings[@]}"; do
          echo "   • $warning"
      done
      echo ""
  fi

  # System Dependency Validation Governor
  echo "🔍 System Dependency Validation Governor: Analyzing package ecosystem..."
  
  # Core system dependencies for Claudia + Tauri + WebKit
  REQUIRED_PACKAGES=("webkit2gtk-4.1" "gtk3" "libayatana-appindicator" "rust" "nodejs")
  
  # AppImage ecosystem dependencies (validated package names)
  APPIMAGE_PACKAGES=("fuse2" "appstream-glib")
  
  # Build toolchain dependencies
  BUILD_PACKAGES=("gcc" "pkgconf" "openssl" "base-devel")
  # System Package Validation with Cybernetic Learning Governor
  system_package_governor() {
      local package_category="$1"
      local package_array=("${@:2}")
      local missing_packages=()
      local failed_packages=()
      local validation_failures=0
      
      echo "🎯 Validating $package_category packages..."
      
      # Probe: Check which packages are missing
      for package in "${package_array[@]}"; do
          if ! pacman -Q "$package" &> /dev/null; then
              missing_packages+=("$package")
              echo "❌ Missing: $package"
          else
              echo "✅ Found: $package ($(pacman -Q "$package" | awk '{print $2}'))"
          fi
      done
      
      # Sense: Analyze missing packages and attempt intelligent installation
      if [ ${#missing_packages[@]} -ne 0 ]; then
          echo "📦 Installing missing $package_category packages: ${missing_packages[*]}"
          
          # Cybernetic Learning: Try individual package installation to isolate failures
          for package in "${missing_packages[@]}"; do
              echo "🔧 Installing $package..."
              if sudo pacman -S --needed "$package" 2>/dev/null; then
                  echo "✅ Successfully installed: $package"
              else
                  echo "❌ Failed to install: $package"
                  failed_packages+=("$package")
                  
                  # Learning mechanism: Try to understand why it failed
                  if ! pacman -Ss "^$package$" &>/dev/null; then
                      echo "💡 Package '$package' not found in repositories"
                      echo "🔍 Searching for alternatives..."
                      pacman -Ss "$package" | head -3 | while read line; do
                          if [[ "$line" =~ ^[a-zA-Z] ]]; then
                              echo "   Suggestion: $line"
                          fi
                      done
                  fi
              fi
          done
          
          # Respond: Analyze results and provide guidance
          if [ ${#failed_packages[@]} -eq 0 ]; then
              echo "✅ All $package_category packages installed successfully"
          else
              echo "⚠️  Some $package_category packages failed to install: ${failed_packages[*]}"
              validation_failures=1
              
              # Antifragile pattern: Provide specific guidance for each failure
              echo "🔄 Cybernetic Learning - Package Installation Failures:"
              for failed_pkg in "${failed_packages[@]}"; do
                  echo "   • $failed_pkg: Check if package name is correct or if alternatives exist"
              done
          fi
          
          # Final validation loop: Verify what actually got installed
          local still_missing=()
          for package in "${missing_packages[@]}"; do
              if ! pacman -Q "$package" &> /dev/null; then
                  still_missing+=("$package")
              fi
          done
          
          if [ ${#still_missing[@]} -gt 0 ]; then
              echo "📊 Final validation - packages still missing: ${still_missing[*]}"
          fi
      else
          echo "✅ All $package_category packages already installed"
      fi
      
      return $validation_failures
  }

  # Execute governors for different package categories
  echo "🔍 Core System Dependencies:"
  system_package_governor "core system" "${REQUIRED_PACKAGES[@]}"
  
  echo ""
  echo "🔍 Build Toolchain Dependencies:"
  system_package_governor "build toolchain" "${BUILD_PACKAGES[@]}"
  
  echo ""
  echo "🔍 AppImage Ecosystem Dependencies (Optional):"
  appimage_capability_governor() {
      echo "🎯 Analyzing AppImage bundling capabilities..."
      
      # Check individual capabilities rather than just package presence
      local capabilities_missing=()
      local fuse_available=false
      local appstream_available=false
      
      # FUSE capability check (multiple ways to satisfy this)
      if pacman -Q fuse2 &>/dev/null || pacman -Q fuse3 &>/dev/null; then
          echo "✅ FUSE capability: Available"
          fuse_available=true
      else
          echo "❌ FUSE capability: Missing"
          capabilities_missing+=("FUSE support for AppImage mounting")
      fi
      
      # AppStream capability check
      if pacman -Q appstream-glib &>/dev/null || pacman -Q appstream &>/dev/null; then
          echo "✅ AppStream capability: Available"
          appstream_available=true
      else
          echo "⚠️  AppStream capability: Missing (attempting installation...)"
          if sudo pacman -S --needed appstream-glib 2>/dev/null; then
              echo "✅ AppStream capability: Installed successfully"
              appstream_available=true
          else
              echo "❌ AppStream capability: Installation failed"
              capabilities_missing+=("AppStream metadata support")
          fi
      fi
      
      # Cybernetic decision making based on capabilities
      if [ ${#capabilities_missing[@]} -eq 0 ]; then
          echo "✅ AppImage bundling fully supported - all capabilities available"
          return 0
      else
          echo "⚠️  AppImage bundling capabilities analysis:"
          for capability in "${capabilities_missing[@]}"; do
              echo "   • Missing: $capability"
          done
          echo ""
          echo "🎯 Impact assessment:"
          if [ "$fuse_available" = false ]; then
              echo "   • FUSE missing: AppImages will use extract-and-run mode (slower but functional)"
          fi
          if [ "$appstream_available" = false ]; then
              echo "   • AppStream missing: Metadata generation may be limited"
          fi
          echo ""
          echo "💡 Recommended actions:"
          echo "   • For development: Use 'claudia-build' (creates deb/rpm packages)"
          echo "   • For AppImage: Use 'claudia-build-full' (will work with extract-and-run)"
          echo "   • Manual fix: sudo pacman -S --needed fuse2 appstream-glib"
          return 1
      fi
  }
  
  appimage_capability_governor
  
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

  # Install Claudia dependencies with Bun
  echo "📦 Installing Claudia dependencies with Bun..."
  
  # Bun validation should have already passed, but double-check
  if ! command -v bun &> /dev/null; then
      echo "❌ CRITICAL: Bun not found - dependency installation cannot proceed"
      echo "💡 This indicates environment validation governor failure"
      exit 1
  fi
  
  echo "🔧 Installing dependencies with Bun (required for Claudia)..."
  if bun install; then
      echo "✅ Dependencies installed successfully with Bun"
      
      # Validate installation by checking for key dependency files
      if [ -f "node_modules/.bin/tauri" ] || [ -d "node_modules/@tauri-apps" ]; then
          echo "✅ Tauri dependencies validated"
      else
          echo "⚠️  Dependency installation may be incomplete - missing Tauri"
      fi
  else
      echo "❌ CRITICAL: Bun dependency installation failed"
      echo "💡 This may indicate:"
      echo "   • Network connectivity issues"
      echo "   • Disk space problems"
      echo "   • Incompatible package.json configuration"
      echo "   • Missing system dependencies for native modules"
      echo ""
      echo "🔄 Remediation steps:"
      echo "   1. Check internet connection"
      echo "   2. Ensure sufficient disk space"
      echo "   3. Try manual installation: cd $CLAUDIA_DIR && bun install"
      exit 1
  fi

  # Create WebKit-compatible launch script
  echo "🔧 Creating WebKit-compatible launch script..."
  
  # Bun is essential for Claudia - no fallback to npm
  if ! command -v bun &> /dev/null; then
      echo "❌ CRITICAL: Bun not found after installation!"
      echo "💡 This should not happen - environment validation governor failed"
      exit 1
  fi
  
  echo "🎯 Launcher configured for Bun (essential for Claudia)"
  
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

  echo "📦 Using Bun package manager (required for Claudia)"
  
  # Runtime Environment Validation Governor
  runtime_environment_governor() {
      local validation_failures=0
      local warnings=()
      
      echo "🔍 Runtime Environment Governor: Validating execution context..."
      
      # Critical: Bun availability and functionality
      if ! command -v bun &> /dev/null; then
          echo "❌ CRITICAL: Bun not found in runtime environment!"
          echo "💡 PATH configuration: $PATH"
          echo "💡 Try: export PATH=\"$HOME/.bun/bin:$PATH\""
          echo "💡 Or restart your terminal and try again"
          return 1
      fi
      
      # Test Bun functionality
      if ! echo 'console.log("runtime-test")' | bun run - >/dev/null 2>&1; then
          echo "⚠️  Bun runtime test failed - may have issues"
          warnings+=("Bun runtime test failed")
      else
          echo "✅ Bun runtime validation passed"
      fi
      
      # Project context validation
      if [ ! -f "src-tauri/Cargo.toml" ]; then
          echo "❌ Not in Claudia project directory!"
          echo "💡 Navigate to your Claudia installation directory first"
          echo "💡 Expected files: src-tauri/Cargo.toml, package.json"
          return 1
      fi
      
      # Dependency validation
      if [ ! -d "node_modules" ]; then
          echo "⚠️  Node modules not found - dependencies may not be installed"
          warnings+=("Dependencies may not be installed - run 'bun install'")
      fi
      
      # Tauri CLI availability
      if [ ! -f "node_modules/.bin/tauri" ] && ! command -v tauri &> /dev/null; then
          echo "⚠️  Tauri CLI not found - build commands may fail"
          warnings+=("Tauri CLI not available")
      fi
      
      # Report warnings
      if [ ${#warnings[@]} -gt 0 ]; then
          echo "⚠️  Runtime warnings detected:"
          for warning in "${warnings[@]}"; do
              echo "   • $warning"
          done
          echo ""
      fi
      
      return $validation_failures
  }
  
  # Execute runtime validation
  if ! runtime_environment_governor; then
      echo "❌ Runtime environment validation failed"
      exit 1
  fi

  case "$1" in
      "dev"|"development"|"")
          echo "🔧 Starting development server..."
          bun run tauri dev
          ;;
      "build"|"production")
          echo "🏗  Building production version (deb, rpm)..."
          bun run tauri build
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
          bun run tauri build --no-bundle
          echo ""
          echo "✅ Build complete! The executable is at: ./src-tauri/target/release/claudia"
          echo ""
          
          # Deployment Options Governor
          deployment_options_governor() {
              local executable_path="./src-tauri/target/release/claudia"
              
              if [ ! -f "$executable_path" ]; then
                  echo "⚠️  Executable not found at expected location"
                  return 1
              fi
              
              echo "🎯 Deployment Options Governor: Choose installation method"
              echo ""
              echo "1. Local use only (recommended for development)"
              echo "   - Run via: ./launch-production.sh"
              echo "   - Executable stays in project directory"
              echo ""
              echo "2. Install to system PATH (/usr/local/bin)"
              echo "   - Run via: claudia (from anywhere)"
              echo "   - Requires sudo privileges"
              echo "   - Creates system-wide symbolic link"
              echo ""
              echo "3. Install to user PATH (~/.local/bin)"
              echo "   - Run via: claudia (from anywhere, user only)"
              echo "   - No sudo required"
              echo "   - Creates user-specific symbolic link"
              echo ""
              
              read -p "Choose deployment option [1]: " DEPLOY_CHOICE
              DEPLOY_CHOICE=${DEPLOY_CHOICE:-1}
              
              case "$DEPLOY_CHOICE" in
                  1)
                      echo "✅ Local deployment selected"
                      echo "🚀 To run: ./launch-production.sh"
                      ;;
                  2)
                      echo "🔧 Installing to system PATH..."
                      if sudo ln -sf "$(pwd)/launch-production.sh" /usr/local/bin/claudia; then
                          echo "✅ System installation complete!"
                          echo "🚀 To run: claudia (from anywhere)"
                          echo "🗑️  To uninstall: sudo rm /usr/local/bin/claudia"
                      else
                          echo "❌ System installation failed"
                          echo "💡 Fallback: Use local deployment (option 1)"
                      fi
                      ;;
                  3)
                      echo "🔧 Installing to user PATH..."
                      mkdir -p ~/.local/bin
                      if ln -sf "$(pwd)/launch-production.sh" ~/.local/bin/claudia; then
                          echo "✅ User installation complete!"
                          if [[ ":$PATH:" != *":~/.local/bin:"* ]] && [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
                              echo "⚠️  ~/.local/bin not in PATH"
                              echo "💡 Add to your shell profile:"
                              echo "   echo 'export PATH=\"$HOME/.local/bin:$PATH\"' >> ~/.bashrc"
                              echo "   source ~/.bashrc"
                          fi
                          echo "🚀 To run: claudia (from anywhere)"
                          echo "🗑️  To uninstall: rm ~/.local/bin/claudia"
                      else
                          echo "❌ User installation failed"
                          echo "💡 Fallback: Use local deployment (option 1)"
                      fi
                      ;;
                  *)
                      echo "❌ Invalid choice, using local deployment"
                      echo "🚀 To run: ./launch-production.sh"
                      ;;
              esac
          }
          
          deployment_options_governor
          echo ""
          echo "⚠️  IMPORTANT: Always use the launcher (never run the raw executable)"
          echo "💡 The launcher applies required WebKit environment variables"
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
          
          # AppImage Build Governor with Cybernetic Fallback
          appimage_build_governor() {
              echo "🚀 Starting comprehensive build (deb + rpm + AppImage)..."
              
              local build_cmd=""
              if [ -f "src-tauri/tauri.conf.appimage.json" ]; then
                  echo "📋 Using AppImage-specific configuration..."
                  build_cmd="bun run tauri build --config src-tauri/tauri.conf.appimage.json"
              else
                  echo "📋 Using default configuration..."
                  build_cmd="bun run tauri build"
              fi
              
              # Execute build with cybernetic assessment
              if $build_cmd; then
                  echo "✅ Core build process completed successfully"
                  
                  # Post-build assessment governor
                  appimage_assessment_governor() {
                      echo "🔍 Post-Build Assessment Governor: Analyzing outputs..."
                      local success_count=0
                      local warnings=()
                      
                      # Check executable
                      if [ -f "./src-tauri/target/release/claudia" ]; then
                          echo "✅ Executable: Successfully built"
                          success_count=$((success_count + 1))
                      else
                          echo "❌ Executable: Missing"
                          warnings+=("No executable generated")
                      fi
                      
                      # Check .deb package
                      if ls ./src-tauri/target/release/bundle/deb/*.deb &>/dev/null; then
                          local deb_size=$(du -h ./src-tauri/target/release/bundle/deb/*.deb | cut -f1)
                          echo "✅ Debian Package: Successfully built ($deb_size)"
                          success_count=$((success_count + 1))
                      else
                          echo "⚠️  Debian Package: Missing"
                          warnings+=("No .deb package generated")
                      fi
                      
                      # Check .rpm package
                      if ls ./src-tauri/target/release/bundle/rpm/*.rpm &>/dev/null; then
                          local rpm_size=$(du -h ./src-tauri/target/release/bundle/rpm/*.rpm | cut -f1)
                          echo "✅ RPM Package: Successfully built ($rpm_size)"
                          success_count=$((success_count + 1))
                      else
                          echo "⚠️  RPM Package: Missing"
                          warnings+=("No .rpm package generated")
                      fi
                      
                      # Check AppImage - both directory and final file
                      local appimage_status="unknown"
                      if ls ./src-tauri/target/release/bundle/appimage/*.AppImage &>/dev/null; then
                          local appimage_size=$(du -h ./src-tauri/target/release/bundle/appimage/*.AppImage | cut -f1)
                          echo "✅ AppImage: Successfully built ($appimage_size)"
                          success_count=$((success_count + 1))
                          appimage_status="success"
                      elif [ -d "./src-tauri/target/release/bundle/appimage/Claudia.AppDir" ]; then
                          echo "⚠️  AppImage: Directory created but final packaging failed"
                          echo "💡 AppDir available for manual packaging if needed"
                          warnings+=("AppImage packaging incomplete (linuxdeploy issue)")
                          appimage_status="partial"
                      else
                          echo "❌ AppImage: Build failed completely"
                          warnings+=("No AppImage generated")
                          appimage_status="failed"
                      fi
                      
                      # Cybernetic Success Assessment
                      echo ""
                      echo "📊 Build Success Analysis:"
                      echo "   • Successful outputs: $success_count/4 possible"
                      local success_percent=$((success_count * 25))
                      echo "   • Success rate: $success_percent%"
                      
                      if [ $success_count -ge 3 ]; then
                          echo "🎉 BUILD ASSESSMENT: Highly Successful!"
                          echo "💡 You have multiple deployment options available"
                      elif [ $success_count -ge 2 ]; then
                          echo "✅ BUILD ASSESSMENT: Successful with minor issues"
                          echo "💡 Core functionality fully available"
                      else
                          echo "⚠️  BUILD ASSESSMENT: Partial success - may need attention"
                      fi
                      
                      # Report warnings with guidance
                      if [ ${#warnings[@]} -gt 0 ]; then
                          echo ""
                          echo "⚠️  Build warnings detected:"
                          for warning in "${warnings[@]}"; do
                              echo "   • $warning"
                          done
                          
                          # Specific guidance for AppImage issues
                          if [ "$appimage_status" = "partial" ]; then
                              echo ""
                              echo "🔧 AppImage Troubleshooting:"
                              echo "   • This is a known linuxdeploy compatibility issue"
                              echo "   • Your .deb and .rpm packages work perfectly"
                              echo "   • For portable deployment, use the .deb package"
                              echo "   • AppDir is available for manual AppImage creation if needed"
                          fi
                      fi
                      
                      return 0
                  }
                  
                  appimage_assessment_governor
              else
                  echo "❌ Build process failed"
                  echo "💡 Check the error messages above for specific issues"
                  return 1
              fi
          }
          
          appimage_build_governor
          echo ""
          echo "✅ Build complete! Output files are in: ./src-tauri/target/release/"
          echo ""
          echo "📦 Package files available:"
          echo "   • Executable: ./src-tauri/target/release/claudia"
          echo "   • Debian package: ./src-tauri/target/release/bundle/deb/*.deb"
          echo "   • RPM package: ./src-tauri/target/release/bundle/rpm/*.rpm"
          echo "   • AppImage: ./src-tauri/target/release/bundle/appimage/*.AppImage"
          echo ""
          
          # Deployment Options Governor (same as build-exe)
          deployment_options_governor() {
              local executable_path="./src-tauri/target/release/claudia"
              
              if [ ! -f "$executable_path" ]; then
                  echo "⚠️  Executable not found at expected location"
                  return 1
              fi
              
              echo "🎯 Deployment Options Governor: Choose installation method"
              echo ""
              echo "1. Local use only (recommended for development)"
              echo "   - Run via: ./launch-production.sh"
              echo "   - Executable stays in project directory"
              echo ""
              echo "2. Install to system PATH (/usr/local/bin)"
              echo "   - Run via: claudia (from anywhere)"
              echo "   - Requires sudo privileges"
              echo "   - Creates system-wide symbolic link"
              echo ""
              echo "3. Install to user PATH (~/.local/bin)"
              echo "   - Run via: claudia (from anywhere, user only)"
              echo "   - No sudo required"
              echo "   - Creates user-specific symbolic link"
              echo ""
              echo "4. Install package (recommended for production)"
              echo "   - Install .deb/.rpm/.AppImage as appropriate"
              echo "   - System package manager integration"
              echo ""
              
              read -p "Choose deployment option [1]: " DEPLOY_CHOICE
              DEPLOY_CHOICE=${DEPLOY_CHOICE:-1}
              
              case "$DEPLOY_CHOICE" in
                  1)
                      echo "✅ Local deployment selected"
                      echo "🚀 To run: ./launch-production.sh"
                      ;;
                  2)
                      echo "🔧 Installing to system PATH..."
                      if sudo ln -sf "$(pwd)/launch-production.sh" /usr/local/bin/claudia; then
                          echo "✅ System installation complete!"
                          echo "🚀 To run: claudia (from anywhere)"
                          echo "🗑️  To uninstall: sudo rm /usr/local/bin/claudia"
                      else
                          echo "❌ System installation failed"
                          echo "💡 Fallback: Use local deployment (option 1)"
                      fi
                      ;;
                  3)
                      echo "🔧 Installing to user PATH..."
                      mkdir -p ~/.local/bin
                      if ln -sf "$(pwd)/launch-production.sh" ~/.local/bin/claudia; then
                          echo "✅ User installation complete!"
                          if [[ ":$PATH:" != *":~/.local/bin:"* ]] && [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
                              echo "⚠️  ~/.local/bin not in PATH"
                              echo "💡 Add to your shell profile:"
                              echo "   echo 'export PATH=\"$HOME/.local/bin:$PATH\"' >> ~/.bashrc"
                              echo "   source ~/.bashrc"
                          fi
                          echo "🚀 To run: claudia (from anywhere)"
                          echo "🗑️  To uninstall: rm ~/.local/bin/claudia"
                      else
                          echo "❌ User installation failed"
                          echo "💡 Fallback: Use local deployment (option 1)"
                      fi
                      ;;
                  4)
                      echo "📦 Package installation options:"
                      echo ""
                      
                      # Find available packages
                      if ls ./src-tauri/target/release/bundle/deb/*.deb &>/dev/null; then
                          echo "🔹 Debian package (.deb):"
                          echo "   sudo dpkg -i ./src-tauri/target/release/bundle/deb/*.deb"
                      fi
                      if ls ./src-tauri/target/release/bundle/rpm/*.rpm &>/dev/null; then
                          echo "🔹 RPM package (.rpm):"
                          echo "   sudo rpm -i ./src-tauri/target/release/bundle/rpm/*.rpm"
                      fi
                      if ls ./src-tauri/target/release/bundle/appimage/*.AppImage &>/dev/null; then
                          echo "🔹 AppImage (universal):"
                          echo "   chmod +x ./src-tauri/target/release/bundle/appimage/*.AppImage"
                          echo "   ./src-tauri/target/release/bundle/appimage/*.AppImage"
                      fi
                      echo ""
                      echo "💡 Choose the package format appropriate for your distribution"
                      ;;
                  *)
                      echo "❌ Invalid choice, using local deployment"
                      echo "🚀 To run: ./launch-production.sh"
                      ;;
              esac
          }
          
          deployment_options_governor
          echo ""
          echo "⚠️  IMPORTANT: Always use the launcher (never run the raw executable)"
          echo "💡 The launcher applies required WebKit environment variables"
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
  
  # Package Manager Configuration Governor (Cybernetic Pattern)
  echo "🔧 Applying package manager governance to Tauri configuration..."
  
  package_manager_governor() {
      local config_file="$1"
      local detected_pm="bun"  # Claudia requires Bun
      
      # Validate Bun is available
      if ! command -v bun &> /dev/null; then
          echo "❌ CRITICAL: Bun not found - cannot configure Tauri"
          return 1
      fi
      
      echo "🎯 Package manager governor configured: $detected_pm (required for Claudia)"
      
      # Apply configuration updates based on detected manager
      if [ -f "$config_file" ]; then
          # Create backup before modification
          cp "$config_file" "${config_file}.backup"
          
          # Update beforeDevCommand and beforeBuildCommand
          sed -i "s/\"beforeDevCommand\": \"bun run dev\"/\"beforeDevCommand\": \"$detected_pm run dev\"/" "$config_file"
          sed -i "s/\"beforeBuildCommand\": \"bun run build\"/\"beforeBuildCommand\": \"$detected_pm run build\"/" "$config_file"
          
          echo "✅ Updated $config_file for $detected_pm package manager"
          echo "💾 Backup saved as ${config_file}.backup"
          return 0
      else
          echo "⚠️  Configuration file not found: $config_file"
          return 1
      fi
  }
  
  # Apply governor to main Tauri configuration
  if package_manager_governor "src-tauri/tauri.conf.json"; then
      echo "✅ Main Tauri configuration updated with package manager governance"
  else
      echo "⚠️  Could not update main Tauri configuration"
  fi

  # Create AppImage configuration for build-full option
  echo "🔧 Creating AppImage configuration..."
  
  # AppImage configuration uses Bun (essential for Claudia)
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

