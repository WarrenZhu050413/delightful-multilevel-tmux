# 🌳 Git Worktree Integration

## Overview

The `worktree-tmux` command creates 4 git worktrees in a beautiful 2x2 tmux layout, perfect for parallel development and experimentation. It's especially powerful when combined with AI-assisted coding tools like Claude Code.

## Why Worktree-Tmux?

### The Problem
When working on complex features or experimenting with different approaches, you often need:
- Multiple isolated branches for experimentation
- Quick switching between approaches
- Visual comparison of different implementations
- Safe exploration without affecting main branch

### The Solution
`worktree-tmux` provides:
- **4 isolated git worktrees** with their own branches
- **2x2 visual layout** for easy comparison
- **Automatic level management** for nested tmux sessions
- **Namespace organization** for related experiments

## Visual Layout

```
┌─────────────────────┬─────────────────────┐
│                     │                     │
│   Worktree 1        │   Worktree 2        │
│   Branch: proj-ns-1 │   Branch: proj-ns-2 │
│                     │                     │
├─────────────────────┼─────────────────────┤
│                     │                     │
│   Worktree 3        │   Worktree 4        │
│   Branch: proj-ns-3 │   Branch: proj-ns-4 │
│                     │                     │
└─────────────────────┴─────────────────────┘
```

## Usage

### Basic Syntax
```bash
worktree-tmux [namespace] [level]
```

### Parameters
- **namespace**: Optional identifier for grouping worktrees (default: timestamp)
- **level**: Optional tmux level (1-9). If omitted, auto-detects next level

### Examples

#### Auto Everything
```bash
worktree-tmux
# Creates: project-1234567890-{1,2,3,4} at next level
```

#### Named Namespace
```bash
worktree-tmux backend
# Creates: project-backend-{1,2,3,4} at next level
```

#### Explicit Level
```bash
worktree-tmux frontend 5
# Creates: project-frontend-{1,2,3,4} at Level 5
```

#### Multiple Experiments
```bash
worktree-tmux auth-oauth        # OAuth implementation
worktree-tmux auth-jwt          # JWT implementation
worktree-tmux auth-session      # Session-based auth
# Compare three different authentication approaches
```

## Claude Code Synergy

### Parallel AI Experiments
Perfect for exploring multiple AI-suggested implementations:

```bash
# Ask Claude Code to implement a feature 4 different ways
worktree-tmux ai-approaches

# Pane 1: Functional approach
# Pane 2: Object-oriented approach
# Pane 3: Optimized for performance
# Pane 4: Optimized for readability
```

### A/B Testing
```bash
worktree-tmux ab-test
# Pane 1-2: Approach A and variations
# Pane 3-4: Approach B and variations
```

### Incremental Development
```bash
worktree-tmux feature-stages
# Pane 1: Basic implementation
# Pane 2: Add error handling
# Pane 3: Add tests
# Pane 4: Add documentation
```

## Level Management

### Automatic Level Detection

When run **inside tmux**:
```bash
# Currently at Level 2
worktree-tmux backend
# → Creates session at Level 3
```

When run **outside tmux**:
```bash
worktree-tmux backend
# → Creates session at Level 1
```

### Manual Level Control
```bash
# Force specific level
worktree-tmux experiment 4
# → Always creates at Level 4
```

### Level Overflow Protection
```bash
# At Level 9 (maximum)
worktree-tmux deep
# → Error: Already at maximum depth
```

## Workflow Examples

### Example 1: Feature Development
```bash
# Main work at Level 1
tmux new -s main

# Create 4 backend variations at Level 2
worktree-tmux backend-apis

# Navigate between them
Ctrl+X @  # Jump to Level 2 (4 backends)
Ctrl+X !  # Back to Level 1 (main)

# Work in individual panes
# Top-left: REST API
# Top-right: GraphQL API
# Bottom-left: WebSocket API
# Bottom-right: gRPC API
```

### Example 2: Bug Fix Exploration
```bash
# Create space for debugging
worktree-tmux bugfix-memory-leak

# Each pane explores different hypothesis:
# 1. Check connection pooling
# 2. Review cache implementation
# 3. Analyze event listeners
# 4. Profile memory usage
```

### Example 3: Refactoring Strategies
```bash
# Compare refactoring approaches
worktree-tmux refactor-auth

# Pane 1: Minimal changes
# Pane 2: Extract service layer
# Pane 3: Full redesign
# Pane 4: Hybrid approach
```

## Branch Management

### Automatic Branch Creation
Each worktree gets its own branch:
```bash
worktree-tmux backend
# Creates branches:
# - project-backend-1
# - project-backend-2
# - project-backend-3
# - project-backend-4
```

### Existing Branches
If branches already exist, they're reused:
```bash
# First run
worktree-tmux feature
# Creates new branches

# Second run (branches exist)
worktree-tmux feature
# Reuses existing branches
```

## Clean Up

### Remove Worktrees
```bash
# List all worktrees
git worktree list

# Remove specific worktree
git worktree remove ../project-backend-1

# Remove all in namespace
for i in {1..4}; do
  git worktree remove "../project-backend-$i"
done
```

### Prune Stale Worktrees
```bash
# Clean up deleted worktrees
git worktree prune
```

## Best Practices

1. **Use descriptive namespaces**: `auth-methods`, `perf-tests`, `ui-layouts`
2. **Clean up after experiments**: Remove worktrees when done
3. **Commit valuable discoveries**: Don't lose good implementations
4. **Document findings**: Note which approach worked best
5. **Level awareness**: Keep related experiments at same level

## Tips and Tricks

### Quick Navigation
```bash
# Within the 2x2 layout
Ctrl+X h/j/k/l  # Vim-style pane movement
Ctrl+X z        # Zoom into one pane
Ctrl+X space    # Cycle pane layouts
```

### Status Identification
Each pane shows its branch in git status:
```bash
git status
# On branch project-backend-1
```

### Bulk Operations
```bash
# Run command in all worktrees
for i in {1..4}; do
  (cd "../project-backend-$i" && npm test)
done
```

### Integration with DMT Levels
```bash
# See current configuration
tmux list-sessions
# backend: Level 2 (your 4 worktrees)
# main: Level 1 (original work)

# Quick switching
Ctrl+X !  # Back to main work
Ctrl+X @  # Back to experiments
```

## Troubleshooting

### Session Already Exists
```bash
Error: tmux session 'project-backend' already exists
# Solution: Use different namespace or attach
tmux attach -t project-backend
```

### Worktree Already Exists
```bash
Error: '../project-backend-1' already exists
# Solution: Remove old worktree first
git worktree remove ../project-backend-1
```

### Not in Git Repository
```bash
Error: Not in a git repository
# Solution: Initialize git first
git init
```

## Advanced Usage

### Custom Layouts
After creation, adjust layout:
```bash
# Change from 2x2 to other layouts
Ctrl+X Meta+1  # Even horizontal
Ctrl+X Meta+2  # Even vertical
Ctrl+X Meta+5  # Tiled
```

### Scripted Setup
```bash
#!/bin/bash
# Create worktrees and set up each
worktree-tmux myfeature 3

# Wait for session
sleep 1

# Send commands to each pane
tmux send-keys -t myfeature.0 "npm install" Enter
tmux send-keys -t myfeature.1 "npm run dev" Enter
tmux send-keys -t myfeature.2 "npm test --watch" Enter
tmux send-keys -t myfeature.3 "git status" Enter
```