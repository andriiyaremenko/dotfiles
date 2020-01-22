alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
function elixir-language-server() {
  (~/.vim/language-servers/elixir-ls/release/language_server.sh $*)
}

