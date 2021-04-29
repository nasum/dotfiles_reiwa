# check install
if [[ ! -d ~/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

if [[ ! -d ~/.anyenv ]];then
  git clone https://github.com/anyenv/anyenv ~/.anyenv
fi

if [[ ! -d ~/.tfenv ]];then
  git clone https://github.com/tfutils/tfenv.git ~/.tfenv
fi

if [[ ! -d ~/.cargo ]];then
  curl https://sh.rustup.rs -sSf | sh
fi

if [[ ! -d ~/.deno ]];then
  curl -fsSL https://deno.land/x/install/install.sh | sh  
fi

source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# install plugin
zplug "dracula/zsh", as:theme
zplug "zsh-users/zsh-autosuggestions"
zplug "mollifier/cd-gitroot"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-completions"
zplug "mollifier/anyframe"
zplug "agkozak/zsh-z"

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
#export LANGUAGE="ja_JP.UTF-8"
#export LANG="${LANGUAGE}"
#export LC_ALL="${LANGUAGE}"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.anyenv/bin:$PATH"
export PATH="$HOME/.tfenv/bin:$PATH"
export EDITOR="emacs"
#export EDITOR='emacsclient -a "" -t'
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin
export PATH="$HOME/.z:$PATH"
export PATH="$PATH:/usr/lib/dart/bin"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"

## history
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

### 重複を記録しない
setopt hist_ignore_dups

### 開始と終了を記録
setopt EXTENDED_HISTORY

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

autoload -Uz vcs_info

ZSH_THEME="dracula"

# anyframe
bindkey '^R' anyframe-widget-execute-history
bindkey '^]' anyframe-widget-cd-ghq-repository

# alias
alias ls="ls --color=auto"
alias ll='ls -ltr'
alias la="ls -lhAF --color=auto"
alias gr="cd-gitroot"
alias demacs="emacs -q -l ~/.emacs.dev/init.el"
alias E='emacsclient -a "" -t'
alias ekill='emacsclient -e "(kill-emacs)"'
# prompt
zstyle ':vcs_info:*' formats '(%s)[%b]'
zstyle ':vcs_info:*' actionformats '(%s)[%b|%a]'
precmd () { vcs_info }
setopt prompt_subst

PROMPT="%{${fg[yellow]}%}%~%{${reset_color}%}
%{${fg[green]}%}[%n]@[%m]$ %{${reset_color}%}"

RPROMPT="%{${fg[blue]}%}[%* %D]%{${reset_color}%}"
RPROMPT='%{${fg[yellow]}%}${vcs_info_msg_0_}%{${reset_color}%}'$RPROMPT

# setup anyenv
eval "$(anyenv init -)"

echo "Start Zsh"

eval "$(direnv hook zsh)"

function git(){hub "$@"}

# Deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

[ -f $ZDOTDIR/.zshrc_`uname`  ] && . $ZDOTDIR/.zshrc_`uname`
