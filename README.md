# Homebrew commands enhanced with fzf

Use the excellent [fzf](https://github.com/junegunn/fzf) to interactively install and uninstall [Homebrew](https://brew.sh/) formulae and casks.

## Usage

* `fbi`: Fuzzy brew install
* `fbui`: Fuzzy brew uninstall
* `fci`: Fuzzy cask install
* `fcui`: Fuzzy cask uninstall

You can specify a search parameter, e.g., `fbi git` will start your search with `git`.

## Additional functionality

Multiple options can be selected using `shift-tab` by default.

Previews (toggled using `?` by default) will show `brew info` for the selected formula or package.

You can visit the homepage of the formula or cask using `ctrl-space`.

## Getting started

### Install pre-requisites

1. Install [Homebrew](https://brew.sh/)
2. Install fzf: `brew install fzf`

### Install this plugin

#### `ohmyzsh`

1. cd ~/.oh-my-zsh/custom/plugins
2. git clone git@github.com:thirteen37/fzf-brew.git fzf-brew
3. Add `fzf-brew` to your `.zshrc` plugin list `plugins=(... fzf-brew)`

#### `zgen` or `zgenom`

Add ``zgenom load thirteen37/fzf-brew` or `zgenom load thirteen37/fzf-brew` to your `.zshrc`

#### `antigen`

Add ``antigen bundle thirteen37/fzf-brew` to your `.zshrc`
