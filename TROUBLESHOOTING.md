# Troubleshooting Guide

This guide helps resolve common issues when using the Claudia WebKit Fix on Manjaro Linux.

## Quick Validation

Before troubleshooting, validate your installation:

```bash
# Check script syntax and structure
./install.sh --validate

# Comprehensive validation (if dev-check.sh is available)
./dev-check.sh

# Test linuxdeploy if using AppImage builds
linuxdeploy --version
```

## Common Issues and Solutions

### 🔴 AppImage Bundling Fails

**Error Message:**
```
failed to bundle project: `failed to run linuxdeploy`
```

**Cause:**
Missing AppImage dependencies, incompatible linuxdeploy version, or FUSE execution issues.

**Solutions:**

1. **Use package build (Recommended):**
   ```bash
   claudia-build              # Creates deb and rpm packages
   # or
   ./claudia-manjaro.sh build
   ```

2. **Use executable-only build (Fastest):**
   ```bash
   claudia-build-exe          # Creates executable only
   # or
   ./claudia-manjaro.sh build-exe
   ```

3. **Fix linuxdeploy installation:**
   ```bash
   # Force install our wrapper
   export INSTALL_WRAPPER=1 && ./install.sh
   
   # Or manually set environment variable
   export APPIMAGE_EXTRACT_AND_RUN=1
   claudia-build-full
   ```

4. **Install missing dependencies and try AppImage:**
   ```bash
   sudo pacman -S --needed fuse2 appstream-glib
   claudia-build-full         # Includes AppImage
   # or
   ./claudia-manjaro.sh build-full
   ```

---

### 🔴 White Screen/Blank Window

**Symptoms:**
- Claudia window opens but displays only white/blank content
- No UI elements visible
- Application seems to be running but not functional

**Cause:**
WebKit compositing mode conflicts with newer WebKit versions.

**Solutions:**

1. **Ensure you're using the launcher script:**
   ```bash
   ./claudia-manjaro.sh dev
   # NOT: bun run tauri dev
   ```

2. **Verify environment variables are set:**
   ```bash
   echo $WEBKIT_DISABLE_COMPOSITING_MODE  # Should output: 1
   ```

3. **Check WebKit version:**
   ```bash
   pacman -Q webkit2gtk-4.1
   ```

4. **Manual environment setup (if needed):**
   ```bash
   export WEBKIT_DISABLE_COMPOSITING_MODE=1
   export PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1
   export WEBKIT_DISABLE_DMABUF_RENDERER=1
   export WEBKIT_FORCE_SANDBOX=0
   bun run tauri dev
   ```

---

### 🔴 Permission Errors

**Error Messages:**
- `Permission denied`
- `cannot execute binary file`
- `No such file or directory`

**Solutions:**

1. **Make scripts executable:**
   ```bash
   chmod +x claudia-manjaro.sh
   chmod +x uninstall-claudia-manjaro.sh
   ```

2. **Check file ownership:**
   ```bash
   ls -la claudia-manjaro.sh
   # Should show your username as owner
   ```

3. **Fix ownership if needed:**
   ```bash
   sudo chown $USER:$USER claudia-manjaro.sh
   ```

---

### 🔴 Bun Installation Issues

**Error Messages:**
- `bun: command not found`
- `Failed to install bun`
- `curl: command not found`

**Solutions:**

1. **The script automatically falls back to npm** - check the installation output

2. **Manual Bun installation:**
   ```bash
   curl -fsSL https://bun.sh/install | bash
   source ~/.bashrc
   ```

3. **Verify Bun installation:**
   ```bash
   bun --version
   ```

4. **Use npm as alternative:**
   ```bash
   npm install  # instead of bun install
   npm run tauri dev  # instead of bun run tauri dev
   ```

---

### 🔴 Missing Dependencies

**Error Messages:**
- `error: target not found: [package-name]`
- `Package not found`
- `Failed to install some packages`

**Solutions:**

1. **Update package database:**
   ```bash
   sudo pacman -Syu
   ```

2. **Install required packages manually:**
   ```bash
   sudo pacman -S --needed webkit2gtk-4.1 gtk3 libayatana-appindicator rust nodejs npm
   ```

3. **Install optional packages for AppImage:**
   ```bash
   sudo pacman -S --needed fuse2 appstream-glib
   ```

4. **Check package availability:**
   ```bash
   pacman -Ss [package-name]
   ```

---

### 🔴 Build Failures

**Error Messages:**
- `error: could not compile`
- `Cargo build failed`
- `linker 'cc' not found`

**Solutions:**

1. **Install build tools:**
   ```bash
   sudo pacman -S --needed base-devel
   ```

2. **Update Rust toolchain:**
   ```bash
   rustup update
   ```

3. **Clean and rebuild:**
   ```bash
   claudia-clean
   claudia-build
   ```

4. **Check disk space:**
   ```bash
   df -h
   ```

---

### 🔴 Network/Download Issues

**Error Messages:**
- `Failed to clone repository`
- `curl: (6) Could not resolve host`
- `Network is unreachable`

**Solutions:**

1. **Check internet connection:**
   ```bash
   ping -c 3 google.com
   ```

2. **Try different repository URL:**
   ```bash
   # Use HTTPS instead of SSH
   git clone https://github.com/getAsterisk/claudia.git
   ```

3. **Use local directory if available:**
   - Choose option 3 when prompted for repository source
   - Provide path to existing Claudia directory

---

### 🔴 Alias Issues

**Symptoms:**
- `claudia-dev: command not found`
- Aliases not working after installation

**Solutions:**

1. **Restart terminal or source shell config:**
   ```bash
   source ~/.bashrc
   # or
   source ~/.zshrc
   ```

2. **Check if aliases were added:**
   ```bash
   grep -n "claudia" ~/.bashrc ~/.zshrc
   ```

3. **Manually add aliases:**
   ```bash
   echo "alias claudia-dev='cd /path/to/claudia && ./claudia-manjaro.sh dev'" >> ~/.bashrc
   ```

---

### 🔴 Desktop Entry Issues

**Symptoms:**
- Claudia not appearing in application menu
- Desktop entry not working

**Solutions:**

1. **Update desktop database:**
   ```bash
   update-desktop-database ~/.local/share/applications/
   ```

2. **Check desktop entry:**
   ```bash
   cat ~/.local/share/applications/claudia.desktop
   ```

3. **Manually create desktop entry:**
   ```bash
   cp ~/.local/share/applications/claudia.desktop ~/Desktop/
   ```

---

## Diagnostic Commands

Use these commands to gather information for debugging:

```bash
# System information
uname -a
lsb_release -a

# Package versions
pacman -Q webkit2gtk-4.1 gtk3 rust nodejs npm bun

# Environment check
env | grep WEBKIT
env | grep PKG_CONFIG

# File permissions
ls -la claudia-manjaro.sh

# Process check
ps aux | grep claudia
```

## Getting Help

If you're still experiencing issues:

1. **Check the full installation output** for specific error messages
2. **Run diagnostic commands** above and note the output
3. **Try the manual installation steps** from the README
4. **Open an issue** on GitHub with:
   - Your system information (`uname -a`)
   - Complete error messages
   - Steps you've already tried
   - Output from diagnostic commands

## Contact

For additional support:
- **GitHub Issues**: Create an issue with detailed information
- **Email**: jamie.saker@macawi.ai
- **Company**: Macawi

---

*This troubleshooting guide is continuously updated based on user feedback and new issues discovered.*