# 🚀 Delightful Multilevel Tmux

> *"I love tmux. But I love it even more when my tmux can branch into different workspaces, and branch within these workspaces. This is ultra-helpful when I'm using Claude Code or other CLI coding tools. The branching and exploratory nature allows me to think and explore thoughts and ideas quicker with much less friction. It makes programming so much more fun! 😊"*

Born from a love of **exploratory programming** and **frictionless thinking**, this is a sophisticated **9-level navigation system** for tmux that transforms how you navigate nested environments. Perfect for developers who think in branches, explore in parallel, and code with curiosity.

## ✨ Why You'll Love This

- **🌳 Think in Branches**: Create workspace hierarchies that match your thought process
- **⚡ Friction-Free Exploration**: Jump between contexts instantly - no mental overhead
- **🎯 Visual Wayfinding**: `[L3:X ●●●○○○○○○]` shows exactly where you are in your exploration
- **🚀 Perfect for Claude Code**: Seamlessly branch while coding with AI assistance
- **⌨️ Muscle Memory Friendly**: `Ctrl+X !@#$` - symbols in order, easy to remember
- **🔄 Flow State Navigation**: `Ctrl+V` (deeper) / `Ctrl+B` (back up) for natural movement
- **🆘 Never Get Lost**: Multiple escape routes - you can always find your way home
- **💾 Persistent Adventures**: Remembers where you were, even after tmux restarts
- **🌈 Depth Awareness**: Color coding warns when you're going deep (good for focus!)
- **🛠️ Yours to Shape**: Customize any key with simple find-and-replace

## 🎬 Quick Demo

```
Level 1: [L1:X ●○○○○○○○○] [ACTIVE] | 2:34pm
Level 3: [L3:X ●●●○○○○○○] [ACTIVE] | 2:34pm  
Level 7: [L7:X ●●●●●●●○○] [ACTIVE] | 2:34pm  (orange warning)
Level 9: [L9:X ●●●●●●●●●] [ACTIVE] | 2:34pm  (red warning)
```

## ⚡ Quick Installation

```bash
curl -fsSL https://raw.githubusercontent.com/[username]/delightful-multilevel-tmux/main/install.sh | bash
```

Or clone and install manually:
```bash
git clone https://github.com/[username]/delightful-multilevel-tmux.git
cd delightful-multilevel-tmux
./install.sh
```

## 📋 Setup Steps

1. **Install scripts** (done by install.sh):
   ```bash
   # Scripts are installed to ~/.local/bin/tmux-multilevel/
   ```

2. **Add to your tmux config**:
   
   Copy the multilevel section from `tmux.conf.example` to your `~/.tmux.conf`:
   
   ```bash
   # Copy everything between these markers:
   # ============================================================================
   # BEGIN MULTILEVEL NAVIGATION - COPY THIS SECTION TO YOUR ~/.tmux.conf  
   # ============================================================================
   # [paste here]
   # ============================================================================
   # END MULTILEVEL NAVIGATION
   # ============================================================================
   ```

3. **Reload tmux**:
   ```bash
   tmux source-file ~/.tmux.conf
   ```

4. **Test it works**:
   ```bash
   tmux-level-help
   ```

## 🎯 Usage

### Direct Level Jumps
```bash
Ctrl+X !    # Jump to Level 1 (outermost)
Ctrl+X @    # Jump to Level 2
Ctrl+X #    # Jump to Level 3
Ctrl+X $    # Jump to Level 4
Ctrl+X %    # Jump to Level 5
Ctrl+X ^    # Jump to Level 6
Ctrl+X &    # Jump to Level 7
Ctrl+X *    # Jump to Level 8
Ctrl+X (    # Jump to Level 9 (deepest)
```

### Sequential Navigation
```bash
Ctrl+V      # Go down one level (1→2→3...)
Ctrl+B      # Go up one level (9→8→7...)
```

### Emergency Escape
```bash
Ctrl+X !    # Always jumps to Level 1 (works from any level)
```

### Status Bar Formats
```bash
tmux-level-status --visual   # [L3:X ●●●○○○○○○] (default)
tmux-level-status --compact  # [L3:X]
tmux-level-status --full     # [L3:Ctrl+X]
tmux-level-status --minimal  # [3]
```

### Help Commands
```bash
tmux-level-help              # Show navigation help for current level
tmux-level-status --help     # Show status format options
tmux-level-reset            # Emergency reset to Level 1
```

## 🛠️ Common Customizations

Want different key bindings? Just change a few characters:

### Change Main Prefix (Ctrl+X → Ctrl+A)
```bash
# Find these lines in your ~/.tmux.conf:
unbind C-x
set -g prefix C-x
bind C-x send-prefix

# Change to:
unbind C-a
set -g prefix C-a  
bind C-a send-prefix
```

### Change Navigation Keys (Ctrl+V/B → Ctrl+J/K)
```bash
# Find these lines:
bind -T root C-v run-shell '~/.local/bin/tmux-multilevel/tmux-level-down'
bind -T root C-b run-shell '~/.local/bin/tmux-multilevel/tmux-level-up'

# Change to:
bind -T root C-j run-shell '~/.local/bin/tmux-multilevel/tmux-level-down'
bind -T root C-k run-shell '~/.local/bin/tmux-multilevel/tmux-level-up'
```

### Change Jump Symbols (!@# → 123)
```bash
# Find these lines:
bind ! run-shell '~/.local/bin/tmux-multilevel/tmux-goto-level 1'
bind @ run-shell '~/.local/bin/tmux-multilevel/tmux-goto-level 2'

# Change to:
bind 1 run-shell '~/.local/bin/tmux-multilevel/tmux-goto-level 1'  
bind 2 run-shell '~/.local/bin/tmux-multilevel/tmux-goto-level 2'
```

**That's it!** See [docs/CUSTOMIZATION.md](docs/CUSTOMIZATION.md) for more detailed customization examples.

## 📖 How It Works

This system uses **tmux key-tables** to create isolated navigation environments for each level:

- **Level 1**: Uses `root` key-table (your normal tmux)
- **Levels 2-9**: Each gets its own key-table (`level2`, `level3`, etc.)
- **State tracking**: Current level stored in tmux variables + filesystem
- **Visual feedback**: Status bar shows level + progress dots with color coding

## 🎛️ Available Scripts

| Script | Purpose |
|--------|---------|
| `tmux-goto-level` | Switch to specific level (1-9) |
| `tmux-level-up` | Move up one level with boundary handling |
| `tmux-level-down` | Move down one level with boundary handling |
| `tmux-level-status` | Format status bar indicator (4 formats) |
| `tmux-level-reset` | Emergency reset to Level 1 |
| `tmux-level-help` | Show navigation commands for current level |
| `tmux-add-level-bindings` | Apply key bindings to specific level (internal) |

## 🔧 Requirements

- **tmux 2.1+** (for advanced key-table support)
- **bash** (for scripts)
- **~/.local/bin in PATH** (automatic check during installation)

## 📁 File Locations

```
~/.local/bin/tmux-multilevel/     # All navigation scripts
~/.tmux_level_state              # Persistent level state (auto-created)
~/.tmux.conf                     # Your tmux config (you edit this)
```

## 🚨 Troubleshooting

### Can't Escape from Deep Levels
```bash
# Emergency escape options:
Ctrl+X !                         # Jump to Level 1
tmux-level-reset                 # Command line reset
tmux-level-help                  # Show escape commands
```

### Scripts Not Found
```bash
# Check if ~/.local/bin is in PATH:
echo $PATH | grep "$HOME/.local/bin"

# If not, add to ~/.bashrc or ~/.zshrc:
export PATH="$HOME/.local/bin:$PATH"
```

### Key Bindings Conflict
```bash
# Check existing bindings:
tmux list-keys | grep "your-key"

# See CUSTOMIZATION.md for conflict resolution
```

### Status Bar Not Updating
```bash
# Check status interval:
tmux show-options -g status-interval

# Test status script directly:  
tmux-level-status --visual
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Test your changes with the provided `tmux.conf.example`
4. Submit a pull request

## 📜 License

MIT License - see [LICENSE](LICENSE) file.

## 🙏 Acknowledgments

Inspired by the need for sophisticated tmux navigation in complex SSH environments and multi-level development workflows.

---

**Made with ❤️ for tmux power users**

*Need help? Open an issue or check the [troubleshooting guide](docs/CUSTOMIZATION.md#troubleshooting).*