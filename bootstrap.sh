#!/usr/bin/env bash
cd "${0/*}" || exit 1
echo "sync dotfiles..."
git pull origin main
function doIt() {
    for file in .{antigenrc,aliases,exports,functions,gitconfig,gitignore,tmux.conf,vimrc,gvimrc,zshrc,git-commit-template.txt,clash-config.yaml}; do
        ln -sf "$(pwd)/${file}" "${HOME}/${file}"
    done;
    unset file;
    exec zsh
}
doIt
unset doIt
