# check install
if [[ ! -d ~/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# install dracula thema
zplug "dracula/zsh", as:theme

zplug "zsh-users/zsh-autosuggestions"

zplug "mollifier/cd-gitroot"

zplug "zsh-users/zsh-history-substring-search"

zplug "zsh-users/zsh-completions"

## command
zplug "peco/peco", as:command, from:gh-r
zplug "junegunn/fzf-bin", as:command, from:gh-r, file:fzf
zplug "junegunn/fzf", as:command, of:bin/fzf-tmux

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi
# Then, source plugins and add commands to $PATH
zplug load --verbose

source ~/.zplug/repos/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh

# export
export LANGUAGE="ja_JP.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export PATH="$HOME/bin:$PATH"
export EDITOR="emacs"

## history
export HISTFILE="${ZDOTDIR}/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=${HISTSIZE}

# zsh setting
## prompt colors
autoload -Uz colors
colors

## auto complete
autoload -Uz compinit
compinit

## emacs keybind
bindkey -e

## no cd
setopt auto_cd

## fix typo
setopt correct

setopt hist_expand

setopt auto_param_keys

setopt auto_param_slash

setopt mark_dirs

setopt list_types

ZSH_THEME="dracula"

# functions
function peco-history-selection() {
    BUFFER=`history -n 1 | tail | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

# alias
alias ls="ls --color=auto"
alias ll='ls -ltr'
alias la="ls -lhAF --color=auto"
alias gr="cd-gitroot"

echo "Start Zsh"