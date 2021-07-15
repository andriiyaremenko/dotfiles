#!/bin/zsh

if [[ $TERM_PROFILE == "Night" ]]; then
    tmux source-file "$HOME/.config/tmux/themes/Gruvbox-dark.conf"
else
    tmux source-file "$HOME/.config/tmux/themes/Gruvbox-light.conf"
fi
