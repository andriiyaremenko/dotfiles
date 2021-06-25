export PATH="/opt/homebrew/opt/icu4c/bin:$PATH"
export PATH="/opt/homebrew/opt/icu4c/sbin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.mix/escripts:$PATH"
export PATH=$PATH:$(go env GOPATH)/bin
export PATH="$PATH:$HOME/.cargo/bin"
export LC_ALL=en_US.UTF-8
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
# Create as alias for nuget
alias nuget="mono /usr/local/bin/nuget.exe"

precmd () {print -Pn "\e]0;${PWD##*/}\a"}

###-tns-completion-start-###
if [ -f /Users/andriiyaremenko/.tnsrc ]; then 
    source /Users/andriiyaremenko/.tnsrc 
fi
###-tns-completion-end-###

# automatically change kitty colors based on time of day
if [[ "$(uname -s)" == "Darwin" ]]; then
  val=$(defaults read -g AppleInterfaceStyle 2>/dev/null)
  if [[ $val == "Dark" ]]; then
      export TERM_PROFILE="dark"
  else
      export TERM_PROFILE="light"
  fi
fi

if [[ $TERM_PROFILE == "dark" ]]; then
    kitty @ set-colors -a -c "~/.config/kitty/themes/Gruvbox-dark.conf"
    export BAT_THEME="gruvbox-dark"
else
    kitty @ set-colors -a -c "~/.config/kitty/themes/Gruvbox-light.conf"
    export BAT_THEME="gruvbox-light"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
