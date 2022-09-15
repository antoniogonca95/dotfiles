#!/bin/bash

GIT_ALIASES="
[alias]
    l = log
    l = log
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
    cma = commit --message --all
    cia = commit --amend
    rc = rebase --continue
    ra = rebase --abort
    rh = reset --hard
    pro = pull --rebase origin master
"

echo "$GIT_ALIASES" >> ~/.gitconfig

git config --global push.default current

cp ~/.dotfiles/.bash_aliases ~/.bash_aliases