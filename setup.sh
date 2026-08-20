#!/bin/bash

GIT_ALIASES="
[alias]
    l = log
    f = fetch
    p = pull
    ps = push
    st = status
    co = checkout
    br = branch
    ci = commit
    cp = cherry-pick
    ap = add -p
    aa = add -A
    cm = commit -m
    fixup = commit --amend --no-edit
    cm = commit --message
    cma = commit --all --message
    cia = commit --amend
    rb = rebase 
    rbc = rebase --continue
    rba = rebase --abort
    r = reset
    rh = reset --hard
    pro = pull --rebase origin master
    confs = diff --name-only --diff-filter=U
"

echo "$GIT_ALIASES" >> ~/.gitconfig

git config --global push.default current

echo "alias g='git'" >> ~/.bash_aliases
source ~/.bashrc

# Claude Code project memory lives in the workspace, which is recreated each time,
# so seed it from the dotfiles copy. -n keeps any memory updated during a session.
CLAUDE_MEMORY_SRC="$HOME/.config/coderv2/dotfiles/claude-memory"
CLAUDE_MEMORY_DIR="$HOME/.claude/projects/-workspaces-shares/memory"
if [ -d "$CLAUDE_MEMORY_SRC" ]; then
  mkdir -p "$CLAUDE_MEMORY_DIR"
  cp -n "$CLAUDE_MEMORY_SRC"/*.md "$CLAUDE_MEMORY_DIR/" 2>/dev/null || true
fi
