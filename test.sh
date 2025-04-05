#!/bin/bash

# Lista de pacotes
pacotes=(
    # Utilitários Essenciais
    git curl wget vim-enhanced htop unzip tree vlc gnome-tweaks gnome-browser-connector gnome-extensions-app neofetch gcc make cmake python3-devel nodejs docker docker-compose kubectl minikube traceroute atop btop bottom eza bat fd ripgrep zoxide delta onefetch brave qbittorrent stremio spotify discord slack dbeaver sqlite timeshift xh httpie gping audacious smplayer audacity blender gimp inkscape kdenlive krita vokoscreenNG thunderbird VirtualBox dnfdragora-gui cabextract lzip p7zip p7zip-plugins unrar fontconfig uget nautilus-dropbox lpf-spotify-client zlib-ng-compat.i686 ncurses-libs.i686 bzip2-libs.i686
    # Terminal & Shell 
    alacritty zellij tmux zsh mprocs procs
    # Desenvolvimento
    pyenv volta rustup poetry uv bun yarn npm pnpm python rust golang
    # Git & Ferramentas Git
    grex tokei
    # DevOps e Cloud
    kmon bore bandwhich
)

# URLs de pacotes RPM externos (tratados separadamente)
rpm_urls=(
    "https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm"
    "https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm"
    "https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm"
)

# Arrays para armazenar resultados
pacotes_disponiveis=()
pacotes_indisponiveis=()

# Verificação dos pacotes do repositório Fedora
echo -e "\n🔍 Verificando pacotes via dnf:"
for pacote in "${pacotes[@]}"; do
    if dnf list --available "$pacote" &>/dev/null; then
        echo "✅ $pacote está disponível."
        pacotes_disponiveis+=("$pacote")
    else
        echo "❌ $pacote não encontrado nos repositórios padrão."
        pacotes_indisponiveis+=("$pacote")
    fi
done

# Agrupamento e exibição final
echo -e "\n📦 Pacotes encontrados:"
for item in "${pacotes_disponiveis[@]}"; do
    echo "  ✅ $item"
done

echo -e "\n🚫 Pacotes NÃO encontrados:"
for item in "${pacotes_indisponiveis[@]}"; do
    echo "  ❌ $item"
done

# Exibir pacotes .rpm externos
echo -e "\n🌐 Pacotes .rpm externos (instalar manualmente com 'dnf install <url>'):"
for url in "${rpm_urls[@]}"; do
    echo "  📦 $url"
done
