# check install
if [[ ! -d ~/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# install dracula thema
zplug "dracula/zsh", as:theme

zplug "zsh-users/zsh-autosuggestions", as:plugins

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

# alias
alias ls="ls --color=auto"
alias ll='ls -ltr'
alias la="ls -lhAF --color=auto"

echo "Start Zsh"