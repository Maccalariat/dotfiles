#!/bin/bash

set -e
set -x

mkdir -p ~/.Downloads
mkdir -p ~/.Documents
mkdir -p ~/src
mkdir -p ~/.local
mkdir -p ~/.fonts
mkdir -p ~/.config
mkdir -p ~/.config/emacs
touch ~/.config/emacs/init.el
touch ~/.config/emacs/early-init.el

sudo apt update
sudo apt upgrade

sudo apt-get install -y \
    make cmake git \
    gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip \
    make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev git clangd python3-pip ripgrep fd-find libgccjit0 libgccjit-11-dev libjansson-dev

sudo apt install build-essential libgtk-3-dev libgnutls28-dev libtiff5-dev libgif-dev libjpeg-dev libpng-dev libxpm-dev libncurses-dev texinfo
cd ~/src
git clone git://git.savannah.gnu.org/emacs.git
cd ./emacs
./autogen.sh
./configure --prefix=/home/hans/.local --without-all --with-native-compilation --with-zlib --with-json --without-x --enable-link-time-optimization --with-mailutils=no --with-pop=no --with-gnutls --with-xml2 --without-gpm --with-threads
make -j `nproc`
make install -j`nproc`

# if ! [ -d $HOME/build/neovim ]; then
#    git clone https://github.com/neovim/neovim ~/build/neovim
#    cd ~/build/neovim/
#    make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=/home/hans/.local
#    sudo make install
# fi
# wget https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
# unzip win32yank-x64.zip
# chmod +x win32yank.exe
# mv win32yank.exe ~/.local/bin/
# rm win32yank-x64.zip
# rm LICENSE
# rm README.md

pip install numpy scipy matplotlib ptvsd

cd ~/Downloads
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip
unzip CascadiaCode.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
unzip Hack.zip
mv ./*.ttf ../.fonts
rm CascadiaCode.zip
rm Hack.zip
fc-cache -fv
cd




