#!/usr/bin/env bash

# Atualizar e instalar pacotes necessários
echo "Instalando pacotes necessários..."
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm pipewire wireplumber xdg-desktop-portal-hyprland xdg-desktop-portal-gtk xdg-desktop-portal grim slurp wf-recorder

# Reiniciar serviços
echo "Reiniciando serviços..."
systemctl --user restart pipewire
systemctl --user restart wireplumber
systemctl --user restart xdg-desktop-portal

# Configurar Hyprland
HYPRLAND_CONFIG="$HOME/.config/hypr/hyprland.conf"
HYPRLAND_CONFIG_DIR="$(dirname "$HYPRLAND_CONFIG")"
if [ ! -d "$HYPRLAND_CONFIG_DIR" ]; then
  echo "Criando diretório de configuração do Hyprland..."
  mkdir -p "$HYPRLAND_CONFIG_DIR"
fi

if grep -q "exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP" "$HYPRLAND_CONFIG"; then
  echo "Configuração do Hyprland já está presente."
else
  echo "Adicionando configuração ao Hyprland..."
  echo "exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP" >> "$HYPRLAND_CONFIG"
  echo "exec-once=~/restart_xdp.sh" >> "$HYPRLAND_CONFIG"
  echo "exec-once=dbus-update-activation-environment --systemd --all" >> "$HYPRLAND_CONFIG"
  echo "exec-once=systemctl --user import-environment QT_QPA_PLATFORMTHEME" >> "$HYPRLAND_CONFIG"
fi

# Criar script de reinicialização dos portais
RESTART_SCRIPT="$HOME/restart_xdp.sh"
echo "Criando script de reinicialização dos portais..."
cat <<EOL > "$RESTART_SCRIPT"
#!/usr/bin/env bash
sleep 1
killall -e xdg-desktop-portal-hyprland
killall -e xdg-desktop-portal-wlr
killall xdg-desktop-portal
/usr/lib/xdg-desktop-portal-hyprland &
sleep 2
/usr/lib/xdg-desktop-portal &
EOL

chmod +x "$RESTART_SCRIPT"

# Configurar preferências do portal
PORTAL_CONFIG_DIR="$HOME/.config/xdg-desktop-portal"
PORTAL_CONFIG="$PORTAL_CONFIG_DIR/hyprland-portals.conf"
if [ ! -d "$PORTAL_CONFIG_DIR" ]; then
  echo "Criando diretório de configuração do xdg-desktop-portal..."
  mkdir -p "$PORTAL_CONFIG_DIR"
fi

echo "Configurando preferências do portal..."
cat <<EOL > "$PORTAL_CONFIG"
[preferred]
default=hyprland;gtk
org.freedesktop.impl.portal.FileChooser=kde
EOL

# Reiniciar o sistema
echo "Configuração concluída. O sistema será reiniciado em 5 segundos..."
sleep 5
systemctl reboot
