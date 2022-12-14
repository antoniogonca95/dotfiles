#!/bin/bash

GIT_ALIASES="
[alias]
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
    cma = commit --all --message
    cia = commit --amend
    rb = rebase 
    rbc = rebase --continue
    rba = rebase --abort
    r = reset
    rh = reset --hard
    pro = pull --rebase origin master
"

echo "$GIT_ALIASES" >> ~/.gitconfig

git config --global push.default current

cp ~/.dotfiles/.bash_aliases ~/.bash_aliases