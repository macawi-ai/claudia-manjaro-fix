# Development Guide

This guide is for developers and contributors working on the claudia-manjaro-fix project.

## Development Tools

### Validation System

The project includes comprehensive validation tools to ensure script quality and prevent common issues:

#### Built-in Validation
```bash
./install.sh --validate
```
- Quick syntax and structure checking
- Validates heredoc block balance
- Checks for unquoted heredoc markers
- Built into the installation script

#### Development Validation
```bash
./dev-check.sh
```
- Comprehensive script analysis
- Colorized output for better readability
- Checks for common bash scripting issues
- Validates all EOF markers and heredoc blocks
- Detects development notes (TODO, FIXME, XXX)
- Tests built-in validation

#### Pre-commit Hooks
```bash
# Install optional pre-commit validation
cp pre-commit-hook .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```
- Automatically runs validation before git commits
- Prevents commits with validation failures
- Can be bypassed with `git commit --no-verify` if needed

## Development Workflow

### Before Making Changes
1. Run validation to check current state:
   ```bash
   ./dev-check.sh
   ```

### During Development
1. Use quick syntax checks:
   ```bash
   ./install.sh --validate
   ```

2. Test your changes frequently
3. Follow existing code style and patterns

### Before Committing
1. Run comprehensive validation:
   ```bash
   ./dev-check.sh
   ```

2. Fix any issues found
3. Ensure all critical checks pass
4. Review any warnings

### Git Hooks (Optional)
Install pre-commit hooks for automatic validation:
```bash
cp pre-commit-hook .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

## Validation Features

### Bash Syntax Checking
- Ensures script executes without syntax errors
- Uses `bash -n` for non-destructive syntax validation

### Heredoc Validation
- Checks for balanced EOF markers
- Validates proper quoting to prevent variable expansion issues
- Detects common heredoc formatting problems

### Common Issue Detection
- Missing or incorrect shebang
- Unintended `set -e` usage
- Variable expansion in heredocs (warns if unintentional)
- File permissions issues

### Development Notes
- Detects TODO, FIXME, and XXX comments
- Helps track development tasks and known issues

## File Structure

```
claudia-manjaro-fix/
├── install.sh              # Main installation script with built-in validation
├── dev-check.sh            # Comprehensive development validation tool
├── pre-commit-hook         # Optional git pre-commit hook
├── README.md               # Main documentation
├── INSTALL.md              # Installation guide
├── TROUBLESHOOTING.md      # Troubleshooting guide
├── CHANGELOG.md            # Version history
├── DEVELOPMENT.md          # This file
└── LICENSE                 # Apache 2.0 license
```

## Common Development Tasks

### Adding New Features
1. Update install.sh with new functionality
2. Run validation: `./dev-check.sh`
3. Test thoroughly on Manjaro systems
4. Update documentation
5. Update CHANGELOG.md

### Fixing Issues
1. Identify the problem
2. Run validation to check for syntax issues
3. Implement fix
4. Validate changes
5. Test with various scenarios

### Updating Documentation
1. Update relevant .md files
2. Ensure examples are current
3. Test any code examples provided

## Testing

### Manual Testing
- Test on clean Manjaro installation
- Test with existing Claudia installations
- Test all build options (dev, build, build-exe, build-full)
- Test production launcher script (launch-production.sh)
- Test error conditions and edge cases

### Testing Production Builds
After building with `build-exe` or `build-full`:
```bash
# Test the production launcher
./launch-production.sh

# Verify it sets WebKit environment variables
# The launcher should display the variables being set

# DO NOT test by running the executable directly as it will show black screen:
# ./src-tauri/target/release/claudia  # Will fail!
```

### Validation Testing
```bash
# Test validation tools themselves
./install.sh --validate
./dev-check.sh

# Test with intentionally broken script
# (temporarily introduce syntax errors to verify detection)
```

## Code Style Guidelines

### Bash Scripting
- Use proper error handling (avoid `set -e`)
- Quote variables and paths appropriately
- Use descriptive function and variable names
- Include helpful comments
- Follow existing indentation patterns

### Heredoc Blocks
- Always quote EOF markers unless variable expansion is needed
- Use consistent EOF marker naming
- Ensure proper indentation within heredoc content
- Balance all heredoc blocks

### Error Messages
- Provide clear, actionable error messages
- Include relevant troubleshooting hints
- Use emoji for visual clarity (✅ ❌ ⚠️ 💡)

## Contributing

1. Fork the repository
2. Create a feature branch
3. Follow the development workflow above
4. Run validation tools
5. Test thoroughly
6. Submit a pull request with detailed description

## Support

For development questions:
- Review existing code and documentation
- Check TROUBLESHOOTING.md for common issues
- Open an issue on GitHub for bugs or feature requests
- Contact: jamie.saker@macawi.ai

## License

This project is licensed under the Apache License 2.0. See LICENSE for details.