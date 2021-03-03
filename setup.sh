#! /bin/sh

# Fail script if any command fails
set -e

## keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
## echo an error message before exiting
trap 'echo "\"${last_command}\" command failed with exit code $?."' EXIT

# Setup dotfiles directories ###

mkdir -p ~/.cache/nvim/undo
# Configure for ZSH
rm -f ~/.zshrc
rm -f ~/.p10k.zsh
rm -f ~/.zshenv
rm -f ~/.profile
stow --dotfiles zshrc

# stow --dotfiles bash
stow --dotfiles vim
stow --dotfiles config
stow --dotfiles local
stow --dotfiles tmux
stow --dotfiles mutt
rm -rf ~/.i3
stow --dotfiles i3

### Configure Shell snippets ###

# Have to run stow on shell_snippets after we have set them up with antibody
stow --dotfiles shell_snippets

# Prepare a vimrc file in ~/.config/nvim folder
ln -sf ~/.config/nvim/init.vim ~/.vimrc

# nvim +PluginInstall +qall
# gvim +PluginInstall +qall
