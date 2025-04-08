sudo setenforce 0
sudo echo -e "\nmax_parallel_downloads=10\nfastestmirror=true" | sudo tee -a /etc/dnf/dnf.conf > /dev/null
# sudo dnf install -y --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' --setopt='terra.gpgkey=https://repos.fyralabs.com/terra41/key.asc' terra-release
# OPTIONAL
# ---
sudo dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
# ---
# sudo dnf install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
# sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-41.noarch.rpm \
https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-41.noarch.rpm \
https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm \
https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm \
https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm \
https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm \
https://slack.com/downloads/instructions/linux?ddl=1&build=rpm \
https://dbeaver.io/files/dbeaver-ce-latest-stable.x86_64.rpm
sudo dnf install -y flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
# Install all required packages
sudo dnf install -y git curl fastfetch htop unzip tree vlc gnome-tweaks gnome-browser-connector \
gnome-extensions-app gcc make cmake python3-devel nodejs docker-compose traceroute atop btop \
bottom eza bat ripgrep zoxide onefetch qbittorrent discord sqlite timeshift httpie gping \
audacious smplayer audacity blender gimp inkscape kdenlive krita vokoscreenNG thunderbird \
VirtualBox cabextract lzip p7zip p7zip-plugins unrar fontconfig uget nautilus-dropbox \
zlib-ng-compat.i686 ncurses-libs.i686 bzip2-libs.i686 alacritty \
tmux zsh procs rustup poetry uv pnpm rust golang tokei bandwhich kubernetes-client fd-find \
git-delta brave-browser dnfdragora vagrant nerd-fonts cargp npm yarnpkg perl-core perl-FindBin nushell
flatpak install flathub com.stremio.Stremio -y
flatpak install spotify -y
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
curl -fsSL https://pyenv.run | bash
curl https://get.volta.sh | bash
npm install -g corepack
npm install -g bun
cargo install bore-cli grex kmon mprocs volta zellij
# DOCKER CONFIG
sudo usermod -aG docker $USER
newgrp docker
# ohmyzsh
echo Y | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
## Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
# ~/.profile	Login shell (zsh, bash, etc.)	⚠️ Ideal para configs comuns a todos os shells

sudo dnf update -y --refresh
sudo dnf upgrade -y --refresh