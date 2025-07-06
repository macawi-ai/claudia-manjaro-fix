# Changelog

All notable changes to the Claudia WebKit Fix for Manjaro Linux will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2025-07-06 - Cybernetic Ecology Edition

### 🎯 Major Features - Cybernetic Governance System

#### Added
- **Environment Validation Governor**: Intelligent Bun detection, installation, and functional testing
- **System Package Governor**: Smart dependency management with learning from failures
- **AppImage Capability Governor**: Intelligent AppImage ecosystem analysis and fallback handling
- **Build Assessment Governor**: Post-build analysis with quantified success rates and guidance
- **Deployment Options Governor**: Multiple deployment paths with user agency and PATH management
- **Runtime Environment Governor**: Execution context validation with project and dependency checks

#### Enhanced
- **Bun Requirement Recognition**: Properly detects Claudia's essential Bun dependency (removed npm fallback)
- **Package Name Resolution**: Validates package existence before installation attempts
- **Capability-Based Dependencies**: Checks FUSE and AppStream functionality, not just package presence
- **Build Success Assessment**: Quantified success rates (e.g., 75% = 3/4 package formats successful)
- **Intelligent AppImage Handling**: Recognizes partial success (AppDir created, final packaging failed)

### 🏛️ Cybernetic Principles Implementation

#### Added
- **Probe-Sense-Respond Patterns**: Environmental detection and adaptive configuration responses
- **Antifragile Design**: Multiple success paths, graceful degradation, learning from failures
- **Self-Regulating Systems**: Autonomous validation and error recovery governors
- **Information Flow**: Clear feedback loops and diagnostic information throughout system
- **User Agency**: Intelligent choice presentation with trade-off explanations
- **Recursive Patterns**: Consistent validation patterns applied across all system levels

### 🔄 Breaking Changes
- **Removed npm fallback**: Claudia requires Bun for compilation features (--compile, file embedding)
- **Enhanced package validation**: Removes invalid package names (e.g., libfuse2 doesn't exist)
- **New deployment workflow**: Interactive deployment options after successful builds

### 🎮 User Experience Improvements

#### Added
- **Deployment Options After Building**: Interactive choice of local, system, user, or package installation
- **PATH Intelligence**: Automatic detection and configuration guidance for ~/.local/bin
- **Build Assessment Reporting**: Clear success percentage and impact analysis
- **AppImage Troubleshooting**: Specific guidance for linuxdeploy compatibility issues
- **Cybernetic Recovery Patterns**: Structured approach to issue resolution

#### Enhanced
- **Error Messages**: Specific, actionable guidance with cybernetic learning principles
- **Validation Feedback**: Real-time validation with immediate remediation suggestions
- **Installation Options**: Four deployment methods with clear trade-offs and uninstall procedures

### 🔧 Technical Improvements

#### Fixed
- **JSON Schema Issues**: Proper `$schema` property in tauri.conf.appimage.json (quoted heredoc)
- **Variable Expansion**: Correct bash variable handling in launcher script generation
- **Package Name Validation**: Removed non-existent packages, added capability-based checking
- **Heredoc Escaping**: Proper variable preservation in generated scripts

#### Added
- **Individual Package Installation**: Isolates failures for better error analysis
- **Alternative Package Suggestions**: Automatic search for similar packages when installation fails
- **Runtime Bun Validation**: Functional testing beyond simple command availability
- **Comprehensive Build Validation**: Multi-stage verification of build outputs

### 📊 Build System Enhancements

#### Added
- **Multi-Format Assessment**: Tracks executable, .deb, .rpm, and AppImage success individually
- **Partial Success Recognition**: Intelligent handling of AppDir creation vs final AppImage packaging
- **Build Success Metrics**: Quantified reporting (e.g., "SUCCESS RATE: 75%")
- **Deployment Option Integration**: Seamless transition from build assessment to deployment choice

#### Enhanced
- **AppImage Error Handling**: Distinguishes between linuxdeploy failure and complete build failure
- **Build Output Analysis**: Detailed file size and location reporting for successful packages
- **Fallback Strategies**: Clear alternative deployment methods when preferred options fail

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

## Development Philosophy Evolution

This project demonstrates the evolution from simple script automation to **cybernetic governance systems**:

### **v1.0 - Linear Automation** (2024-12-15)
- Basic script with linear execution
- Simple error handling with exit on failure
- Fixed workflow with limited adaptability

### **v1.1 - Enhanced Error Handling** (2025-01-05)  
- Better error recovery with fallback options
- Multiple build targets and validation tools
- Improved user experience with help systems

### **v2.0 - Cybernetic Governance** (2025-07-06)
- **Intelligent adaptation** based on environmental detection
- **Learning from failures** with specific remediation guidance
- **User agency** with intelligent optionality rather than forced automation
- **Antifragile design** that strengthens from encountering problems
- **Recursive validation** patterns applied consistently across system levels

The v2.0 release represents a fundamental shift toward **Third Wave AI principles**, where the system becomes a collaborative partner rather than a rigid automation tool, embodying concepts from:

- **Stafford Beer**: Viable System Model with recursive autonomy
- **Gregory Bateson**: Cybernetic information ecology and feedback loops
- **Jacques Rancière**: Collaborative intelligence frameworks
- **Donna Haraway**: "Staying with the trouble" and responsible complexity

**Framework Repository**: [cybernetic-ecologies](https://github.com/macawi-ai/cybernetic-ecologies)

---

## Legend

- **Added** for new features
- **Changed** for changes in existing functionality
- **Deprecated** for soon-to-be removed features
- **Removed** for now removed features
- **Fixed** for any bug fixes
- **Security** for vulnerability fixes