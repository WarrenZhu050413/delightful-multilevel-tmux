# 🔧 Technical Implementation

## Architecture Overview

Delightful Multilevel Tmux uses tmux's native features to create a sophisticated navigation system without external dependencies. The implementation leverages:

- **tmux options**: For state tracking (`@active_level` and `@session_level`)
- **tmux key-tables**: For input isolation (`root` and `off` tables)
- **Dynamic prefix switching**: Between `C-x` (active) and `C-a` (passthrough)

## Core Concepts

### State Variables

1. **Global State**: `@active_level`
   - Tracks which level should be active across all sessions
   - Changed by `tmux-goto-level` script
   - Persisted to `~/.tmux_level_state` for session recovery

2. **Session State**: `@session_level`
   - Each session's identity (which level it belongs to)
   - Set at creation by `tmux-start-level`
   - Immutable for the session's lifetime

### Key Tables

- **`root` table**: Normal tmux operation with all bindings active
- **`off` table**: Minimal bindings, most keys pass through to child

### Prefix Management

- **Active sessions** (`C-x`): Respond to tmux commands
- **Passthrough sessions** (`C-a`): Transparent to child sessions

## The Key Algorithm

The core logic in `tmux-goto-level` that makes everything work:

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

## Why Both Prefix and Key-Table?

This dual mechanism ensures complete isolation:

1. **Prefix alone isn't enough**: Setting `prefix C-a` only changes the activation key. The session still has all its keybindings active in the root table (C-v, C-b, mouse events, etc.)

2. **Key-table alone isn't enough**: Even with `key-table off`, the session would still respond to its original prefix key.

3. **Together they provide**: 
   - Passthrough sessions don't intercept `C-x` (different prefix)
   - Passthrough sessions don't intercept navigation keys (off table)
   - Only explicitly added bindings in `off` table work (C-v/C-b for navigation)

## Session Lifecycle

### Creation
```bash
tmux-start-level 3 -s myproject
```
1. Creates new session with `@session_level=3`
2. If level 3 is active, sets `prefix=C-x`, `key-table=root`
3. Otherwise sets `prefix=C-a`, `key-table=off`

### Navigation
```bash
Ctrl+X #  # Jump to level 3
```
1. `tmux-goto-level 3` runs
2. Updates global `@active_level=3`
3. Scans all sessions:
   - Sessions with `@session_level=3` → Activate
   - All other sessions → Passthrough

### State Persistence
- Level state saved to `~/.tmux_level_state`
- Session hook restores state on new sessions
- Survives tmux server restarts

## Mathematical Navigation

The sequential navigation uses modular arithmetic for seamless wrapping:

### Level Down (C-v)
```bash
new_level=$(( (current_level % 9) + 1 ))
```
- 1→2, 2→3, ..., 8→9, 9→1

### Level Up (C-b)
```bash
new_level=$(( ((current_level - 2 + 9) % 9) + 1 ))
```
- 9→8, 8→7, ..., 2→1, 1→9

## File System Layout

```
~/.local/bin/tmux-multilevel/
├── tmux-goto-level          # Core navigation logic
├── tmux-level-up            # Sequential up navigation
├── tmux-level-down          # Sequential down navigation
├── tmux-level-status        # Status bar formatting
├── tmux-level-help          # Context-aware help
├── tmux-level-reset         # Emergency reset
├── tmux-add-level-bindings  # Apply bindings to tables
├── tmux-start-level         # Session creation
└── worktree-tmux           # Git worktree integration

~/.tmux_level_state          # Persistent state file
~/.tmux.conf                 # User configuration
```

## Performance Considerations

- **Lightweight**: No background processes or polling
- **Event-driven**: Changes only when user navigates
- **Minimal overhead**: Uses native tmux features
- **Fast switching**: Direct tmux commands, no external scripts in hot path

## Security Notes

- Scripts use proper quoting and error handling
- No eval or dynamic code execution
- Validates all input (level must be 1-9)
- Graceful fallback on errors

## Extension Points

The architecture allows for easy extensions:

1. **More levels**: Change `@max_levels` and add bindings
2. **Different keys**: Modify bindings in tmux.conf
3. **Custom status**: Edit `tmux-level-status` formats
4. **Integration**: Read `@active_level` and `@session_level` from your scripts