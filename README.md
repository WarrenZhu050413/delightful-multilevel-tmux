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

**Session-Aware Status Display (v1.1.0):**
```
Active:     [coupling:L3 ✓] [●●●○○○○○○] [ACTIVE] | 2:34pm     (mint green)
Passthrough: [tmux:Nav:L3|Session:L2] [●●●○○○○○○] [ACTIVE] | 2:34pm (soft blue)
Deep Active: [work:L8 ✓] [●●●●●●●●○] [ACTIVE] | 2:34pm     (sage green)
```

**Perfect Nested Sessions (v1.1.0):**
- `tmux-start-level` now creates true hierarchical nesting
- Each session contains the next level naturally
- No more client switching - proper session containment

**Workflow Example:**
```bash
# 1. Start Level 2 session
tmux-start-level 2 -s project

# 2. Navigate to Level 2 (activates this session)
Ctrl+X @  → [Level:L2 ✓] [●●○○○○○○○]

# 3. Create panes normally (works because levels match)
Ctrl+X v  → split-window works!
Ctrl+X s  → split-window works!

# 4. Navigate to Level 3 (this session becomes passthrough) 
Ctrl+X #  → [Nav:L3|Session:L2] [●●●○○○○○○]
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

4. **Test the new workflow**:
   ```bash
   # Test helper script
   tmux-start-level --help
   
   # Test navigation
   tmux-level-help
   
   # Test status display
   tmux-level-status --visual
   ```

## 🎯 New Workflow

### **1. Start Sessions with Level Identity**
```bash
tmux-start-level 2                          # Basic Level 2 session
tmux-start-level 3 -s project               # Named Level 3 session  
tmux-start-level 2 -s work -c ~/projects    # Level 2, named, specific directory
tmux-start-level 4 -d -s background         # Level 4, detached session
```

### **2. Navigate to Target Level**
```bash
Ctrl+X !    # Activate Level 1 (outermost)
Ctrl+X @    # Activate Level 2
Ctrl+X #    # Activate Level 3
Ctrl+X $    # Activate Level 4
Ctrl+X %    # Activate Level 5
Ctrl+X ^    # Activate Level 6
Ctrl+X &    # Activate Level 7
Ctrl+X *    # Activate Level 8
Ctrl+X (    # Activate Level 9 (deepest)
```

### **3. Understand Session States**
- **Active**: `[Level:L3 ✓]` - Your session controls tmux (create panes, windows, etc.)
- **Passthrough**: `[Nav:L3|Session:L2]` - Your session is transparent (commands pass through)

### **4. Sequential Navigation**
```bash
Ctrl+V      # Go down one level (1→2→3...)
Ctrl+B      # Go up one level (9→8→7...)
```

### **5. Status Bar Formats**
```bash
tmux-level-status --visual   # [Level:L3 ✓] [●●●○○○○○○] (default)
tmux-level-status --compact  # [Level:L3 ✓] or [Nav:L3|Session:L2]
tmux-level-status --full     # [Level:L3:Ctrl+X ✓] or [Nav:L3:Ctrl+X|Session:L2]
tmux-level-status --minimal  # [3✓] or [3|2]
```

### **6. Help Commands**
```bash
tmux-start-level --help      # Show session creation options
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

## 🆕 What's New in v1.1.0

### 🎯 Session-Specific Status Lines
- **Problem**: Multiple sessions shared global status, showed wrong names on restart
- **Solution**: Each session now has its own status line with correct session name
- **Benefit**: `[coupling:L2 ✓]` vs `[tmux:L1 ✓]` - always shows the right context

### 🌳 True Nested Sessions  
- **Problem**: `tmux-start-level` switched clients instead of creating hierarchy
- **Solution**: Now creates proper nested sessions within current tmux context
- **Benefit**: True containment - Level 2 lives inside Level 1, Level 3 inside Level 2

### 🔧 Simplified Architecture
- **Removed**: Complex detached session logic, kill/switch client code  
- **Added**: Direct `tmux new-session` with command chaining
- **Result**: More reliable, fewer edge cases, cleaner code

### 🐛 Bug Fixes
- Fixed: Sessions exiting immediately when created inside tmux
- Fixed: Status lines showing wrong session names after restart
- Fixed: Client switching breaking session hierarchy

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

# Test session-specific status:
TMUX_SESSION=mysession tmux-level-status --compact
```

### Nested Sessions Not Working (v1.1.0+)
```bash
# Verify session hierarchy:
tmux list-sessions

# Check if session has proper level set:
tmux show-option -t session_name @session_level

# Test nested creation manually:
tmux new-session -s test \; set-option @session_level "2"
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