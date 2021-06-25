function fuzzy_brew_install() {
    local inst=$(brew formulae | fzf --query="$1" -m --preview 'HOMEBREW_COLOR=true brew info {}' --bind="ctrl-space:execute-silent(brew home {})")

    if [[ $inst ]]; then
        for prog in $(echo $inst); do; brew install $prog; done;
    fi
}

function fuzzy_brew_uninstall() {
    local uninst=$(brew leaves | fzf --query="$1" -m --preview 'HOMEBREW_COLOR=true brew info {}' --bind="ctrl-space:execute-silent(brew home {})")

    if [[ $uninst ]]; then
        for prog in $(echo $uninst);
        do; brew uninstall $prog; done;
    fi
}

function fuzzy_cask_install() {
    local inst=$(brew casks | fzf --query="$1" -m --preview 'HOMEBREW_COLOR=true brew info --cask {}' --bind="ctrl-space:execute-silent(brew home --cask {})")

    if [[ $inst ]]; then
        for prog in $(echo $inst); do; brew install --cask $prog; done;
    fi
}

function fuzzy_cask_uninstall() {
    local inst=$(brew list --cask | fzf --query="$1" -m --preview 'HOMEBREW_COLOR=true brew info --cask {}' --bind="ctrl-space:execute-silent(brew home --cask {})")

    if [[ $inst ]]; then
        for prog in $(echo $inst); do; brew uninstall --cask $prog; done;
    fi
}

function __setup_fzf_brew() {
    alias fbi=fuzzy_brew_install
    alias fbui=fuzzy_brew_uninstall
    alias fci=fuzzy_brew_install
    alias fcui=fuzzy_brew_uninstall
}

if (( $+commands[brew] )); then
    if (( $+commands[fzf] )); then
        __setup_fzf_brew
    else
        echo 'fzf command not found: please install via "brew install fzf"'
    fi
else
    echo 'brew command not found: please install via https://brew.sh/'
fi
