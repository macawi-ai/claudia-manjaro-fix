# Claudia WebKit Fix for Manjaro Linux

  A solution for running Tauri-based applications (specifically Claudia) on Manjaro Linux and other
  rolling-release distributions that encounter WebKit compositing issues.

  **Author**: Jamie Saker (jamie.saker@macawi.ai)
  **Company**: Macawi
  **License**: Apache 2.0

  ## Problem

  Tauri applications fail to display content on Manjaro Linux due to WebKit compositing mode conflicts
  with newer WebKit versions (2.48.3+). The application window appears but remains completely
  white/blank.

  ## Root Cause

  Manjaro's rolling-release model ships bleeding-edge WebKit versions with new compositing features that
  conflict with Tauri's webview implementation, while stable distributions like Ubuntu work fine with
  older WebKit versions.

  ## Quick Fix

  ```bash
  WEBKIT_DISABLE_COMPOSITING_MODE=1 PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 bun run tauri dev

  Automated Installation

  curl -fsSL https://raw.githubusercontent.com/macawi-ai/claudia-manjaro-fix/main/install.sh | bash

  Manual Installation

  1. Clone this repository:
  git clone https://github.com/macawi-ai/claudia-manjaro-fix.git
  cd claudia-manjaro-fix

  2. Run the installation script:
  chmod +x install.sh
  ./install.sh

  3. Follow the prompts to set up your Claudia installation.

  What This Script Does

  - ✅ Detects Manjaro/Arch-based systems
  - ✅ Installs required system dependencies
  - ✅ Sets up WebKit compatibility environment variables
  - ✅ Creates convenient launch scripts
  - ✅ Adds shell aliases for easy access
  - ✅ Creates desktop entry

  Compatibility

  - Tested on: Manjaro Linux with KDE Plasma
  - Should work on: Arch Linux, EndeavourOS, and other Arch-based distributions
  - WebKit versions: 2.48.3+ (newer versions with compositing issues)

  Usage After Installation

  # Start development server
  claudia-dev

  # Or manually
  ./claudia-manjaro.sh dev

  # Build production version
  claudia-build

  Troubleshooting

  Still seeing white screen?

  - Ensure you're using the provided launch scripts
  - Check that WEBKIT_DISABLE_COMPOSITING_MODE=1 is set
  - Verify WebKit version: pacman -Q webkit2gtk-4.1

  Permission errors?

  - Ensure scripts are executable: chmod +x *.sh
  - Check that your user can access the Claudia directory

  Contributing

  If you encounter issues on other distributions or have improvements, please:
  1. Fork this repository
  2. Create a feature branch
  3. Submit a pull request

  Related Issues

  - https://github.com/tauri-apps/tauri/issues
  - https://webkit.org/

  Credits

  This solution was developed through collaborative debugging and testing. Special thanks to the
  open-source community for sharing knowledge about WebKit compatibility issues.

  License

  Licensed under the Apache License, Version 2.0. See LICENSE for details.

  Contact

  Jamie SakerEmail: mailto:jamie.saker@macawi.aiCompany: Macawi

  For support or questions about this fix, please open an issue on GitHub.

