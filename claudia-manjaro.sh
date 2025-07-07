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
                      # Create a system launcher that knows the installation directory
                      cat > claudia-system-launcher << SYSTEM_LAUNCHER_EOF
#!/bin/bash
# Claudia System Launcher - Generated by install.sh
# Installation directory: $(pwd)

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

CLAUDIA_HOME="$(pwd)"

# Change to Claudia home directory to ensure server can start properly
cd "\$CLAUDIA_HOME" || {
    echo "Error: Could not access Claudia installation at: \$CLAUDIA_HOME"
    exit 1
}

# Check if we need to run the dev server or just the executable
if [ -f "./src-tauri/target/release/claudia" ]; then
    # Production build exists - use it directly
    echo "🚀 Launching Claudia from: \$CLAUDIA_HOME"
    exec "./src-tauri/target/release/claudia" "\$@"
else
    # No production build - need to use dev mode
    echo "⚠️  No production build found, starting development server..."
    echo "💡 Run './claudia-manjaro.sh build-exe' in \$CLAUDIA_HOME to create production build"
    if command -v bun &> /dev/null; then
        exec bun run tauri dev
    else
        echo "❌ Bun not found - cannot start Claudia"
        echo "💡 Ensure Bun is installed and in PATH"
        exit 1
    fi
fi
SYSTEM_LAUNCHER_EOF
                      chmod +x claudia-system-launcher
                      
                      if sudo mv claudia-system-launcher /usr/local/bin/claudia; then
                          echo "✅ System installation complete!"
                          echo "🚀 To run: claudia (from anywhere)"
                          echo "🗑️  To uninstall: sudo rm /usr/local/bin/claudia"
                          echo ""
                          echo "⚠️  IMPORTANT: The system launcher will:"
                          echo "   • Change to $(pwd) before starting"
                          echo "   • Use production build if available"
                          echo "   • Fall back to dev mode if no build exists"
                      else
                          echo "❌ System installation failed"
                          echo "💡 Fallback: Use local deployment (option 1)"
                      fi
                      ;;
                  3)
                      echo "🔧 Installing to user PATH..."
                      mkdir -p ~/.local/bin
                      # Create a user launcher that knows the installation directory
                      cat > claudia-user-launcher << USER_LAUNCHER_EOF
#!/bin/bash
# Claudia User Launcher - Generated by install.sh
# Installation directory: $(pwd)

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

CLAUDIA_HOME="$(pwd)"

# Change to Claudia home directory to ensure server can start properly
cd "\$CLAUDIA_HOME" || {
    echo "Error: Could not access Claudia installation at: \$CLAUDIA_HOME"
    exit 1
}

# Check if we need to run the dev server or just the executable
if [ -f "./src-tauri/target/release/claudia" ]; then
    # Production build exists - use it directly
    echo "🚀 Launching Claudia from: \$CLAUDIA_HOME"
    exec "./src-tauri/target/release/claudia" "\$@"
else
    # No production build - need to use dev mode
    echo "⚠️  No production build found, starting development server..."
    echo "💡 Run './claudia-manjaro.sh build-exe' in \$CLAUDIA_HOME to create production build"
    if command -v bun &> /dev/null; then
        exec bun run tauri dev
    else
        echo "❌ Bun not found - cannot start Claudia"
        echo "💡 Ensure Bun is installed and in PATH"
        exit 1
    fi
fi
USER_LAUNCHER_EOF
                      chmod +x claudia-user-launcher
                      
                      if mv claudia-user-launcher ~/.local/bin/claudia; then
                          echo "✅ User installation complete!"
                          if [[ ":$PATH:" != *":~/.local/bin:"* ]] && [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
                              echo "⚠️  ~/.local/bin not in PATH"
                              echo "💡 Add to your shell profile:"
                              echo "   echo 'export PATH=\"$HOME/.local/bin:$PATH\"' >> ~/.bashrc"
                              echo "   source ~/.bashrc"
                          fi
                          echo "🚀 To run: claudia (from anywhere)"
                          echo "🗑️  To uninstall: rm ~/.local/bin/claudia"
                          echo ""
                          echo "⚠️  IMPORTANT: The user launcher will:"
                          echo "   • Change to $(pwd) before starting"
                          echo "   • Use production build if available"
                          echo "   • Fall back to dev mode if no build exists"
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
                      # Create a system launcher that knows the installation directory
                      cat > claudia-system-launcher << SYSTEM_LAUNCHER_EOF
#!/bin/bash
# Claudia System Launcher - Generated by install.sh
# Installation directory: $(pwd)

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

CLAUDIA_HOME="$(pwd)"

# Change to Claudia home directory to ensure server can start properly
cd "\$CLAUDIA_HOME" || {
    echo "Error: Could not access Claudia installation at: \$CLAUDIA_HOME"
    exit 1
}

# Check if we need to run the dev server or just the executable
if [ -f "./src-tauri/target/release/claudia" ]; then
    # Production build exists - use it directly
    echo "🚀 Launching Claudia from: \$CLAUDIA_HOME"
    exec "./src-tauri/target/release/claudia" "\$@"
else
    # No production build - need to use dev mode
    echo "⚠️  No production build found, starting development server..."
    echo "💡 Run './claudia-manjaro.sh build-exe' in \$CLAUDIA_HOME to create production build"
    if command -v bun &> /dev/null; then
        exec bun run tauri dev
    else
        echo "❌ Bun not found - cannot start Claudia"
        echo "💡 Ensure Bun is installed and in PATH"
        exit 1
    fi
fi
SYSTEM_LAUNCHER_EOF
                      chmod +x claudia-system-launcher
                      
                      if sudo mv claudia-system-launcher /usr/local/bin/claudia; then
                          echo "✅ System installation complete!"
                          echo "🚀 To run: claudia (from anywhere)"
                          echo "🗑️  To uninstall: sudo rm /usr/local/bin/claudia"
                          echo ""
                          echo "⚠️  IMPORTANT: The system launcher will:"
                          echo "   • Change to $(pwd) before starting"
                          echo "   • Use production build if available"
                          echo "   • Fall back to dev mode if no build exists"
                      else
                          echo "❌ System installation failed"
                          echo "💡 Fallback: Use local deployment (option 1)"
                      fi
                      ;;
                  3)
                      echo "🔧 Installing to user PATH..."
                      mkdir -p ~/.local/bin
                      # Create a user launcher that knows the installation directory
                      cat > claudia-user-launcher << USER_LAUNCHER_EOF
#!/bin/bash
# Claudia User Launcher - Generated by install.sh
# Installation directory: $(pwd)

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

CLAUDIA_HOME="$(pwd)"

# Change to Claudia home directory to ensure server can start properly
cd "\$CLAUDIA_HOME" || {
    echo "Error: Could not access Claudia installation at: \$CLAUDIA_HOME"
    exit 1
}

# Check if we need to run the dev server or just the executable
if [ -f "./src-tauri/target/release/claudia" ]; then
    # Production build exists - use it directly
    echo "🚀 Launching Claudia from: \$CLAUDIA_HOME"
    exec "./src-tauri/target/release/claudia" "\$@"
else
    # No production build - need to use dev mode
    echo "⚠️  No production build found, starting development server..."
    echo "💡 Run './claudia-manjaro.sh build-exe' in \$CLAUDIA_HOME to create production build"
    if command -v bun &> /dev/null; then
        exec bun run tauri dev
    else
        echo "❌ Bun not found - cannot start Claudia"
        echo "💡 Ensure Bun is installed and in PATH"
        exit 1
    fi
fi
USER_LAUNCHER_EOF
                      chmod +x claudia-user-launcher
                      
                      if mv claudia-user-launcher ~/.local/bin/claudia; then
                          echo "✅ User installation complete!"
                          if [[ ":$PATH:" != *":~/.local/bin:"* ]] && [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
                              echo "⚠️  ~/.local/bin not in PATH"
                              echo "💡 Add to your shell profile:"
                              echo "   echo 'export PATH=\"$HOME/.local/bin:$PATH\"' >> ~/.bashrc"
                              echo "   source ~/.bashrc"
                          fi
                          echo "🚀 To run: claudia (from anywhere)"
                          echo "🗑️  To uninstall: rm ~/.local/bin/claudia"
                          echo ""
                          echo "⚠️  IMPORTANT: The user launcher will:"
                          echo "   • Change to $(pwd) before starting"
                          echo "   • Use production build if available"
                          echo "   • Fall back to dev mode if no build exists"
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
