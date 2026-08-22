#!/usr/bin/env bash
set -uo pipefail
blad=0; testuj(){ if eval "$2" >/dev/null 2>&1; then printf '  [DOBRZE] %s\n' "$1"; else printf '  [BŁĄD]   %s\n' "$1"; blad=1; fi; }
echo 'ARCH PL OS — diagnostyka'
testuj 'Konfiguracja Hyprland' '[[ -z "$(hyprctl configerrors)" ]]'
testuj 'Konfiguracja Waybar' 'jq empty "$HOME/.config/waybar/config"'
testuj 'Polski moduł pulpitu' 'test -f "$HOME/.config/hypr/arch-pl.conf"'
testuj 'Tapety systemowe' 'test -f "$HOME/.local/share/arch-pl-os/assets/tapeta-lewa.png" && test -f "$HOME/.local/share/arch-pl-os/assets/tapeta-prawa.png"'
testuj 'Animacja powitalna' 'python3 -m py_compile "$HOME/.local/share/arch-pl-os/powitanie.py"'
testuj 'Wygaszacz' 'python3 -m py_compile "$HOME/.local/share/arch-pl-os/wygaszacz.py"'
testuj 'Panel Waybar' 'pgrep -x waybar'
testuj 'Obsługa tapet' 'pgrep -x awww-daemon'
testuj 'Obsługa bezczynności' 'pgrep -x hypridle'
testuj 'Powiadomienia' 'pgrep -x dunst'
exit "$blad"
