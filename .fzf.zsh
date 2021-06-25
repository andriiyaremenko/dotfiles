# Setup fzf
# ---------
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

if [[ $TERM_PROFILE == "dark" ]]; then
export FZF_DEFAULT_OPTS='
  --color fg:#ebdbb2,bg:#32302f,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
  --color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54
'
else
export FZF_DEFAULT_OPTS='
  --color fg:#3c3836,bg:#f2e5bc,hl:#b57614,fg+:#3c3836,bg+:#ebdbb2,hl+:#b57614
  --color info:#076678,prompt:#665c54,spinner:#b57614,pointer:#076678,marker:#af3a03,header:#bdae93
'
fi
