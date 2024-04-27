#!/usr/bin/env zsh

if ! (( $+commands[brew] )); then
    echo 'brew command not found: please install via https://brew.sh/'
    return
fi

if ! (( $+commands[fzf] )); then
    echo 'fzf command not found: please install via "brew install fzf"'
    return
fi

FB_FORMULA_PREVIEW='HOMEBREW_COLOR=true brew info {}'
FB_FORMULA_BIND="ctrl-space:execute-silent(brew home {})"
FB_CASK_PREVIEW='HOMEBREW_COLOR=true brew info --cask {}'
FB_CASK_BIND="ctrl-space:execute-silent(brew home --cask {})"

# completion bindings
function _fzf_complete_brew() {
    local arguments=$@

    if [[ $arguments == 'brew install --cask'* ]]; then
        _fzf_complete -m --preview $FB_FORMULA_PREVIEW --bind $FB_FORMULA_BIND -- "$@" < <(brew casks)
    elif [[ $arguments == 'brew uninstall --cask'* ]]; then
        _fzf_complete -m --preview $FB_FORMULA_PREVIEW --bind $FB_FORMULA_BIND -- "$@" < <(brew list --cask)
    elif [[ $arguments == 'brew install'* ]]; then
        _fzf_complete -m --preview $FB_FORMULA_PREVIEW --bind $FB_FORMULA_BIND -- "$@" < <(brew formulae)
    elif [[ $arguments == 'brew uninstall'* ]]; then
        _fzf_complete -m --preview $FB_FORMULA_PREVIEW --bind $FB_FORMULA_BIND -- "$@" < <(brew leaves)
    else
        eval "zle ${fzf_default_completion:-expand-or-complete}"
    fi
}

# functions
function fuzzy_brew_install() {
    local inst=$(brew formulae | fzf --query="$1" -m --preview $FB_FORMULA_PREVIEW --bind $FB_FORMULA_BIND)

    if [[ $inst ]]; then
        for prog in $(echo $inst); do; brew install $prog; done;
    fi
}

function fuzzy_brew_uninstall() {
    local uninst=$(brew leaves | fzf --query="$1" -m --preview $FB_FORMULA_PREVIEW --bind $FB_FORMULA_BIND)

    if [[ $uninst ]]; then
        for prog in $(echo $uninst);
        do; brew uninstall $prog; done;
    fi
}

function fuzzy_cask_install() {
    local inst=$(brew casks | fzf --query="$1" -m --preview $FB_CASK_PREVIEW --bind $FB_CASK_BIND)

    if [[ $inst ]]; then
        for prog in $(echo $inst); do; brew install --cask $prog; done;
    fi
}

function fuzzy_cask_uninstall() {
    local inst=$(brew list --cask | fzf --query="$1" -m --preview $FB_CASK_PREVIEW --bind $FB_CASK_BIND)

    if [[ $inst ]]; then
        for prog in $(echo $inst); do; brew uninstall --cask $prog; done;
    fi
}

function __setup_fzf_brew() {
    alias fbi=fuzzy_brew_install
    alias fbui=fuzzy_brew_uninstall
    alias fci=fuzzy_cask_install
    alias fcui=fuzzy_cask_uninstall
}

__setup_fzf_brew
