# 🚀 Delightful Multilevel Tmux

## Hi! Welcome to delightful multi-level tmux 👋

This has been a labor of love to create the tmux that I always wanted. I hope you enjoy it too :)

## *"One tmux to rule them all"*

> *I love Tmux. I love splitting panes and creating new sessions. But I find that I often need nested tmux so that I can let my tmux sessions reflect how my mind works. I like zooming in and out using `<prefix> z` in tmux. But I find that I often want to zoom into another nested session. For example, I want a session where I both have A) a claude code session open, and B) a vim session that looks at various files. Hence, delightful-multi-level-tmux was born!*
>
> *I tried different ways of implementing this. Went into some bugs when I tried to make everything automatic. And figured that the easiest way is to let the user personally set the tmux levels with `tmux-start-level {num: int}`. I am sorry if this gives additional work for you! (tab autocomplete should make this less of a slog as it seems. You can also create your own alias to quickly start your new tmux session).*
>
> *I really hope that using this can be delightful, and unlock a new dimension of tmux that you have not considered before :). At least for me, this brings a lot of joy and happiness to my life. :)*

Born from a love of **mental model mapping** and **nested thinking**, this is a sophisticated **9-level navigation system** for tmux that transforms how you navigate nested environments. Perfect for developers who think in layers, need multiple contexts, and want their tools to match their cognitive flow.

## ✨ Why You'll Love This

- **🌳 Think in Branches**: Create workspace hierarchies that match your thought process
- **⚡ Friction-Free Exploration**: Jump between contexts instantly - no mental overhead
- **🎯 Visual Wayfinding**: `[L3:X ●●●○○○○○○]` shows exactly where you are in your exploration
- **🔀 Dual Prefix System**: Active sessions use `Ctrl+X`, inactive use `Ctrl+A` (no conflicts!)
- **🚀 Perfect for Claude Code**: Seamlessly branch while coding with AI assistance
- **⌨️ Muscle Memory Friendly**: `Ctrl+X !@#$` - symbols in order, easy to remember
- **🔄 Flow State Navigation**: `Ctrl+V` (deeper) / `Ctrl+B` (back up) for natural movement
- **🆘 Never Get Lost**: Multiple escape routes - you can always find your way home
- **💾 Persistent Adventures**: Remembers where you were, even after tmux restarts
- **🌈 Depth Awareness**: Color coding warns when you're going deep (good for focus!)
- **🛠️ Yours to Shape**: Customize any key with simple find-and-replace

## 🎬 Quick Demo

**Session-Aware Status Display (Latest):**
```
Active:     [myproject:L3 ✓] [●●●○○○○○○] | 2:34pm     (mint green)
Passthrough: [myproject:L2→L3] [●●●○○○○○○] | 2:34pm   (soft blue)
Deep Active: [work:L8 ✓] [●●●●●●●●○] | 2:34pm         (sage green)
```
- Shows session name and its level
- Active sessions show ✓, passthrough shows navigation arrow (L2→L3)
- Status bar updates only when THIS session's state changes (not globally)

**Perfect Nested Sessions & 9-Level Support (v2.0.0):**
- `tmux-start-level` now creates true hierarchical nesting
- Extended from 3 levels to full 9-level navigation
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
git clone https://github.com/[username]/delightful-multilevel-tmux.git
cd delightful-multilevel-tmux
./install.sh
```

**That's it!** Most of the information in this README is for reference - what you need to know is:

1. **Start a tmux session** normally
2. **Start a nested session** with `tmux-start-level` (e.g., `tmux-start-level 2`)
3. **Navigate between levels** with `Ctrl+X Shift+{number}` (when at global level) or `Ctrl+A Shift+{number}` (when at a nested level)

Hope you enjoy this as much as I do! 🎉

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

## 🔀 Dual Prefix System (NEW!)

**No more nested tmux conflicts!** Active and inactive sessions now use different prefixes:

- **Active sessions** (matching your navigation level): Use `Ctrl+X` prefix
- **Inactive/passthrough sessions**: Use `Ctrl+A` prefix

This means when you're in a Level 3 session inside a Level 2 session:
- Level 3 (active): `Ctrl+X v` splits the window in Level 3
- Level 2 (inactive): `Ctrl+A v` would split in Level 2 (if needed)
- No more commands getting intercepted by the wrong session!

## 🌳 Git Worktree Integration (NEW!)

**Introducing `worktree-tmux`** - A powerful companion command that creates 4 git worktrees in a 2x2 tmux layout, perfect for parallel development with Claude Code!

### Why This Is Amazing

- **🤖 Claude Code Synergy**: Perfect for AI-assisted parallel experimentation
- **🎯 Automatic Level Management**: Intelligently creates sessions at `current_level + 1`
- **🌲 Branch Isolation**: Each worktree gets its own branch for safe exploration
- **📐 2x2 Visual Layout**: Four workspaces that match how you think
- **🏷️ Namespace Organization**: Group related experiments with meaningful names

### Quick Example

```bash
# Inside a Level 3 tmux session, working on a feature
worktree-tmux backend       # Creates Level 4 session with 4 backend worktrees

# The result: A 2x2 grid at Level 4
┌─────────────────────┬─────────────────────┐
│ backend-1 (branch)  │ backend-2 (branch)  │
├─────────────────────┼─────────────────────┤
│ backend-3 (branch)  │ backend-4 (branch)  │
└─────────────────────┴─────────────────────┘
```

### Usage

```bash
worktree-tmux [namespace] [level]

# Examples:
worktree-tmux                    # Auto-named with timestamp, auto level
worktree-tmux experiment         # Named "experiment", auto level (current + 1)
worktree-tmux frontend 5         # Named "frontend", explicit Level 5
```

### Perfect Claude Code Workflow

1. **Start your main work** at Level 2
2. **Need to explore an idea?** Run `worktree-tmux experiment`
3. **Automatically get** Level 3 session with 4 isolated branches
4. **Ask Claude** to try different approaches in each worktree
5. **Compare results** side-by-side in the 2x2 layout
6. **Cherry-pick the best** solution back to your main branch

### How It Respects Multilevel Navigation

- **Smart Level Detection**: Reads your current tmux level
- **Automatic Increment**: New session is always `current_level + 1`
- **No Manual Setup**: Unlike `tmux-start-level`, no level parameter needed
- **Proper Nesting**: Maintains the hierarchical tmux structure
- **Navigation Ready**: Use `Ctrl+X` shortcuts to jump between levels

## 🎯 New Workflow

### **1. Start Sessions with Level Identity**
```bash
# Auto-increment from parent (NEW!)
tmux-start-level                            # Auto-selects next level (parent + 1)
tmux-start-level -s project                 # Auto-level with session name

# Manual level selection
tmux-start-level 2                          # Basic Level 2 session
tmux-start-level 3 -s project               # Named Level 3 session  
tmux-start-level 2 -s work -c ~/projects    # Level 2, named, specific directory
tmux-start-level 4 -d -s background         # Level 4, detached session
tmux-start-level 9 -s deep                  # Level 9, deepest session
```

**Auto-increment logic:**
- From session with no level (L0) → Creates L1
- From L1 session → Creates L2
- From L9 session → Creates L1 (wraps around)

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
Ctrl+V      # Go down one level (1→2→3...→9→1...)
Ctrl+B      # Go up one level (9→8→7...→1→9...)
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
| `worktree-tmux` | Create 4 git worktrees in 2x2 tmux layout at next level |

## 🔧 Requirements

- **tmux 2.1+** (for advanced key-table support)
- **bash** (for scripts)
- **~/.local/bin in PATH** (automatic check during installation)

## 🆕 What's New in v2.0.0

### 🎯 Extended to 9-Level System
- **Enhancement**: Expanded from 3-level to full 9-level navigation support
- **Architecture**: All scripts now support levels 1-9 with proper validation  
- **Keybindings**: Added Ctrl+X $%^&*( for levels 4-9
- **Sequential Navigation**: Improved wrapping with mathematical formulas instead of hardcoded cases
- **Visual Status**: Status bar dots now show all 9 levels (●●●●●○○○○)

### 🧮 Mathematical Navigation Logic
- **tmux-level-down**: `(current % 9) + 1` for 1→2→3...→9→1 wrapping
- **tmux-level-up**: `((current-2+9) % 9) + 1` for 9→8→7...→1→9 wrapping
- **Result**: Seamless navigation through all 9 levels without edge cases

## 🎉 What's New in v1.1.0

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