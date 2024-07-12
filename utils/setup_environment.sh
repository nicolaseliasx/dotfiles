#!/usr/bin/env bash

# Função para imprimir mensagens
function print_message() {
  echo -e "\n\033[1;32m$1\033[0m\n"
}

# Atualizar e instalar pacotes necessários
print_message "Atualizando sistema e instalando pacotes base..."
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm git curl docker docker-compose base-devel

# Instalar yay
print_message "Instalando yay para gerenciar pacotes do AUR..."
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm

# Instalar pacotes via yay
print_message "Instalando pacotes necessários via yay..."
yay -S --noconfirm visual-studio-code-bin google-chrome intellij-idea-community-edition slack-desktop dbeaver

# Criar diretório bridge na home
print_message "Criando diretório ~/bridge..."
mkdir -p ~/bridge

# Instalar o SDKMAN e configurar o Fish shell
print_message "Instalando o SDKMAN e configurando o Fish shell..."
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install reitzig/sdkman-for-fish@v2.0.0

# Instalar o Java e Maven usando SDKMAN
print_message "Instalando Java 8 e Maven 3.9.3..."
source ~/.config/fish/config.fish
sdk install java 8.0.392-zulu
sdk install maven 3.9.3

# Instalar o Node 16.x e Yarn
print_message "Instalando NVM e Node.js 16.20.0..."
yay -S --noconfirm nvm
fisher install jorgebucaran/nvm.fish
nvm install 16.20.0

# Configurar Docker
print_message "Configurando Docker..."
sudo systemctl enable docker
sudo systemctl start docker
sudo gpasswd -a ncls docker

print_message "Configuração concluída. Por favor, faça logout e login novamente para aplicar todas as mudanças."


