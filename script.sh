#!/bin/bash

# Atualiza os repositórios e o sistema
sudo pacman -Syu

sudo pacman -S git yarn curl fish docker dbeaver
chsh -s $(which fish)
mv fish/ ~/.config/fish

sudo gpasswd -a nclsnote docker

curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install reitzig/sdkman-for-fish@v2.0.0

curl -s "https://get.sdkman.io" | bash

sdk install java 8.0.392-zulu
sdk install java 17.0.6-zulu
sdk install maven 3.9.3

# Instalar o Yay - AUR Helper
git clone https://aur.archlinux.org/yay.git
(cd yay && makepkg -si)

# Instalar aplicativos com o Yay
yay -S visual-studio-code-bin google-chrome intellij-idea-community-edition slack-desktop dbeaver
yay -S nvm
fisher install jorgebucaran/nvm.fish


docker login registry.bridge.ufsc.br