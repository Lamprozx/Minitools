#!/data/data/com.termux/files/usr/bin/bash

set -e

spinner() {
    local pid=$!
    local spin='-\|/'
    local i=0

    tput civis 2>/dev/null || true

    while kill -0 $pid 2>/dev/null; do
        i=$(( (i+1) %4 ))
        printf "\r[%c] %s" "${spin:$i:1}" "$1"
        sleep 0.1
    done

    printf "\r[✔] %s\n" "$1"
    tput cnorm 2>/dev/null || true  
}

run_step() {
    (eval "$1") &
    spinner "$2"
}

echo "Nerd Font Installer"

run_step "pkg install -y wget unzip >/dev/null 2>&1" "Installing dependencies"
run_step "cd ~/.termux" "Entering config directory"

run_step "wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip -O ~/.termux/nf.zip" "Downloading font"
run_step "cd ~/.termux && unzip -q nf.zip '*Regular.ttf'" "Extracting font"
run_step "cd ~/.termux && mv *Regular.ttf font.ttf" "Applying font"

run_step "rm -f ~/.termux/nf.zip" "Cleaning up"
run_step "termux-reload-settings" "Reloading Termux"

echo
echo "[✔] Done!"
echo "[!] Now, Restart Your Termux! "
