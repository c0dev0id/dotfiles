#!/bin/sh

git_pull() {(
    cd "$1"
    git pull
)}

git_push() {(
    cd "$1"
    git add *
    git commit -m "Calendar Update $(date)"
    git push
)}

git_pull personal
git_pull uugrn

F="$(find . \
    -mindepth 1 \
    -not -path "*/.git/*" \
    -not -name "100-*" \
    -type f \
    -name "*.rem" \
        | fzf)"

[ ! -z "$F" ] && vim "$F"

git_push personal
git_push uugrn
