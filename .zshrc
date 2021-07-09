export PATH="/opt/homebrew/opt/icu4c/bin:$PATH"
export PATH="/opt/homebrew/opt/icu4c/sbin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.mix/escripts:$PATH"
export PATH=$PATH:$(go env GOPATH)/bin
export PATH="$PATH:$HOME/.cargo/bin"
export LC_ALL=en_US.UTF-8

eval "$(starship init zsh)"

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
# Create as alias for nuget
alias nuget="mono /usr/local/bin/nuget.exe"

# I honestly do not remember what it is for
precmd () {print -Pn "\e]0;${PWD##*/}\a"}

my_ip() {
  echo $(curl -s https://ipinfo.io/ip || echo "-.-.-.-")
}

my_postal() {
  echo $(curl -s ipinfo.io/$(my_ip) || echo "{\"postal\": \"-----\"}" | jq '.postal')
}

my_lat_lon() {
  echo $(curl -s ipinfo.io/$(my_ip) || echo "{\"loc\": \"-,-\"}"  | jq '.loc')
}

daynight() {~/.tools/daynight -loc $(my_lat_lon)}

# automatically change kitty colors based on time of day
update_term_profile() {
  export TERM_PROFILE=$(daynight)

  if [[ $TERM_PROFILE == "Night" ]]; then
    echo """import:\n  - ~/.config/alacritty/themes/Gruvbox-dark.yml""" > ~/.config/alacritty/themes/theme.yml
    kitty @ set-colors -a -c "~/.config/kitty/themes/Gruvbox-dark.conf"
    export BAT_THEME="gruvbox-dark"
    export FZF_DEFAULT_OPTS='
    --color fg:#ebdbb2,bg:#32302f,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
    --color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54
    '
  else
    echo """import:\n  - ~/.config/alacritty/themes/Gruvbox-light.yml""" > ~/.config/alacritty/themes/theme.yml
    kitty @ set-colors -a -c "~/.config/kitty/themes/Gruvbox-light.conf"
    export BAT_THEME="gruvbox-light"
    export FZF_DEFAULT_OPTS='
    --color fg:#3c3836,bg:#f2e5bc,hl:#b57614,fg+:#3c3836,bg+:#ebdbb2,hl+:#b57614
    --color info:#076678,prompt:#665c54,spinner:#b57614,pointer:#076678,marker:#af3a03,header:#bdae93
    '
  fi

  # sleep 600

  # update_term_profile
}

# TODO: spin single job for all sessions
update_term_profile

export PGP_HOME_DIR=~/.config/gnupg
export GPG_TTY=$(tty)

zstyle ':completion:*' menu select
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit && compinit
zmodload -i zsh/complist

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.local.zsh ] && source ~/.local.zsh
