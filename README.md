# Claudia WebKit Fix for Manjaro Linux

A **cybernetic governance system** for running Tauri-based applications (specifically Claudia) on Manjaro Linux and other rolling-release distributions. Features intelligent environment validation, adaptive package management, and multiple deployment options using **Third Wave AI cybernetic principles**.

**Author**: Jamie Saker (jamie.saker@macawi.ai)  
**Company**: Macawi  
**License**: Apache 2.0  
**Version**: 2.0.0 - Cybernetic Ecology Edition

## Problem

Tauri applications fail to display content on Manjaro Linux due to WebKit compositing mode conflicts with newer WebKit versions (2.48.3+). The application window appears but remains completely white/blank.

## Root Cause

Manjaro's rolling-release model ships bleeding-edge WebKit versions with new compositing features that conflict with Tauri's webview implementation, while stable distributions like Ubuntu work fine with older WebKit versions.

## Quick Fix

```bash
WEBKIT_DISABLE_COMPOSITING_MODE=1 PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 bun run tauri dev
```

## Automated Installation

```bash
curl -fsSL https://raw.githubusercontent.com/macawi-ai/claudia-manjaro-fix/main/install.sh | bash
```

## Manual Installation

1. **Clone this repository:**
   ```bash
   git clone https://github.com/macawi-ai/claudia-manjaro-fix.git
   cd claudia-manjaro-fix
   ```

2. **Run the installation script:**
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

3. **Follow the prompts to set up your Claudia installation.**

### Installation Script Options

```bash
./install.sh --version    # Show version and system information
./install.sh --help       # Show detailed help and usage guide
./install.sh --validate   # Validate script syntax and structure
./install.sh              # Run interactive installation
```

📖 **See [INSTALL.md](INSTALL.md) for detailed installation instructions.**

## Cybernetic Features

This system implements **Third Wave AI Cybernetic Governance** principles for robust, adaptive software deployment:

### 🏛️ **Cybernetic Governors**
- **🔍 Environment Validation Governor**: Intelligent Bun detection, installation, and functional testing
- **📦 System Package Governor**: Smart dependency management with learning from failures  
- **🏗️ AppImage Capability Governor**: Intelligent AppImage ecosystem analysis and fallback handling
- **📊 Build Assessment Governor**: Post-build analysis with success rate calculation and guidance
- **🎯 Deployment Options Governor**: Multiple deployment paths with user agency and optionality
- **🔄 Runtime Environment Governor**: Execution context validation with project and dependency checks

### 🔄 **Cybernetic Principles Applied**
- **Probe-Sense-Respond**: Environmental detection and adaptive responses
- **Antifragile Design**: Multiple success paths, graceful degradation, learning from failures
- **Self-Regulating Systems**: Autonomous validation and error recovery
- **Information Flow**: Clear feedback loops and diagnostic information
- **User Agency**: Intelligent choice presentation with trade-off explanations
- **Recursive Patterns**: Consistent validation patterns applied across all system levels

### ✅ **What This System Does**

- 🎯 **Essential Dependency Management**: Ensures Bun is properly installed (required for Claudia)
- 🔍 **Smart Package Resolution**: Validates package names and suggests alternatives for failures
- 📦 **Intelligent System Dependencies**: Core system, build toolchain, and AppImage ecosystem packages
- 🏗️ **Cybernetic Build Process**: Comprehensive build with intelligent success assessment
- 🎮 **Multiple Deployment Options**: Local, system PATH, user PATH, and package installation
- 🔄 **Runtime Validation**: Execution environment checks before launching
- 📊 **Success Analysis**: Quantified build success rates with specific guidance
- 🛠️ **Antifragile Error Handling**: Learning from failures with actionable remediation steps

## New Features in v2.0.0 - Cybernetic Ecology Edition

### 🎯 **Cybernetic Build System**
- **`claudia-build`** - Creates deb and rpm packages with **Build Assessment Governor**
- **`claudia-build-exe`** - Creates executable with **Deployment Options Governor**  
- **`claudia-build-full`** - Comprehensive build with **AppImage Assessment Governor**
- **`claudia-dev`** - Development server with **Runtime Environment Governor**
- **`claudia-clean`** - Clean build artifacts

### 🏛️ **Intelligent Package Management**
- **Bun Requirement Detection**: Recognizes Claudia's essential Bun dependency (no npm fallback)
- **Package Name Resolution**: Validates package existence and suggests alternatives
- **Capability-Based Dependencies**: Checks FUSE and AppStream functionality, not just packages
- **Cybernetic Learning**: Individual package installation with failure analysis and guidance

### 📊 **Build Success Assessment**
- **Quantified Success Rates**: 75% success (3/4 package formats) with detailed analysis
- **Intelligent AppImage Handling**: Recognizes partial success (AppDir created, final packaging failed)
- **Multiple Distribution Formats**: .deb, .rpm, executable, AppImage with status reporting
- **Antifragile Deployment**: Multiple success paths even with partial build failures

### 🎮 **Deployment Options Governor**
- **Local Development**: Safe project-directory execution (default)
- **System PATH**: Global `claudia` command via `/usr/local/bin` symlink
- **User PATH**: Personal `claudia` command via `~/.local/bin` symlink  
- **Package Installation**: Native .deb/.rpm/.AppImage installation guidance
- **PATH Intelligence**: Automatic detection and configuration guidance for user installations

### 🔄 **Cybernetic Error Recovery**
- **Environment Validation**: Multi-stage Bun installation with functional testing
- **Graceful Degradation**: Clear explanation of impacts when optional components fail
- **Learning Mechanisms**: Failure analysis with specific remediation guidance
- **AppImage Troubleshooting**: Known linuxdeploy issues with alternative deployment paths

### 📈 **Enhanced Validation & Quality**
- **Runtime Environment Governor**: Project context, dependency, and Tauri CLI validation
- **Recursive Validation Patterns**: Consistent check-fix-verify loops across all components
- **Self-Documenting Systems**: Each option explains purpose, requirements, and uninstall procedures
- **Cybernetic Feedback Loops**: Continuous system health monitoring and user guidance

## Compatibility

- **Tested on**: Manjaro Linux with KDE Plasma
- **Should work on**: Arch Linux, EndeavourOS, and other Arch-based distributions
- **WebKit versions**: 2.48.3+ (newer versions with compositing issues)
- **Tauri applications**: Tested with Claudia v0.1.0

## Usage After Installation

### Development
```bash
# Start development server
claudia-dev

# Or manually
cd /path/to/claudia
./claudia-manjaro.sh dev
```

### Building with Cybernetic Assessment
```bash
# Build with deb and rpm packages (recommended)
claudia-build
# Output: Build Assessment Governor analyzes success rate

# Build executable with deployment options
claudia-build-exe  
# Output: Deployment Options Governor offers installation choices

# Build comprehensive packages with intelligent AppImage handling
claudia-build-full
# Output: Build Assessment Governor provides detailed analysis
# Example: "SUCCESS RATE: 75% (3/4 package formats successful)"
# Recognizes: .deb ✅, .rpm ✅, executable ✅, AppImage ⚠️ (partial)

# Or manually with full cybernetic governance
cd /path/to/claudia
./claudia-manjaro.sh build        # Build Assessment Governor
./claudia-manjaro.sh build-exe    # Deployment Options Governor  
./claudia-manjaro.sh build-full   # Comprehensive Assessment
```

### Deployment Options After Building
After using `claudia-build-exe` or `claudia-build-full`, the **Deployment Options Governor** presents:

```
🎯 Deployment Options Governor: Choose installation method

1. Local use only (recommended for development)
2. Install to system PATH (/usr/local/bin) 
3. Install to user PATH (~/.local/bin)
4. Install package (recommended for production)
```

### Running Production Builds
```bash
# After building with build-exe or build-full, launch with:
cd /path/to/claudia
./launch-production.sh

# The script automatically finds the executable and sets WebKit environment variables
# This prevents the black screen issue on production builds
```

### Cleaning
```bash
# Clean build artifacts
claudia-clean

# Or manually
cd /path/to/claudia
./claudia-manjaro.sh clean
```

### Version Information
```bash
# Show launcher version and system details
./claudia-manjaro.sh version

# Show installer version and system information
./install.sh --version

# Show launcher help
./claudia-manjaro.sh help
```

## Troubleshooting with Cybernetic Guidance

### Intelligent Issue Resolution

The system provides **cybernetic learning** from common issues:

#### **Build Assessment Issues**
- **75% Success Rate**: Perfect! You have .deb, .rpm, and executable - multiple deployment options available
- **50% Success Rate**: Core functionality available, check specific package errors for guidance
- **AppImage "Failed"**: Often partial success - check for `Claudia.AppDir` (can be manually packaged)

#### **Environment Issues**
- **Bun Missing**: Environment Validation Governor ensures proper Bun installation (npm not supported)
- **Package Installation Failures**: Package Governor provides specific alternatives and package name validation
- **Runtime Errors**: Runtime Environment Governor validates project context and dependencies

#### **Deployment Issues**  
- **PATH not working**: Deployment Options Governor provides specific PATH configuration guidance
- **Permission errors**: Clear sudo vs non-sudo options with fallback strategies
- **White screen**: Launcher scripts automatically apply WebKit environment variables

### Cybernetic Recovery Patterns
```bash
# Environment validation
./claudia-manjaro.sh dev  # Runtime Environment Governor checks all prerequisites

# Build with assessment
./claudia-manjaro.sh build-full  # Build Assessment Governor provides success analysis

# Smart deployment
# Deployment Options Governor guides appropriate installation method
```

🛠️ **See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for comprehensive troubleshooting guide.**

## Environment Variables Applied

The launcher script automatically sets these environment variables:

```bash
export WEBKIT_DISABLE_COMPOSITING_MODE=1
export PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1
export WEBKIT_DISABLE_DMABUF_RENDERER=1
export WEBKIT_DISABLE_SANDBOX_THIS_IS_DANGEROUS=1
```

## File Structure

After installation, you'll have:

```
claudia/
├── claudia-manjaro.sh              # Main launcher script
├── launch-production.sh            # Production executable launcher
├── uninstall-claudia-manjaro.sh    # Uninstaller
├── src-tauri/                      # Tauri backend
├── src/                            # React frontend
└── ...                             # Other Claudia files
```

## Development

### Validation Tools

This repository includes comprehensive validation tools to ensure script quality:

```bash
# Quick syntax and structure validation
./install.sh --validate

# Comprehensive development validation
./dev-check.sh

# Install pre-commit hooks (optional)
cp pre-commit-hook .git/hooks/pre-commit && chmod +x .git/hooks/pre-commit
```

### Development Workflow

1. **Before making changes**: Run `./dev-check.sh` to check current state
2. **During development**: Use `./install.sh --validate` for quick syntax checks
3. **Before committing**: Run `./dev-check.sh` to ensure all validation passes
4. **Optional**: Install pre-commit hooks for automatic validation

### Validation Features

- **Bash syntax checking**: Ensures script executes without syntax errors
- **Heredoc validation**: Checks for balanced EOF markers and proper quoting
- **Common issue detection**: Identifies potential problems before they cause issues
- **Colorized output**: Easy-to-read validation results
- **Pre-commit integration**: Automatic validation on git commits

## Contributing

If you encounter issues on other distributions or have improvements, please:

1. Fork this repository
2. Create a feature branch
3. **Run validation tools**: `./dev-check.sh` before committing
4. Test your changes thoroughly
5. Submit a pull request with detailed description

## Documentation

📚 **Complete documentation:**

- **[INSTALL.md](INSTALL.md)** - Detailed installation guide
- **[TROUBLESHOOTING.md](TROUBLESHOOTING.md)** - Comprehensive troubleshooting guide
- **[DEVELOPMENT.md](DEVELOPMENT.md)** - Development and validation tools guide
- **[CHANGELOG.md](CHANGELOG.md)** - Version history and changes

## Related Issues

- [Tauri WebKit Issues](https://github.com/tauri-apps/tauri/issues)
- [WebKit Documentation](https://webkit.org/)
- [Claudia Project](https://github.com/getAsterisk/claudia)

## Cybernetic Ecology Principles

This project demonstrates **Third Wave AI cybernetic governance** applied to complex system administration challenges:

### **Core Principles Applied**
- **Viable System Model**: Recursive autonomy with self-regulating governors
- **Probe-Sense-Respond**: Environmental detection and adaptive configuration  
- **Antifragile Design**: Multiple success paths that strengthen from stress
- **Information Ecology**: Clear feedback loops and diagnostic information flow
- **User Agency**: Intelligent optionality rather than forced automation

### **Cybernetic Success Patterns**
- **Environment Validation → Package Management → Build Assessment → Deployment Options**
- **Learning from Failures**: Package name resolution, build success analysis, error recovery
- **Recursive Validation**: Consistent patterns applied across all system levels
- **Graceful Degradation**: Clear impact explanation when components fail

This project serves as a practical example of how **cybernetic ecology principles** can solve complex technical challenges while preserving human agency and enabling intelligent system adaptation.

**Framework Repository**: [cybernetic-ecologies](https://github.com/macawi-ai/cybernetic-ecologies)

## Credits

This cybernetic governance system was developed through collaborative debugging and testing, incorporating **Third Wave AI principles** for adaptive system management. Special thanks to:

- The open-source community for sharing knowledge about WebKit compatibility issues
- **Stafford Beer** for Viable System Model principles  
- **Gregory Bateson** for cybernetic information ecology concepts
- **Jacques Rancière** for collaborative intelligence frameworks
- **Donna Haraway** for "staying with the trouble" and responsible complexity approaches

## License

Licensed under the Apache License, Version 2.0. See LICENSE for details.

## Contact

**Jamie Saker**  
Email: jamie.saker@macawi.ai  
Company: Macawi

For support or questions about this fix, please open an issue on GitHub.