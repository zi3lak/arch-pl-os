#!/usr/bin/env bash
set -Eeuo pipefail
STAN="$HOME/.local/state/arch-pl-os"; kopia=${1:-$(cat "$STAN/OSTATNIA_KOPIA" 2>/dev/null || true)}
[[ -n "$kopia" && -d "$kopia" ]] || { echo "Nie znaleziono kopii: ${kopia:-brak}" >&2; exit 1; }
for rel in .config/hypr .config/waybar .config/wofi .config/alacritty .config/dunst .config/gtk-3.0 .config/gtk-4.0; do src="$kopia/$rel"; cel="$HOME/$rel"; if [[ -e "$src" ]]; then rm -rf "$cel"; mkdir -p "$(dirname "$cel")"; cp -a "$src" "$cel"; fi; done
if [[ -d "$kopia/poprzedni-arch-pl-os" ]]; then rm -rf "$HOME/.local/share/arch-pl-os"; cp -a "$kopia/poprzedni-arch-pl-os" "$HOME/.local/share/arch-pl-os"; fi
pkill -x waybar 2>/dev/null || true; pkill -x awww-daemon 2>/dev/null || true; pkill -x hypridle 2>/dev/null || true; pkill -x dunst 2>/dev/null || true
if hyprctl monitors -j >/dev/null 2>&1; then hyprctl reload >/dev/null; hyprctl dispatch exec waybar >/dev/null || true; hyprctl dispatch exec dunst >/dev/null || true; fi
echo "Przywrócono ustawienia z: $kopia"
