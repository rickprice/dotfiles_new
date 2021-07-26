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
rm -rf ~/.config/mimeapps.list
stow --dotfiles config
stow --dotfiles local
stow --dotfiles tmux
stow --dotfiles mutt
stow --dotfiles weechat

### Configure Shell snippets ###

# Have to run stow on shell_snippets after we have set them up with antibody
stow --dotfiles shell_snippets

# Prepare a vimrc file in ~/.config/nvim folder
ln -sf ~/.config/nvim/init.vim ~/.vimrc

# Configure GH files
USER=$(pass show gh/gihtub/user)
OAUTH_TOKEN=$(pass show gh/gihtub/oauth_token)
PROTOCOL=$(pass show gh/gihtub/git_protocol)
# OAUTH_TOKEN=thisisatest

cat >~/.config/gh/hosts.yml <<End-of-message
github.com:
    user: rickprice
    oauth_token: $OAUTH_TOKEN
    git_protocol: ssh
End-of-message

git config --global github.user rickprice

# nvim +PluginInstall +qall
# gvim +PluginInstall +qall

exit 0
