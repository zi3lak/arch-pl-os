# Instalacja ARCH PL OS — poradnik krok po kroku

## 1. Przygotuj działający Arch Linux

Potrzebujesz uruchomionej sesji Hyprland, internetu i konta z `sudo`.

## 2. Zaktualizuj system

```bash
sudo pacman -Syu
```

## 3. Zainstaluj Git

```bash
sudo pacman -S --needed git
```

## 4. Pobierz repozytorium

```bash
git clone https://github.com/zi3lak/arch-pl-os.git
cd arch-pl-os
```

## 5. Wykonaj próbę

```bash
./instaluj.sh --proba
```

Tryb próbny niczego nie zmienia.

## 6. Zainstaluj pulpit

```bash
./instaluj.sh
```

Instalator tworzy kopię ustawień, doinstalowuje zależności, generuje polskie locale i stosuje motyw.

## 7. Sprawdź instalację

```bash
./sprawdz.sh
```

## 8. Zaloguj się ponownie

Wylogowanie jest potrzebne do pełnego zastosowania zmiennych językowych.
