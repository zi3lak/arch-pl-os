# ARCH PL OS

**Polski. Prosty. Twój.**

Bielik — biały orzeł w koronie, godło Rzeczpospolitej — od wieków patrzy z flagi i z herbu jak symbol dumy i porządku. ARCH PL OS bierze go dosłownie za wzór: nasze logo to geometryczny Bielik rozpięty na karmazynowej tarczy, a cała paleta systemu — karmazyn i biel — to barwy naszej flagi, przeniesione na pulpit Linuksa. To nie jest kolejna dystrybucja z angielskim interfejsem i polską naklejką. To pulpit zaprojektowany od zera po polsku, dla polskich użytkowników Arch Linux.

ARCH PL OS to kompletne, odtwarzalne środowisko pulpitu dla Arch Linux i Hyprland.

![Podgląd ARCH PL OS na dwóch monitorach](assets/podglad.jpg)

## Co otrzymujesz

- polski panel systemowy Waybar — data, sieć, głośność, procesor, pamięć, temperatura i GPU jednym spojrzeniem;
- polski launcher Wofi — szybkie uruchamianie programów bez sięgania po mysz;
- polskie powiadomienia i komunikaty w każdym zakątku systemu;
- polski ekran blokady i wielomonitorowy, animowany wygaszacz;
- animowane powitanie po każdej instalacji — Bielik i barwy systemu widoczne od pierwszej sekundy;
- spójny motyw karmazyn / biel / grafit, wierny barwom flagi na każdym ekranie;
- tapety 4K automatycznie dopasowane do układu monitorów;
- automatyczną konfigurację `pl_PL.UTF-8` — polskie daty, jednostki i komunikaty systemowe;
- backup przed każdą instalacją i jedną komendą powrót do poprzedniego pulpitu;
- jedno polecenie do aktualizacji całego środowiska.

Projekt nie zawiera haseł, tokenów, kluczy SSH ani danych użytkownika.

## Co jest zainstalowane w systemie

Instalator (`instaluj.sh`) doinstalowuje wyłącznie to, czego faktycznie brakuje — każdy z poniższych pakietów ma konkretną rolę w pulpicie:

| Pakiet | Rola w ARCH PL OS |
|---|---|
| `hyprland` | kafelkowy, płynnie animowany kompozytor Wayland — serce całego pulpitu |
| `waybar` | górny panel systemowy przetłumaczony na język polski |
| `wofi` | launcher aplikacji uruchamiany skrótem `Super + Spacja` |
| `dunst` | polskie powiadomienia systemowe |
| `alacritty` | szybki, lekki terminal uruchamiany skrótem `Super + Q` |
| `awww` | płynne, wielomonitorowe tapety 4K dopasowane do układu ekranów |
| `hypridle` | zarządzanie bezczynnością — wygaszacz, blokada, uśpienie monitorów |
| `hyprlock` | polski ekran blokady |
| `grim` | zrzuty ekranu |
| `slurp` | wybór fragmentu ekranu do zrzutu |
| `swappy` | szybka edycja i adnotacje na zrzutach ekranu |
| `papirus-icon-theme` | spójny, ciemny zestaw ikon |
| `pyside6` | silnik animacji powitalnej i wygaszacza (Python + Qt) |
| `jq` | przetwarzanie konfiguracji JSON używane przez diagnostykę |
| `imagemagick` | dopasowanie i przetwarzanie tapet 4K |
| `libnotify` | biblioteka powiadomień systemowych |
| `xdg-user-dirs` | polskie nazwy katalogów użytkownika (Dokumenty, Obrazy, Pobrane…) |
| `noto-fonts` | czcionki z pełnym wsparciem polskich znaków diakrytycznych |
| `noto-fonts-emoji` | pełne wsparcie emoji w panelu i powiadomieniach |
| `ttf-jetbrains-mono-nerd` | czcionka terminala i panelu z ikonami (Nerd Font) |

Pełną, zawsze aktualną listę znajdziesz w [`pakiety.txt`](pakiety.txt).

## Wymagania

- Arch Linux x86_64;
- działająca sesja Hyprland / Wayland;
- połączenie z internetem;
- konto użytkownika z dostępem do `sudo`.

## Instalacja

```bash
git clone https://github.com/zi3lak/arch-pl-os.git
cd arch-pl-os
./instaluj.sh --proba
./instaluj.sh
```

Po instalacji wyloguj się i zaloguj ponownie, aby wszystkie ustawienia języka zostały zastosowane.

Pełna instrukcja krok po kroku, z fotografiami pulpitu: [docs/instalacja.html](docs/instalacja.html)

## Diagnostyka

```bash
./sprawdz.sh
```

## Aktualizacja

```bash
./aktualizuj.sh
```

## Powrót do poprzedniego pulpitu

```bash
./przywroc.sh
```

Kopie znajdują się w `~/.local/state/arch-pl-os/kopie/`.

## Skróty

| Skrót | Działanie |
|---|---|
| `Super + Spacja` | wyszukiwarka programów |
| `Super + Q` | terminal |
| `Super + L` | blokada komputera |
| `Super + Shift + W` | zmiana trybu tapety |
| `Print Screen` | zrzut całego ekranu |
| `Super + Print Screen` | zrzut wybranego obszaru |

## Symbolika

Logo ARCH PL OS przedstawia geometrycznego Bielika rozpiętego na karmazynowej tarczy — nawiązanie do godła Rzeczpospolitej. Karmazyn i biel, obecne w panelu, oknach i ekranie blokady, to barwy polskiej flagi. To nie jest dodatek kosmetyczny — to deklaracja, że polski użytkownik Arch Linux zasługuje na pulpit zbudowany od podstaw w jego języku i w jego barwach.

## Strona projektu

Po publikacji GitHub Pages: `https://zi3lak.github.io/arch-pl-os/`

## Struktura repozytorium

```text
assets/          logo i materiały pulpitu 4K
apps/            animacja powitalna i wygaszacz
bin/             skrypty uruchomieniowe i telemetria
config/          konfiguracje pulpitu
docs/            strona projektu (GitHub Pages) i poradniki
instaluj.sh      bezpieczny instalator
przywroc.sh      pełny rollback
aktualizuj.sh    aktualizacja projektu
sprawdz.sh       diagnostyka działającej instalacji
sprawdz-repo.sh  test integralności repozytorium
```

## Zasady projektu

1. Cały interfejs użytkownika jest po polsku.
2. Instalator najpierw tworzy kopię.
3. Konfiguracja jest czytelna i możliwa do samodzielnej zmiany.
4. Projekt nie zapisuje sekretów ani danych osobistych.
5. Minimalizm ma poprawiać obsługę, a nie tylko wygląd.

## Licencja

GNU GPL v3. Zobacz plik [LICENSE](LICENSE).
