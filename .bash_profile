export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.mix/escripts:$PATH"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias emacs='/usr/local/Cellar/emacs/26.1_1/bin/emacs'
export LC_ALL=en_US.UTF-8
function elixir-language-server() {
  (~/.vim/language-servers/elixir-ls/release/language_server.sh $*)
}
