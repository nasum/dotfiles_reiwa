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
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux

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
export PATH="$HOME/.anyenv/bin:$PATH"
export PATH="$HOME/.tfenv/bin:$PATH"
export EDITOR="emacs"
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin
## coreutilsのため
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

export PATH="$HOME/.cargo/bin:$PATH"

## history
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
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

# functions
function peco-history-selection() {
    BUFFER=`history -n 1 | tail | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# alias
alias ls="ls --color=auto"
alias ll='ls -ltr'
alias la="ls -lhAF --color=auto"
alias gr="cd-gitroot"
alias open="xdg-open"

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
