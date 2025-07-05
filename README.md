# Claudia WebKit Fix for Manjaro Linux

A comprehensive solution for running Tauri-based applications (specifically Claudia) on Manjaro Linux and other rolling-release distributions that encounter WebKit compositing issues.

**Author**: Jamie Saker (jamie.saker@macawi.ai)  
**Company**: Macawi  
**License**: Apache 2.0  
**Version**: 1.1.0

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

## What This Script Does

- ✅ Detects Manjaro/Arch-based systems
- ✅ Installs required system dependencies (webkit2gtk-4.1, gtk3, rust, nodejs, npm)
- ✅ Installs optional dependencies for AppImage bundling (fuse2, appstream-glib)
- ✅ Installs Bun JavaScript runtime (with npm fallback)
- ✅ Clones official Claudia repository or uses existing installation
- ✅ Sets up WebKit compatibility environment variables
- ✅ Creates convenient launch scripts with build options
- ✅ Adds shell aliases for easy access
- ✅ Creates desktop entry
- ✅ Provides comprehensive error handling and validation
- ✅ Includes troubleshooting guidance

## New Features in v1.1.0

### Enhanced Build Options
- **`claudia-build`** - Creates deb and rpm packages (default, reliable)
- **`claudia-build-exe`** - Creates executable only (fastest, no packages)
- **`claudia-build-full`** - Creates all bundles including AppImage (requires dependencies)
- **`claudia-dev`** - Development server
- **`claudia-clean`** - Clean build artifacts

### Improved Error Handling
- Better package installation validation
- Fallback options for failed installations
- Comprehensive final validation step
- Detailed troubleshooting guidance

### Repository Management
- Official Claudia repository as default option
- Support for custom repository URLs
- Local directory copying option
- Better clone/copy error handling

### LinuxDeploy AppImage Fixes
- Automatic linuxdeploy installation with AppImage compatibility wrapper
- Handles FUSE execution issues on Manjaro systems
- Smart detection of existing linuxdeploy installations
- Fallback to extract-and-run mode for broken AppImage support
- Option to force install wrapper: `export INSTALL_WRAPPER=1 && ./install.sh`

### Development & Validation Tools
- Built-in script validation: `./install.sh --validate`
- Comprehensive development checker: `./dev-check.sh`
- Optional pre-commit hooks for automatic validation
- EOF and heredoc syntax checking
- Syntax error detection and reporting

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

### Building
```bash
# Build with deb and rpm packages (recommended)
claudia-build

# Build executable only (no packages)
claudia-build-exe

# Build with AppImage (requires fuse2, appstream-glib)
claudia-build-full

# Or manually
cd /path/to/claudia
./claudia-manjaro.sh build        # deb and rpm packages
./claudia-manjaro.sh build-exe    # Executable only
./claudia-manjaro.sh build-full   # Includes AppImage
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

## Troubleshooting

### Quick Fixes

- **AppImage bundling fails**: Use `claudia-build` (deb/rpm) or `claudia-build-exe` (executable only) instead of `claudia-build-full`
- **White screen**: Ensure you're using the launcher scripts (`./claudia-manjaro.sh dev`)
- **Permission errors**: Run `chmod +x *.sh` to make scripts executable
- **Missing Bun**: Script automatically falls back to npm
- **Missing packages**: Check installation output and install manually with pacman

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

## Credits

This solution was developed through collaborative debugging and testing. Special thanks to the open-source community for sharing knowledge about WebKit compatibility issues.

## License

Licensed under the Apache License, Version 2.0. See LICENSE for details.

## Contact

**Jamie Saker**  
Email: jamie.saker@macawi.ai  
Company: Macawi

For support or questions about this fix, please open an issue on GitHub.