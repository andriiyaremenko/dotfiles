export PATH="/opt/homebrew/opt/icu4c/bin:$PATH"
export PATH="/opt/homebrew/opt/icu4c/sbin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.mix/escripts:$PATH"
export PATH=$PATH:$(go env GOPATH)/bin
export PATH="$PATH:$HOME/.cargo/bin"
export LC_ALL=en_US.UTF-8

eval "$(starship init zsh)"

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
  echo $(curl -s https://ipinfo.io/postal || echo "-.-.-.-")
}

location() {
  echo $(curl -s https://ipinfo.io/loc || echo "-.-.-.-")
}

weather() {
    if [ "$1" != "" ]; then
        echo "$1"
        curl http://wttr.in/"$1"
    else
        curl http://wttr.in/
    fi
}

export MY_LAT_LON=$(my_lat_lon)

daynight() {~/.tools/daynight -loc $(my_lat_lon)}

# automatically change colors based on time of day
update_term_profile() {
  if [[ $TERM_PROFILE == "Night" ]]; then
    echo """import:\n  - ~/.config/alacritty/themes/Gruvbox-dark.yml""" > ~/.config/alacritty/themes/theme.yml
    tmux source-file "$HOME/.config/tmux/themes/Gruvbox-dark.conf"
    export BAT_THEME="gruvbox-dark"
    export FZF_DEFAULT_OPTS='
    --color fg:#ebdbb2,bg:#32302f,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
    --color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54
    '
  else
    echo """import:\n  - ~/.config/alacritty/themes/Gruvbox-light.yml""" > ~/.config/alacritty/themes/theme.yml
    tmux source-file "$HOME/.config/tmux/themes/Gruvbox-light.conf"
    export BAT_THEME="gruvbox-light"
    export FZF_DEFAULT_OPTS='
    --color fg:#3c3836,bg:#f2e5bc,hl:#b57614,fg+:#3c3836,bg+:#ebdbb2,hl+:#b57614
    --color info:#076678,prompt:#665c54,spinner:#b57614,pointer:#076678,marker:#af3a03,header:#bdae93
    '
  fi

  # sleep 600

  # update_term_profile
}

auto_theme() {
  export TERM_PROFILE=$(daynight)
  update_term_profile
}

dark_theme() {
  export TERM_PROFILE="Night"
  update_term_profile
}

light_theme() {
  export TERM_PROFILE="Day"
  update_term_profile
}

dark_theme

export PGP_HOME_DIR=~/.config/gnupg
export GPG_TTY=$(tty)

zstyle ':completion:*' menu select
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit && compinit
zmodload -i zsh/complist

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.local.zsh ] && source ~/.local.zsh

if [ "$TMUX" = "" ]; then tmux; fi
