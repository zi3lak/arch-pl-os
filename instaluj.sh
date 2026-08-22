#!/usr/bin/env bash
set -Eeuo pipefail
KATALOG_REPO=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
KATALOG_SYSTEMU="$HOME/.local/share/arch-pl-os"
KATALOG_STANU="$HOME/.local/state/arch-pl-os"
INSTALUJ_PAKIETY=1; USTAW_LOCALE=1; PROBA=0
for arg in "$@"; do case "$arg" in
 --bez-pakietow) INSTALUJ_PAKIETY=0;; --bez-locale) USTAW_LOCALE=0;; --proba) PROBA=1;;
 -h|--pomoc) echo 'Użycie: ./instaluj.sh [--proba] [--bez-pakietow] [--bez-locale]'; exit 0;;
 *) echo "Nieznana opcja: $arg" >&2; exit 2;; esac; done

[[ -f /etc/arch-release ]] || { echo 'Automatyczna instalacja obsługuje Arch Linux.' >&2; exit 1; }
command -v Hyprland >/dev/null || { echo 'Najpierw zainstaluj i uruchom Hyprland.' >&2; exit 1; }
pakiety=(hyprland waybar wofi dunst alacritty awww hypridle hyprlock grim slurp swappy papirus-icon-theme pyside6 jq imagemagick libnotify xdg-user-dirs noto-fonts noto-fonts-emoji ttf-jetbrains-mono-nerd)
brak=(); for p in "${pakiety[@]}"; do pacman -Q "$p" >/dev/null 2>&1 || brak+=("$p"); done
if ((PROBA)); then
 echo "Źródło: $KATALOG_REPO"; echo "Cel: $KATALOG_SYSTEMU"; echo "Brakujące pakiety: ${brak[*]:-brak}"; echo 'Tryb próbny: niczego nie zmieniono.'; exit 0
fi
if ((${#brak[@]})) && ((INSTALUJ_PAKIETY)); then sudo pacman -S --needed --noconfirm "${brak[@]}"; elif ((${#brak[@]})); then echo "Brak pakietów: ${brak[*]}" >&2; exit 1; fi

znacznik=$(date +%Y%m%d-%H%M%S); kopia="$KATALOG_STANU/kopie/$znacznik"; mkdir -p "$kopia"
for rel in .config/hypr .config/waybar .config/wofi .config/alacritty .config/dunst .config/gtk-3.0 .config/gtk-4.0; do src="$HOME/$rel"; [[ -e "$src" ]] && mkdir -p "$kopia/$(dirname "$rel")" && cp -a "$src" "$kopia/$rel"; done
[[ -d "$KATALOG_SYSTEMU" ]] && cp -a "$KATALOG_SYSTEMU" "$kopia/poprzedni-arch-pl-os"
printf '%s\n' "$kopia" > "$KATALOG_STANU/OSTATNIA_KOPIA"

if ((USTAW_LOCALE)); then
 sudo python3 - <<'PY'
from pathlib import Path
p=Path('/etc/locale.gen'); s=p.read_text();
if '#pl_PL.UTF-8 UTF-8' in s: s=s.replace('#pl_PL.UTF-8 UTF-8','pl_PL.UTF-8 UTF-8')
elif 'pl_PL.UTF-8 UTF-8' not in s: s+='\npl_PL.UTF-8 UTF-8\n'
p.write_text(s)
PY
 sudo locale-gen
 sudo localectl set-locale LANG=pl_PL.UTF-8
fi

roboczy="$KATALOG_SYSTEMU.instalacja"; rm -rf "$roboczy"; mkdir -p "$roboczy"/{assets,bin}
cp -a "$KATALOG_REPO/assets/." "$roboczy/assets/"; cp -a "$KATALOG_REPO/bin/." "$roboczy/bin/"
cp "$KATALOG_REPO/apps/powitanie.py" "$roboczy/powitanie.py"; cp "$KATALOG_REPO/apps/wygaszacz.py" "$roboczy/wygaszacz.py"; cp "$KATALOG_REPO/README.md" "$roboczy/README.md"; chmod +x "$roboczy/bin/"*
rm -rf "$KATALOG_SYSTEMU"; mv "$roboczy" "$KATALOG_SYSTEMU"

mkdir -p "$HOME/.config"/{hypr,waybar,wofi,alacritty,dunst,gtk-3.0,gtk-4.0} "$HOME/Obrazy/Zrzuty ekranu"
cp "$KATALOG_REPO/config/hypr/arch-pl.conf" "$HOME/.config/hypr/arch-pl.conf"
cp "$KATALOG_REPO/config/hypr/arch-pl-idle.conf" "$HOME/.config/hypr/arch-pl-idle.conf"
python3 - "$KATALOG_REPO/config/hypr/arch-pl-lock.conf" "$HOME/.config/hypr/arch-pl-lock.conf" "$HOME" <<'PY'
from pathlib import Path
import sys
src,dst,home=sys.argv[1:]; Path(dst).write_text(Path(src).read_text().replace('__HOME__',home))
PY
cp "$KATALOG_REPO/config/waybar/"{config,style.css} "$HOME/.config/waybar/"
cp "$KATALOG_REPO/config/wofi/"{config,style.css} "$HOME/.config/wofi/"
cp "$KATALOG_REPO/config/alacritty/alacritty.toml" "$HOME/.config/alacritty/"
cp "$KATALOG_REPO/config/dunst/dunstrc" "$HOME/.config/dunst/"

hypr="$HOME/.config/hypr/hyprland.conf"
if [[ ! -f "$hypr" ]]; then cat > "$hypr" <<'BASE'
monitor = , preferred, auto, 1
$mainMod = SUPER
$terminal = alacritty
bind = $mainMod, Q, exec, $terminal
bind = $mainMod, C, killactive
BASE
fi
python3 - "$hypr" <<'PY'
from pathlib import Path
import sys
p=Path(sys.argv[1]); lines=[l for l in p.read_text().splitlines() if 'ARCH PL OS — zarządzane źródło' not in l and 'source = ~/.config/hypr/arch-pl.conf' not in l]; lines += ['', '# ARCH PL OS — zarządzane źródło', 'source = ~/.config/hypr/arch-pl.conf']; p.write_text('\n'.join(lines)+'\n')
PY

cat > "$HOME/.config/gtk-3.0/settings.ini" <<'GTK'
[Settings]
gtk-theme-name=Adwaita-dark
gtk-icon-theme-name=Papirus-Dark
gtk-font-name=Noto Sans 11
gtk-cursor-theme-name=Adwaita
gtk-application-prefer-dark-theme=1
GTK
cp "$HOME/.config/gtk-3.0/settings.ini" "$HOME/.config/gtk-4.0/settings.ini"
if command -v gsettings >/dev/null; then gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' || true; gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark' || true; gsettings set org.gnome.desktop.interface font-name 'Noto Sans 11' || true; fi
LANG=pl_PL.UTF-8 xdg-user-dirs-update --force || true

if hyprctl monitors -j >/dev/null 2>&1; then hyprctl reload >/dev/null; sleep 1; "$KATALOG_SYSTEMU/bin/start"; pkill -x hypridle 2>/dev/null || true; hyprctl dispatch exec "hypridle -q -c $HOME/.config/hypr/arch-pl-idle.conf" >/dev/null; pkill -x dunst 2>/dev/null || true; hyprctl dispatch exec dunst >/dev/null; fi
printf '\nARCH PL OS został zainstalowany.\nKopia poprzednich ustawień: %s\nDiagnostyka: ./sprawdz.sh\n' "$kopia"
