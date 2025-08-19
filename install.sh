#!/bin/bash
# Delightful Multilevel Tmux - Simple Installer
# Only installs scripts - user handles tmux config manually

set -e

echo "🚀 Installing Delightful Multilevel Tmux scripts..."

# Check if tmux is installed
if ! command -v tmux &> /dev/null; then
    echo "❌ tmux is not installed. Please install tmux first."
    exit 1
fi

# Check tmux version (need 2.1+)
TMUX_VERSION=$(tmux -V | cut -d' ' -f2 | tr -d '[:alpha:]')
if [[ $(echo "$TMUX_VERSION 2.1" | tr " " "\n" | sort -V | head -n1) != "2.1" ]]; then
    echo "⚠️  tmux version $TMUX_VERSION detected. Version 2.1+ recommended for full functionality."
fi

# Create scripts directory
echo "📁 Creating ~/.local/bin/tmux-multilevel/"
mkdir -p ~/.local/bin/tmux-multilevel

# Copy all scripts
echo "📋 Copying scripts..."
cp scripts/* ~/.local/bin/tmux-multilevel/
chmod +x ~/.local/bin/tmux-multilevel/*

# Check if ~/.local/bin and ~/.local/bin/tmux-multilevel are in PATH
PATH_WARNING=""
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    PATH_WARNING="~/.local/bin"
fi

if [[ ":$PATH:" != *":$HOME/.local/bin/tmux-multilevel:"* ]]; then
    if [[ -n "$PATH_WARNING" ]]; then
        PATH_WARNING="$PATH_WARNING and ~/.local/bin/tmux-multilevel"
    else
        PATH_WARNING="~/.local/bin/tmux-multilevel"
    fi
fi

if [[ -n "$PATH_WARNING" ]]; then
    echo ""
    echo "⚠️  $PATH_WARNING not in your PATH"
    echo "   Add this to your ~/.bashrc or ~/.zshrc:"
    echo "   export PATH=\"\$HOME/.local/bin/tmux-multilevel:\$HOME/.local/bin:\$PATH\""
    echo ""
fi

echo "✅ Scripts installed successfully!"
echo ""
echo "📋 NEXT STEPS:"
echo "1. 📄 Copy sections from 'tmux.conf.example' to your ~/.tmux.conf"
echo "2. 🔄 Reload: tmux source-file ~/.tmux.conf"  
echo "3. 🧪 Test: tmux-level-help"
echo ""
echo "🌳 NEW: Try 'worktree-tmux' for git worktree + multilevel tmux magic!"
echo "   Perfect for parallel development with Claude Code!"
echo ""
echo "📖 See README.md for detailed instructions and customization guide"
echo "🔧 See docs/CUSTOMIZATION.md for adapting to your existing setup"
echo ""
echo "🎉 Happy multilevel tmux navigation!"