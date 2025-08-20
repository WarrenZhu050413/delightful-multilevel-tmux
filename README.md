# Delightful Multilevel Tmux (DMT)

## Hi! Welcome to DMT :)

This has been a labor of love to create the tmux that I always wanted. I hope you enjoy it too :).

## Why I created this

I love Tmux. I love splitting panes and creating new sessions. But I find that I often need nested tmux so that I can let my tmux sessions reflect how my mind works. I like zooming in and out using `<prefix> z` in tmux. But I find that I often want to zoom into another nested session. For example, I want a session where I both have A) a claude code session open, and B) a vim session that looks at various files. Hence, delightful-multi-level-tmux was born!

I really hope that using this can be fun and joyful, that it could unlock a new dimension of tmux that you have not considered before. It did at least for me!

## Implementation

There are many ways of implementing this. I ended up settling on using tmux options + tmux key tables for its simplicity. We have two key tables: The `root` key table and the `off` key table, and two option states: the global @active_state, and the session-local @session_state.

@active_state is changed by the script `tmux-goto-level {level: int}`. @session_state is set at creation by the script `tmux_start_level {level:int}`.

Whenever tmux-goto-level changes @active_state, it also scans through all current sessions to see whether @active_state equals @session_state. If there is a match, then it assigns it to the root key-table and sets its prefix to C-x. Else, their prefix is set to C-a. This enables tmux prefixes addressed to an active session to pass through the inactive sessions!

The key logic is in [tmux-goto-level](https://github.com/WarrenZhu050413/delightful-multilevel-tmux/blob/main/scripts/tmux-goto-level):

```bash
    # Process each session
    while IFS= read -r session_name; do
        # Skip if session_name is empty
        [[ -n "$session_name" ]] || continue
        
        # Get this session's level identity
        local session_level
        session_level=$(detect_session_level "$session_name")
        
        if [[ $session_level -eq $target_level ]]; then
            # ACTIVATE: This session should respond to tmux commands
            if tmux set-option -t "$session_name" prefix C-x 2>/dev/null && \
               tmux set-option -t "$session_name" key-table root 2>/dev/null; then
                ((activated_count++))
            fi
        else
            # PASSTHROUGH: This session uses Ctrl-A prefix to avoid conflicts
            if tmux set-option -t "$session_name" prefix C-a 2>/dev/null && \
               tmux set-option -t "$session_name" key-table off 2>/dev/null; then
                ((passthrough_count++))
            fi
        fi
    done < <(tmux list-sessions -F '#S' 2>/dev/null || true)
```

## 🎬 Quick Demo

**Video**: [Watch DMT in Action](https://github.com/WarrenZhu050413/delightful-multilevel-tmux/blob/main/media/DMT_Demo_LQ.mp4?raw=true)

![DMT Nested Sessions](media/DMT_Nest.png)

**Visual Status**:
```
Active:      [myproject:L3 ✓] [●●●○○○○○○] | 2:34pm
Passthrough: [backend:L2→L3] [●●●○○○○○○] | 2:34pm  
Deep:        [prod:L8 ✓] [●●●●●●●●○] | 2:34pm
```

## ⚡ Installation

```bash
git clone https://github.com/WarrenZhu050413/delightful-multilevel-tmux.git
cd delightful-multilevel-tmux
./install.sh
```

That's it! DMT is now installed with Ctrl+X as the prefix.

## 🚀 Quick Start

### Navigate 9 Levels
```bash
Ctrl+X !  → Level 1        Ctrl+X ^  → Level 6
Ctrl+X @  → Level 2        Ctrl+X &  → Level 7
Ctrl+X #  → Level 3        Ctrl+X *  → Level 8
Ctrl+X $  → Level 4        Ctrl+X (  → Level 9
Ctrl+X %  → Level 5

Ctrl+V    → Next level     Ctrl+B    → Previous level
```

### Create Level-Aware Sessions
```bash
tmux-start-level 2 -s backend   # Start at Level 2
tmux-start-level 3 -s frontend  # Start at Level 3
```

### Git Worktree Magic (NEW!)
```bash
worktree-tmux experiment   # Creates 4 worktrees in 2x2 layout
```
Perfect for parallel development with AI assistants!

## 📖 Documentation

- **[Usage Guide](docs/USAGE.md)** - Complete navigation and commands
- **[Customization](docs/CUSTOMIZATION.md)** - Make it yours
- **[Worktree Integration](docs/WORKTREE.md)** - Git worktree workflows
- **[Troubleshooting](docs/TROUBLESHOOTING.md)** - Quick fixes
- **[Implementation](docs/IMPLEMENTATION.md)** - Technical details
- **[Reference](docs/REFERENCE.md)** - All commands and options
- **[Changelog](docs/CHANGELOG.md)** - Version history

## 🎯 Key Features

- **9-Level Navigation**: Seamlessly navigate nested tmux sessions
- **Smart Status Display**: Always know where you are
- **Session Isolation**: Each level operates independently
- **Git Worktree Integration**: 4 parallel workspaces in one command
- **Zero Dependencies**: Pure tmux and bash

## 🛠 Requirements

- tmux 2.1+
- bash
- `~/.local/bin` in PATH

## 🤝 Contributing

PRs welcome! See [docs/IMPLEMENTATION.md](docs/IMPLEMENTATION.md) for architecture details.

## 📜 License

MIT - See [LICENSE](LICENSE)

---

**Made with ❤️ for tmux power users**

*Quick help: Run `tmux-level-help` | Report issues: [GitHub](https://github.com/WarrenZhu050413/delightful-multilevel-tmux/issues)*