sudo setenforce 0
sudo echo -e "\nmax_parallel_downloads=10\nfastestmirror=true" | sudo tee -a /etc/dnf/dnf.conf > /dev/null
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' --setopt='terra.gpgkey=https://repos.fyralabs.com/terra41/key.asc' terra-release
# OPTIONAL
# ---
sudo dnf install -y flatpak
# ---
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo dnf update -y --refresh
sudo dnf upgrade -y --refresh
# sudo dnf install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
# sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

sudo dnf install -y https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo dnf install -y https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
sudo dnf install -y https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm
sudo dnf install -y https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm
sudo dnf install -y https://slack.com/downloads/instructions/linux?ddl=1&build=rpm
sudo dnf install -y https://dbeaver.io/files/dbeaver-ce-latest-stable.x86_64.rpm

# Install all required packages
sudo dnf install -y git curl fastfetch htop unzip tree vlc gnome-tweaks gnome-browser-connector \
gnome-extensions-app gcc make cmake python3-devel nodejs docker-compose traceroute atop btop \
bottom eza bat ripgrep zoxide onefetch qbittorrent discord sqlite timeshift httpie gping \
audacious smplayer audacity blender gimp inkscape kdenlive krita vokoscreenNG thunderbird \
VirtualBox cabextract lzip p7zip p7zip-plugins unrar fontconfig uget nautilus-dropbox \
lpf-spotify-client zlib-ng-compat.i686 ncurses-libs.i686 bzip2-libs.i686 alacritty zellij \
tmux zsh procs rustup poetry uv pnpm rust golang tokei bandwhich kubernetes-client fd-find \
git-delta brave-browser dnfdragora vagrant nerd-fonts cargp
#CARGO CONFIG
# TODO: ADD .zshrc -> export PATH="$HOME/.cargo/bin:$PATH"
# Install fonts


flatpak install flathub com.stremio.Stremio -y


# PRECISA DE CONFIGURAÇÃO MANUAL e setar python3 como padrão
curl -fsSL https://pyenv.run | bash
# TODO: SETUP PYENV
curl https://get.volta.sh | bash
curl -sSL https://get.rvm.io | bash -s stable
# TODO: #CONFIGURAR O RVM
# curl -fsSL https://get.pnpm.io/install.sh | sh -
# curl https://sh.rustup.rs -sSf | sh

npm install -g corepack
npm install -g bun

cargo install bore-cli grex kmon mprocs volta

