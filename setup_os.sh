#! /bin/bash

# Fail script if any command fails
set -e

## keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
## echo an error message before exiting
trap 'echo "\"${last_command}\" command failed with exit code $?."' EXIT

#Setup Packages for Arch

## Upgrade everything
sudo pacman --noconfirm -Syu

# Install Yay
sudo pacman --noconfirm -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
pushd .
cd yay
makepkg -si
popd

## Install Main packages I want
sudo pacman --noconfirm -S base-devel
sudo pacman --noconfirm -S stow
sudo pacman --noconfirm -S python
sudo pacman --noconfirm -S python-pip
sudo pacman --noconfirm -S figlet
sudo pacman --noconfirm -S fd
sudo pacman --noconfirm -S tmux
sudo pacman --noconfirm -S zip
sudo pacman --noconfirm -S unzip
sudo pacman --noconfirm -S tlp tlp-rdw acpi_call

## Update everything in the AUR
yay --noconfirm -Syu

## Install AUR packages I want
yay --noconfirm -S neovim-nightly-bin
yay --noconfirm -S discord
yay --noconfirm -S slack-desktop
yay --noconfirm -S poppler
yay --noconfirm -S pdfjam
yay --noconfirm -S pass
yay --noconfirm -S udiskie
yay --noconfirm -S remmina
yay --noconfirm -S freerdp
yay --noconfirm -S go
yay --noconfirm -S zoom
yay --noconfirm -S neomutt
yay --noconfirm -S hub
yay --noconfirm -S x11-ssh-askpass
yay --noconfirm -S mosh
yay --noconfirm -S timeshift
yay --noconfirm -S timeshift-autosnap
yay --noconfirm -S firefox-developer-edition
yay --noconfirm -S weechat-git
yay --noconfirm -S googler
yay --noconfirm -S so
yay --noconfirm -S luakit-git
yay --noconfirm -S fwupd
yay --noconfirm -S bazelisk-bin
yay --noconfirm -S meld
yay --noconfirm -S aws-cli
yay --noconfirm -S postgresql-libs # Needed for ActiveState BE tools
yay --noconfirm -S python-psycopg2 # Needed for DA importer go utilities
yay --noconfirm -S python-pipenv # Needed for BE tools
yay --noconfirm -S pyenv # Needed for BE tools
# yay --noconfirm -S nerd-fonts-complete
yay --noconfirm -S wezterm-git
yay --noconfirm -S ttf-iosevka-git

# Photographic processing
yay --noconfirm -S rawtherapee
yay --noconfirm -S gimp
yay --noconfirm -S perl-image-exiftool
yay --noconfirm -S nomacs

# Moving files to and from DropBox
yay --noconfirm -S rclone

# For handling Magnet and BitTorrent links
yay --noconfirm -S tixati

# Ensure we have my favourite file manager and the thumbnailers it needs
yay --noconfirm -S pcmanfm tumbler poppler-glib ffmpegthumbnailer freetype2 libgsf raw-thumbnailer ufraw-thumbnailer

# EBook support
yay --noconfirm -S calibre

## Required for initial_setup.py
# PyYaml is pulled in automatically via udiskie and it conflicts with the Pip version
# sudo pip install PyYAML

## Required for Neovim
sudo pip install neovim
sudo pacman --noconfirm -S nodejs
sudo pacman --noconfirm -S npm
sudo npm install -g neovim
sudo pacman --noconfirm -S ruby
gem install neovim
sudo pacman --noconfirm -S perl
yay --noconfirm -S cpanminus
cpanm --local-lib=~/perl5 local::lib && eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)
cpanm Archive::Zip --force
# sudo cpanm Neovim::Ext
# Can't use noconfirm with this because it defaults to N to delete vi and Vim
yes | LC_ALL=en_US.UTF-8 yay -S neovim-symlinks

## Setup ZSH for humans
# ZSH for Humans already setup, so reuse config
# if command -v curl >/dev/null 2>&1; then
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v4/install)"
# else
#   sh -c "$(wget -O- https://raw.githubusercontent.com/romkatv/zsh4humans/v4/install)"
# fi

chsh -s $(which zsh)

## Needed for Brother MFC-L2700DW
PRINTER_IP="192.168.0.194"
### Setup Brother scanner
yay --noconfirm -S brother-mfc-l2710dw
yay --noconfirm -S brscan4
sudo pacman --noconfirm -S simple-scan
sudo brsaneconfig4 -a name=BROTHER model=MFC-L2700DW ip="$PRINTER_IP"
# Seems you can also do this:
# brsaneconfig4 -a name=BROTHER model=MFC-L2700DW nodename=BRWD85DE244E1EB

### Setup Brother Printer
sudo pacman --noconfirm -S cups manjaro-printer
sudo systemctl enable cups.service
sudo systemctl start cups.service
sudo pacman --noconfirm -S cups system-config-printer
lpadmin -p MFC-L2700DW -E -v "ipp://$PRINTER_IP/ipp/print" -m everywhere


# Setup Epson ET-2720 printer
sudo pacman -Sy patch
yay -S epson-inkjet-printer-escpr
sudo pacman -Sy cups cups-pdf
sudo gpasswd -a `whoami` lp
sudo gpasswd -a `whoami` lpadmin
sudo systemctl start org.cups.cupsd.service
sudo systemctl enable org.cups.cupsd.service

## X11 stuff
sudo pacman --noconfirm -S xcape

## Docker
yay --noconfirm -S docker
sudo groupadd --force docker  # Force to avoid errors when group exists already
sudo usermod -aG docker $USER
sudo systemctl enable docker.service
sudo systemctl start docker.service

## Rust
sudo pacman --noconfirm -S rustup
rustup toolchain install stable
rustup default stable
rustup component add rustfmt
rustup component add rls

## Alacritty
# yay --noconfirm -S alacritty

## Keypass
yay --noconfirm -S keepassxc

## ssh-agent configuration
sudo ln --force -s ~/.dotfiles/X11/xinit/xinitrc.d/60-ssh-agent.sh /etc/X11/xinit/xinitrc.d/60-ssh-agent.share

## SSH Daemon
sudo pacman --noconfirm -S openssh
sudo systemctl enable sshd
sudo systemctl start sshd

## Ansible
yay --noconfirm -S ansible
yay --noconfirm -S python-pywinrm

## Glogg
yay --noconfirm -S glogg
xdg-mime default glogg.desktop text/x-log

## Git-LFS
yay --noconfirm -S git-lfs
git lfs install

## Google Chrome
yay --noconfirm -S google-chrome
# xdg-settings set default-web-browser google-chrome.desktop

## VirtualBox
# Not configured yet, but this is a link that seems good:
# https://www.linuxtechi.com/install-virtualbox-on-arch-linux/

# have to add the correct kernel headers before we do the following:
# You can determine what Kernel you are running with uname -a
# sudo pacman -S linux-headers
sudo groupadd --force vboxusers  # Force to avoid errors when group exists already
sudo usermod -aG vboxusers $USER
yay --noconfirm -S virtualbox virtualbox-guest-iso virtualbox-ext-oracle

# Setup mirrors better
# sudo pacman-mirrors -c Canada,United_States
sudo pacman-mirrors -c all
sudo pacman -Syyu
yay -Syyu

# power management
sudo systemctl enable tlp.service
sudo systemctl enable NetworkManager-dispatcher.service
sudo systemctl mask systemd-rfkill.service systemctl mask systemd-rfkill.socket

# ActiveState tool
sh <(curl -q https://platform.activestate.com/dl/cli/install.sh)
