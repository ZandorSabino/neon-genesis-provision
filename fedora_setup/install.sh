#!/bin/bash

set -o pipefail  # Propaga erros em pipes
set -e           # Interrompe em erros críticos

# Configuração de cores para saída mais legível
RED="\e[31m"
YELLOW="\e[33m"
GREEN="\e[32m"
RESET="\e[0m"

# Arquivo de log
LOG_FILE="/var/log/fedora-postinstall.log"
touch "$LOG_FILE"

# Função para log
log() {
    echo -e "${GREEN}[INFO]${RESET} $1"
    echo "[INFO] $1" >> "$LOG_FILE"
}

# Função para erro crítico (encerra o script)
error_critical() {
    echo -e "${RED}[ERRO CRÍTICO]${RESET} $1"
    echo "[ERRO CRÍTICO] $1" >> "$LOG_FILE"
    exit 1
}

# Função para erro parcial (continua a execução)
error_partial() {
    echo -e "${YELLOW}[ERRO PARCIAL]${RESET} $1"
    echo "[ERRO PARCIAL] $1" >> "$LOG_FILE"
}

# -------------- ETAPA INICIAL: VERIFICAÇÃO DO SISTEMA --------------

etapa_sistema() {
    log "🔹 Verificando o sistema..."

    # Verifica se o usuário é root
    if [[ $EUID -ne 0 ]]; then
        error_critical "O script precisa ser executado como root. Use 'sudo ./install.sh'"
    fi

    # Detecta o sistema operacional
    if [[ -f "/etc/fedora-release" ]]; then
        FEDORA_VERSION=$(cat /etc/fedora-release | awk '{print $3}')
        ARCH=$(uname -m)
        USERNAME=$(logname)
        log "🖥️  Detalhes do Sistema:"
        log "   - Distribuição: Fedora $FEDORA_VERSION"
        log "   - Arquitetura: $ARCH"
        log "   - Usuário logado: $USERNAME"
    else
        error_critical "Este script só pode ser executado no Fedora."
    fi
}

# -------------- ETAPAS --------------

# Atualização do sistema (CRÍTICA)
system_update() {
    log "📦 Intalando repositórios de terceiros..."
    log "🔹 Instalando RPM Fusion..."
    sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm || error_critical "Falha ao atualizar pacotes."
    log "🔹 Instalando repositório Terra..."
    sudo dnf install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release || error_critical "Falha ao atualizar pacotes."
    log "🔹 Instalando repositório Flathub..."
    sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo || error_critical "Falha ao atualizar pacotes."
    log "✅ Atualização concluída!"
    log "🛠 Configura DNF"
    echo -e "\nmax_parallel_downloads=10\nfastestmirror=true" | sudo tee -a /etc/dnf/dnf.conf > /dev/null
    log "✅ DNF configurado!"
    log "🔹 Atualizando sistema..."
    sudo dnf update -y --refresh || error_critical "Falha ao atualizar o sistema."
    sudo dnf upgrade -y --refresh || error_critical "Falha ao atualizar pacotes."
    log "✅ Atualização concluída!"
}

# Instalar pacotes essenciais e pacotes que não precisão de configuração prévia (INDEPENDENTE)
etapa_b() {
    log "📦 Instalando pacotes essenciais..."
    
    PACOTES=(
        git
        curl
        wget
        vim
        htop
        unzip
        tree
    )

    for pacote in "${PACOTES[@]}"; do
        log "🔹 Instalando $pacote..."
        sudo dnf install -y "$pacote" && log "✅ $pacote instalado!" || error_partial "Falha ao instalar $pacote."
    done

    log "✅ Instalação de pacotes essenciais concluída!"
}

# ETAPA C: Instalar aplicativos comuns (INDEPENDENTE, ERRO PARCIAL PARA CADA PACOTE)
etapa_c() {
    log "🎨 Instalando aplicativos comuns..."
    
    PACOTES=(
        vlc
        gnome-tweaks
        neofetch
    )

    for pacote in "${PACOTES[@]}"; do
        log "🔹 Instalando $pacote..."
        sudo dnf install -y "$pacote" && log "✅ $pacote instalado!" || error_partial "Falha ao instalar $pacote."
    done

    log "✅ Aplicativos comuns instalados!"
}

# ETAPA D: Configurar firewall (INDEPENDENTE)
etapa_d() {
    log "🛡️  Configurando firewall..."
    sudo systemctl enable --now firewalld || error_partial "Falha ao ativar o firewall."
    log "✅ Firewall configurado!"
}

# ETAPA E: Instalar ferramentas de desenvolvimento (depende da ETAPA B, ERRO PARCIAL PARA CADA PACOTE)
etapa_e() {
    log "🛠 Instalando ferramentas de desenvolvimento..."
    
    PACOTES=(
        gcc
        make
        cmake
        python3-devel
        nodejs
        docker
    )

    for pacote in "${PACOTES[@]}"; do
        log "🔹 Instalando $pacote..."
        sudo dnf install -y "$pacote" && log "✅ $pacote instalado!" || error_partial "Falha ao instalar $pacote."
    done

    log "✅ Ferramentas de desenvolvimento instaladas!"
}

# -------------- EXECUÇÃO DAS ETAPAS --------------

log "🔹 Iniciando a instalação pós-instalação do Fedora..."

# Rodar etapas conforme dependências
etapa_sistema
etapa_a
etapa_b
etapa_c
etapa_d
etapa_e

log "✅ Instalação concluída! Reinicie o sistema se necessário."
