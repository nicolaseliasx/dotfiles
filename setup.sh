#!/bin/bash

# Atualiza os repositórios e o sistema
sudo pacman -Syu

# Instala o git e base-devel para compilação dos pacotes
sudo pacman -S git base-devel xrandr feh

# Clone os repositórios do BSPWM e SXHKD
git clone https://github.com/baskerville/bspwm.git
git clone https://github.com/baskerville/sxhkd.git

# Compile e instale o BSPWM
(cd bspwm && make && sudo make install)

# Compile e instale o SXHKD
(cd sxhkd && make && sudo make install)

# Cria as pastas de configuração e move os arquivos de exemplo
mkdir -p ~/.config/{bspwm,sxhkd}
cp bspwm/bspwmrc ~/.config/bspwm/
cp sxhkd/sxhkdrc ~/.config/sxhkd/

# Torna os arquivos de configuração executáveis
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/sxhkd/sxhkdrc

# Instalar o Yay - AUR Helper
git clone https://aur.archlinux.org/yay.git
(cd yay && makepkg -si)

# Instalar o gerenciador de exibição LY
yay -S ly

# Habilitar o LY para iniciar automaticamente
sudo systemctl enable ly.service

# Instalar o BSPWM e dependências com o Yay
yay -S bspwm sxhkd polybar rofi picom 

# Instalar aplicativos com o Yay
yay -S visual-studio-code-bin google-chrome intellij-idea-community-edition slack-desktop

# Instalar o tema GTK Graphite
yay -S gtk-theme-graphite

# Copiar os arquivos de configuração para a pasta .config
cp -r /path/to/your/config/files/* ~/.config/

# Reiniciar para iniciar com o LY e o BSPWM
echo "Reinicie o computador para iniciar com o LY e o BSPWM."
