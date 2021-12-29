#!/usr/bin/env bash

# Install brew first.

if ! command -v brew; then 
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi 

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed 

# Install more recent versions of some macOS tools.
brew install vim 

brew install xz

brew install git
brew install tree
# Install some env manager
brew install jenv 
brew install rbenv 

# Install some command-line parser tool
brew install jq 
brew install yq 

# Install some useful binaries
brew install fzf 
brew install ripgrep
brew install shellcheck
brew install tldr 
brew install sqlite 
brew install proxychains-ng
brew install oath-toolkit
brew install tmux
brew install zsh-autosuggestions zsh-syntax-highlighting z

# useful app
brew install mos
brew install --cask goldendict


# Remove outdated versions from the cellar.
brew cleanup
