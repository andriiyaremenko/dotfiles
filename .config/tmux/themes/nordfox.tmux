#!/usr/bin/env bash
# Nightfox colors for Tmux
# Style: nordfox
# Upstream: https://github.com/edeneast/nightfox.nvim/raw/main/extra/nordfox/nightfox_tmux.tmux
set -g mode-style "fg=#a3be8c,bg=#3b4252"
set -g message-style "fg=#a3be8c,bg=#3b4252"
set -g message-command-style "fg=#a3be8c,bg=#3b4252"
set -g pane-border-style "fg=#c9826b"
set -g pane-active-border-style "fg=#a3be8c"
set -g status "on"
set -g status-justify "left"
set -g status-style "fg=#a3be8c,bg=#3b4252"
set -g status-left-length "100"
set -g status-right-length "100"
set -g status-left-style NONE
set -g status-right-style NONE
set -g status-left "#[fg=#3b4252,bg=#a3be8c,bold] #S #[fg=#a3be8c,bg=#3b4252,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=#3b4252,bg=#3b4252,nobold,nounderscore,noitalics]#[fg=#a3be8c,bg=#3b4252] #{prefix_highlight} #[fg=#a3be8c,bg=#3b4252,nobold,nounderscore,noitalics]#[fg=#3b4252,bg=#a3be8c] %H:%M ╲ %Y-%m-%d #[fg=#3b4252,bg=#a3be8c,nobold,nounderscore,noitalics]╲#[fg=#3b4252,bg=#a3be8c,bold] #h "
setw -g window-status-activity-style "underscore,fg=#7e8188,bg=#3b4252"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#7e8188,bg=#3b4252"
setw -g window-status-format "#[fg=#3b4252,bg=#3b4252,nobold,nounderscore,noitalics]#[default] #I ╱ #W #F #[fg=#3b4252,bg=#3b4252,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#3b4252,bg=#a3be8c,nobold,nounderscore,noitalics]#[fg=#3b4252,bg=#a3be8c,bold] #I ╱ #W #F #[fg=#a3be8c,bg=#3b4252,nobold,nounderscore,noitalics]"
