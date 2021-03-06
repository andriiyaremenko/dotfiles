export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.mix/escripts:$PATH"
export PATH=$PATH:$(go env GOPATH)/bin
export PATH="$PATH:$HOME/.cargo/bin"
export LC_ALL=en_US.UTF-8
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
# Create as alias for nuget
alias nuget="mono /usr/local/bin/nuget.exe"

###-tns-completion-start-###
if [ -f /Users/andriiyaremenko/.tnsrc ]; then 
    source /Users/andriiyaremenko/.tnsrc 
fi
###-tns-completion-end-###

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
