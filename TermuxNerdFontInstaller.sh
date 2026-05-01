#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "[*] Nerd Font Installer"

mkdir -p ~/.termux
cd ~/.termux

echo "[*] Install deps..."
pkg install -y wget unzip >/dev/null 2>&1

echo "[*] Download font..."
wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip -O nf.zip

echo "[*] Extract target font..."
unzip -q nf.zip 'JetBrainsMonoNLNerdFont-Regular.ttf'

echo "[*] Apply font..."
mv -f JetBrainsMonoNLNerdFont-Regular.ttf font.ttf

echo "[*] Cleanup..."
rm -f nf.zip

echo "[*] Reload settings..."
termux-reload-settings 2>/dev/null || true

echo
echo "[✔] Done 😹"
echo "[!] Restart Termux biar keliatan"
