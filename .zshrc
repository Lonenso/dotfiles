ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=() 

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{exports,aliases,functions,env,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
