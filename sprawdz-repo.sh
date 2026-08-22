#!/usr/bin/env bash
set -Eeuo pipefail
R=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
for s in "$R"/*.sh "$R"/bin/*; do bash -n "$s"; done
python3 -m py_compile "$R/apps/powitanie.py" "$R/apps/wygaszacz.py"
jq empty "$R/config/waybar/config"
if command -v Hyprland >/dev/null 2>&1; then Hyprland --verify-config --config "$R/config/hypr/arch-pl.conf" | grep -q 'config ok'; fi
for i in tapeta-lewa.png tapeta-prawa.png ekran-blokady.png; do identify "$R/assets/$i" | grep -q '3840x2160'; done
for p in "$R/docs"/*.html; do grep -q '<html lang="pl">' "$p"; done
if grep -RInE '(gh[pousr]_[A-Za-z0-9_]{20,}|github_pat_[A-Za-z0-9_]{20,}|AKIA[0-9A-Z]{16}|BEGIN (RSA|OPENSSH|EC) PRIVATE KEY|password\s*=|api[_-]?key\s*=)' "$R" --exclude-dir=.git --exclude='sprawdz-repo.sh'; then echo 'Wykryto możliwy sekret.' >&2; exit 1; fi
echo 'Repozytorium ARCH PL OS przeszło wszystkie testy.'
