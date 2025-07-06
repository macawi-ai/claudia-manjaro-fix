# Changelog

All notable changes to the Claudia WebKit Fix for Manjaro Linux will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- **Production Build Launcher Script**
  - New `launch-production.sh` script for running production executables
  - Automatically sets WebKit environment variables for production builds
  - Prevents black screen issues on `build-exe` and `build-full` outputs
  - Auto-detects executable location with fallback options
  - Clear usage instructions displayed after build completion

### Changed
- **Build Command Output**
  - All build commands now display clear instructions to use `launch-production.sh`
  - Added warnings against running executables directly
  - Enhanced build completion messages with specific paths

## [1.1.0] - 2025-01-05

### Added
- **Enhanced Build Options**
  - New `claudia-build` command for deb/rpm package builds (default, reliable)
  - New `claudia-build-exe` command for executable-only builds (fastest)
  - New `claudia-build-full` command for complete bundling including AppImage
  - Updated aliases: `claudia-build-exe` and `claudia-build-full` added to shell configuration
- **LinuxDeploy AppImage Fixes**
  - Automatic linuxdeploy installation with AppImage compatibility wrapper
  - Handles FUSE execution issues on Manjaro systems with extract-and-run fallback
  - Smart detection of existing linuxdeploy installations with validation
  - Force wrapper installation option: `export INSTALL_WRAPPER=1 && ./install.sh`
  - Pre-build linuxdeploy validation to prevent build failures
- **Development & Validation Tools**
  - Built-in script validation: `./install.sh --validate`
  - Comprehensive development checker: `./dev-check.sh`
  - Optional pre-commit hooks for automatic validation
  - EOF and heredoc syntax checking with detailed error reporting
  - Bash syntax validation and common issue detection
  - Colorized validation output for better readability
- **Version and Help System**
  - Added `--version` option to installation script with comprehensive system information
  - Added `--help` option to installation script with detailed usage guide
  - Added `--validate` option to installation script for syntax and structure checking
  - Added `version` command to launcher script with runtime and Claudia version detection
  - Added `help` command to launcher script with comprehensive command reference
  - Support for short flags: `-v` for version, `-h` for help
- **Improved Error Handling**
  - Comprehensive validation for all critical installation steps
  - Better error messages with actionable troubleshooting guidance
  - Fallback options for failed installations (npm fallback for Bun)
- **Repository Management**
  - Official Claudia repository as default option with user-friendly selection
  - Support for custom repository URLs
  - Local directory copying option with better error handling
- **Package Management**
  - Optional packages detection for AppImage bundling (fuse2, appstream-glib)
  - Enhanced package checking with individual status feedback
  - Better validation for package installation success
- **Documentation**
  - Comprehensive troubleshooting section in installation output
  - Final validation step to ensure installation success
  - Detailed usage instructions for all commands

### Changed
- **Script Behavior**
  - Removed `set -e` for better error handling and user experience
  - Default build command now uses `--no-bundle` to avoid AppImage issues
  - Improved clone/copy logic with better error handling
- **User Experience**
  - Enhanced status messages throughout installation process
  - Better command structure and help text
  - More informative error messages with specific solutions

### Fixed
- **AppImage Bundling Issues**
  - Fixed `failed to bundle project: failed to run linuxdeploy` error
  - Modified Tauri configuration to exclude AppImage from default builds
  - Created separate AppImage configuration for optional use
  - Provided multiple build options: deb/rpm packages, executable-only, and AppImage
  - Added detection for missing AppImage dependencies
- **Installation Reliability**
  - Better handling of package installation failures
  - Improved Bun installation with environment sourcing
  - Fixed potential issues with shell alias insertion

### Technical Details
- Script version updated to 1.1.0
- Enhanced launcher script with new build options
- Improved validation and error handling throughout
- Better documentation and user guidance

## [1.0.0] - 2024-12-XX

### Added
- Initial release of Claudia WebKit Fix for Manjaro Linux
- Automated installation script for WebKit compatibility
- WebKit environment variable configuration
- Desktop entry creation
- Shell aliases for convenient access
- Uninstaller script
- Basic error handling and validation

### Features
- Detection of Manjaro/Arch-based systems
- Installation of required system dependencies
- Bun JavaScript runtime installation
- WebKit compositing mode fixes
- Convenient launch scripts
- Desktop integration

### Environment Variables
- `WEBKIT_DISABLE_COMPOSITING_MODE=1`
- `PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1`
- `WEBKIT_DISABLE_DMABUF_RENDERER=1`
- `WEBKIT_FORCE_SANDBOX=0`

---

## Legend

- **Added** for new features
- **Changed** for changes in existing functionality
- **Deprecated** for soon-to-be removed features
- **Removed** for now removed features
- **Fixed** for any bug fixes
- **Security** for vulnerability fixes