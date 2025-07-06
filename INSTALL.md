# Installation Guide

Quick installation guide for the Claudia WebKit Fix on Manjaro Linux.

## Prerequisites

- Manjaro Linux (or other Arch-based distribution)
- Internet connection
- Terminal access
- Basic command-line knowledge

## Quick Installation

### One-Line Installation (Recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/macawi-ai/claudia-manjaro-fix/main/install.sh | bash
```

### Manual Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/macawi-ai/claudia-manjaro-fix.git
   cd claudia-manjaro-fix
   ```

2. **Make the script executable:**
   ```bash
   chmod +x install.sh
   ```

3. **Run the installation:**
   ```bash
   ./install.sh                  # Interactive installation
   ./install.sh --version        # Show version and system info
   ./install.sh --help           # Show detailed help
   ./install.sh --validate       # Validate script before running
   ```

4. **Follow the prompts:**
   - Choose installation directory (default: `./claudia`)
   - Select repository source (default: official Claudia repository)
   - Wait for installation to complete

## Installation Options

When prompted for repository source, you can choose:

1. **Official Claudia repository** (recommended)
   - Automatically uses: `https://github.com/getAsterisk/claudia.git`
   - Always gets the latest version

2. **Custom repository URL**
   - Enter your own Git repository URL
   - Useful for forks or custom versions

3. **Local directory path**
   - Copy from existing Claudia installation
   - Useful if you already have Claudia downloaded

## What Gets Installed

### System Dependencies
- `webkit2gtk-4.1` - WebKit engine
- `gtk3` - UI toolkit
- `libayatana-appindicator` - System tray support
- `rust` - Rust compiler
- `nodejs` - Node.js runtime
- `npm` - Node package manager

### Optional Dependencies (for AppImage bundling)
- `fuse2` - FUSE filesystem
- `appstream-glib` - AppStream support

### JavaScript Runtime
- `bun` - Fast JavaScript runtime (primary)
- `npm` - Fallback if Bun installation fails

### Files Created
- `claudia-manjaro.sh` - Main launcher script
- `launch-production.sh` - Production executable launcher
- `uninstall-claudia-manjaro.sh` - Uninstaller
- `~/.local/share/applications/claudia.desktop` - Desktop entry
- Shell aliases in `~/.bashrc` or `~/.zshrc`

## Post-Installation

### Test the Installation

1. **Start development server:**
   ```bash
   claudia-dev
   ```

2. **Or manually:**
   ```bash
   cd /path/to/claudia
   ./claudia-manjaro.sh dev
   ```

### Build Production Version

```bash
# Executable only (recommended)
claudia-build

# With all bundles (may fail if dependencies missing)
claudia-build-full
```

## Available Commands

After installation, you can use these commands:

- `claudia-dev` - Start development server
- `claudia-build` - Build executable only
- `claudia-build-full` - Build with all bundles
- `claudia-clean` - Clean build artifacts

### Launcher Script Commands

The launcher script (`claudia-manjaro.sh`) supports these options:

```bash
./claudia-manjaro.sh dev         # Start development server (default)
./claudia-manjaro.sh build       # Build with deb and rpm packages
./claudia-manjaro.sh build-exe   # Build executable only
./claudia-manjaro.sh build-full  # Build with AppImage (requires dependencies)
./claudia-manjaro.sh clean       # Clean build artifacts
./claudia-manjaro.sh version     # Show version information
./claudia-manjaro.sh help        # Show help message
```

## Advanced Options

### Force Install LinuxDeploy Wrapper
If you have linuxdeploy installed but AppImage bundling fails:
```bash
export INSTALL_WRAPPER=1 && ./install.sh
```

### Development and Validation Tools
```bash
# Validate script before running
./install.sh --validate

# Comprehensive development validation (for developers)
./dev-check.sh

# Install pre-commit hooks (for contributors)
cp pre-commit-hook .git/hooks/pre-commit && chmod +x .git/hooks/pre-commit
```

## Troubleshooting

If you encounter issues during installation:

1. **Validate the script first**: `./install.sh --validate`
2. **Check the full output** for error messages
3. **Ensure you have internet connection**
4. **Try manual installation** if one-line fails
5. **See [TROUBLESHOOTING.md](TROUBLESHOOTING.md)** for specific issues
6. **Run with sudo if needed** for package installation

## Verification

After installation, verify everything works:

```bash
# Check Bun installation
bun --version

# Check script exists and is executable
ls -la /path/to/claudia/claudia-manjaro.sh

# Check aliases
alias | grep claudia

# Check desktop entry
ls -la ~/.local/share/applications/claudia.desktop
```

## Uninstallation

To remove the Claudia WebKit Fix:

```bash
cd /path/to/claudia
./uninstall-claudia-manjaro.sh
```

This removes:
- Desktop entry
- Shell aliases
- Uninstaller script

The Claudia directory and files are preserved.

## Next Steps

After successful installation:

1. **Read the [README.md](README.md)** for detailed usage instructions
2. **Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md)** if you encounter issues
3. **Start developing** with `claudia-dev`
4. **Build your application** with `claudia-build`

## Support

For installation issues:
- Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
- Open an issue on GitHub
- Contact: jamie.saker@macawi.ai