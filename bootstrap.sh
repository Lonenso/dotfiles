#!/usr/bin/env bash
cd "${0/*}" || exit 1
echo "sync dotfiles..."
git pull origin main
function doIt() {
    for file in .{antigenrc,aliases,cheat.yml,env,exports,functions,gitconfig,gitignore,macos,tmux.conf,vimrc,zshrc}; do
        ln -sf "$(pwd)/${file}" "${HOME}/${file}"
    done;
    unset file;
    exec zsh
}
doIt
unset doIt
