#!/bin/bash
# Uninstaller for Claudia Manjaro fix by Jamie Saker <jamie.saker@macawi.ai>

echo "🗑  Uninstalling Claudia Manjaro compatibility setup..."
echo "Fix originally by: Jamie Saker <jamie.saker@macawi.ai> (Macawi)"
rm -f ~/.local/share/applications/claudia.desktop
sed -i '/# Claudia Manjaro aliases (Jamie Saker\/Macawi)/,+3d' "$SHELL_RC" 2>/dev/null || true
echo "✅ Uninstall complete"
echo "💡 Claudia directory preserved at: $CLAUDIA_DIR"
