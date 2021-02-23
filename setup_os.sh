#! /bin/bash

# Setup Packages for Arch

## Upgrade everything
sudo pacman --noconfirm -Syu

## Install Main packages I want
sudo pacman --noconfirm -S yay
sudo pacman --noconfirm -S base-devel
sudo pacman --noconfirm -S stow
sudo pacman --noconfirm -S python
sudo pacman --noconfirm -S python-pip
sudo pacman --noconfirm -S figlet
sudo pacman --noconfirm -S fd

## Update everything in the AUR
yay --noconfirm -Syu

## Install AUR packages I want
yay --noconfirm -S neovim-nightly-bin
yay --noconfirm -S google-chrome

## Required for initial_setup.py
sudo pip install PyYAML

## Required for Neovim
sudo pip install neovim
sudo pacman --noconfirm -S nodejs
sudo pacman --noconfirm -S npm
sudo npm install -g neovim
sudo pacman --noconfirm -S ruby
gem install neovim
sudo pacman --noconfirm -S perl
yay --noconfirm -S cpanminus
sudo cpanm Neovim::Ext
cpanm --local-lib=~/perl5 local::lib && eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)

sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

~/.fzf/install

chsh -s $(which zsh)


## Needed for Brother MFC-L2700DW
PRINTER_IP="192.168.0.194"
yay --noconfirm -S brother-mfc-l2710dw
yay --noconfirm -S brscan4
sudo pacman --noconfirm -S simple-scan
sudo brsaneconfig4 -a name=BROTHER model=MFC-L2700DW ip="$PRINTER_IP"
# Seems you can also do this:
# brsaneconfig4 -a name=BROTHER model=MFC-L2700DW nodename=BRWD85DE244E1EB

sudo pacman --noconfirm -S cups manjaro-printer
sudo systemctl enable cups.service
sudo systemctl start cups.service
sudo pacman --noconfirm -S cups system-config-printer
lpadmin -p MFC-L2700DW -E -v "ipp://$PRINTER_IP/ipp/print" -m everywhere

#########################################################################################################3
# if [ ! -f /.ssh/id_rsa.pub ]; then
#     figlet "Have to create new SSH keys"
#     echo "File not found!"
# fi

# # Install PPA tools
# sudo apt-get --assume-yes update && sudo apt-get -yqq upgrade && \
#         sudo apt-get --assume-yes install \
#     software-properties-common \
#     curl \
#     bash \
#     && sudo apt-get -y clean

# # Neovim
# sudo add-apt-repository ppa:neovim-ppa/unstable
# # Node
# sudo curl -L https://deb.nodesource.com/setup_14.x | sudo bash -
# # Yarn
# sudo curl -L https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
# sudo echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

# # Software I use all the time, stow is pretty important
# sudo apt-get --assume-yes update && sudo apt-get -yqq upgrade && \
#         sudo apt-get --assume-yes install \
#     ripgrep \
##     stow \
#     universal-ctags \
#     golang \
#     locales \
#     fd-find \
#     fzf \
#     vifm \
#     dos2unix \
#     colorized-logs \
#     pass \
#     mutt \
#     && sudo apt-get -y clean

# # Needed for vim-clap and vim-todoist
# sudo apt-get --assume-yes update && sudo apt-get -yqq upgrade && \
#         sudo apt-get --assume-yes install \
#         libssl-dev \
#         build-essential \
#     && sudo apt-get -y clean

# # Interesting software.
# sudo apt-get --assume-yes update && sudo apt-get -yqq upgrade && \
#         sudo apt-get --assume-yes install \
#         figlet \
#     && sudo apt-get -y clean

# # Python setup, including for coc-nvim
# sudo apt-get --assume-yes update && sudo apt-get -yqq upgrade && \
#         sudo apt-get --assume-yes install \
#     python3 \
#     python3-pip \
#     python-is-python3 \
#     flake8 \
#     black \
#     mypy \
#     mypy-doc \
#     python-black-doc \
#     python3-pynvim \
#     python3-venv \
#     && sudo apt-get -y clean

# # Perl setup
# sudo apt-get --assume-yes update && sudo apt-get -yqq upgrade && \
#         sudo apt-get --assume-yes install \
#     libcode-tidyall-perl \
#     libdbd-pg-perl \
#     cpanminus \
#     && sudo apt-get -y clean

# cpanm --sudo Perl::lLanguageServer
# cpanm --sudo Neovim::Ext
# cpanm --local-lib=~/perl5 local::lib && eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)


# # Ruby setup
# sudo apt-get --assume-yes update && sudo apt-get -yqq upgrade && \
#         sudo apt-get --assume-yes install \
#     ruby \
#     ruby-dev \
#     && sudo apt-get -y clean

# sudo gem install neovim

# # Things needed for coc-nvim
# sudo apt-get --assume-yes update && sudo apt-get -yqq upgrade && \
#         sudo apt-get --assume-yes install \
#     neovim \
#     nodejs \
#     yarn \
#     && sudo apt-get -y clean

# # Things needed for oh-my-zsh
# sudo apt-get --assume-yes update && sudo apt-get -yqq upgrade && \
#         sudo apt-get --assume-yes install \
#     build-essential \
#     curl \
#     file \
#     powerline \
#     fonts-powerline \
#     && sudo apt-get -y clean

# # Tmux stuff
# sudo apt-get --assume-yes update && sudo apt-get -yqq upgrade && \
#         sudo apt-get --assume-yes install \
#     tmux \
#     && sudo apt-get -y clean

# sudo gem install tmuxinator

# # Install Git
# sudo add-apt-repository -y ppa:git-core/ppa && sudo apt-get update && sudo apt-get install -y git git-lfs && sudo apt-get -y clean
# # Set default pull mode for git
# git config --global pull.rebase false

# # Neovim module setup
# sudo yarn global add neovim
# sudo npm install -g neovim

# sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
# sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
# sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
# sudo update-alternatives --install /usr/bin/view view /usr/bin/nvim 60

# # This is needed for coc-python
# sudo pip3 install jedi

# # Iosevka Font which I like
# rm -rf /tmp/iosevka
# mkdir -p /tmp/iosevka
# wget --directory-prefix=/tmp/iosevka http://phd-sid.ethz.ch/debian/fonts-iosevka/fonts-iosevka_4.0.0%2Bds-1_all.deb
# sudo dpkg -i /tmp/iosevka/fonts-iosevka_4.0.0+ds-1_all.deb

# # Install dependencies needed for Alacritty Terminal
# sudo apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3

# # Install Rust
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# rustup override set stable
# rustup update stable

# # Install Alacritty
# rm -rf /tmp/alacritty
# git clone https://github.com/alacritty/alacritty.git /tmp/alacritty
# cd /tmp/alacritty

# cargo build --release

# sudo cp target/release/alacritty /usr/local/bin
# sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
# sudo desktop-file-install extra/linux/Alacritty.desktop
# sudo update-desktop-database
