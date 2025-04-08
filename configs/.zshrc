# PLUGINS

plugins=(git zsh-autosuggestions zsh-syntax-highlighting docker kubectl docker-compose)
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# PYENV

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"


# NVM

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# RUST

export PATH="$HOME/.cargo/bin:$PATH"

# UV 

# Auto Complete
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# ALIAS

# Print All Collors
alias colors='for x in {0..8}; do for i in {30..37}; do for a in {40..47}; do echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "; done; echo; done; done; echo ""'

# Change Theme
# starship   # ativa o prompt do Starship
# omz        # volta pro tema do Oh My Zsh

# Alternância entre Starship e Oh My Zsh
if [[ "$USE_STARSHIP" == "1" ]]; then
    eval "$(starship init zsh)"
fi

# Funções para alternar facilmente
function starship() {
    export USE_STARSHIP=1
    source ~/.zshrc
}

function omz() {
    export USE_STARSHIP=0
    source ~/.zshrc
}
