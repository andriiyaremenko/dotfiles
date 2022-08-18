export PATH="/opt/homebrew/opt/icu4c/bin:$PATH"
export PATH="/opt/homebrew/opt/icu4c/sbin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.mix/escripts:$PATH"
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export LC_ALL=en_US.UTF-8
export TERM_PROFILE="Night"

eval "$(starship init zsh)"

ulimit -u 2048
ulimit -n 2048

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
# Create as alias for nuget
alias nuget="mono /usr/local/bin/nuget.exe"

# alias for neovim
alias vim="nvim"
alias vi="nvim"

# python
alias python=python3

# alias ctags
alias ctags="`brew --prefix`/bin/ctags"

# alias tmux="TERM=screen-256color-bce tmux"

# I honestly do not remember what it is for
precmd () {print -Pn "\e]0;${PWD##*/}\a"}

ip() {
  echo $(curl -s https://ipinfo.io/ip || echo "-.-.-.-")
}

postal() {
  echo $(curl -s https://ipinfo.io/postal || echo "-----")
}

location() {
  echo $(curl -s https://ipinfo.io/loc || echo "--.----,--.----")
}

city() {
  echo $(curl -s https://ipinfo.io/city || echo "Kyiv")
}

weather() {
    if [ "$1" != "" ]; then
        curl http://wttr.in/"$1"
    else
        curl http://wttr.in/$(city)
    fi
}

export MY_LAT_LON=$(location)

tmux source-file "$HOME/.tmux.conf"
tmux source-file "$HOME/.config/tmux/themes/nordfox.tmux"

export BAT_THEME="Nord"
export FZF_DEFAULT_OPTS='
--color=fg:#e5e9f0,bg:#2e3440,hl:#81a1c1
--color=fg+:#e5e9f0,bg+:#2e3440,hl+:#81a1c1
--color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
--color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b
'

export PGP_HOME_DIR=~/.config/gnupg
export GPG_TTY=$(tty)

zstyle ':completion:*' menu select
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit && compinit
zmodload -i zsh/complist

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.local.zsh ] && source ~/.local.zsh

if [ "$TMUX" = "" ]; then tmux; fi
