function fish_greeting
end

set -e fish_user_paths

fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/opt/icu4c/bin $fish_user_paths
fish_add_path /opt/homebrew/opt/icu4c/sbin $fish_user_paths
fish_add_path /usr/local/sbin $fish_user_paths
fish_add_path $HOME/.mix/escripts $fish_user_paths
fish_add_path $fish_user_paths (go env GOPATH)/bin
fish_add_path $fish_user_paths $HOME/.cargo/bin

set -x LC_ALL en_US.UTF-8

alias config '/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
# Create as alias for nuget
alias nuget "mono /usr/local/bin/nuget.exe"

function precmd
    -Pn "\e]0;{PWD##*/}\a"
end

function my_ip
    curl -s https://ipinfo.io/ip
end
function my_postal
    set ip (my_ip)
    test -n "$ip"; and curl -s ipinfo.io/"$ip" | jq '.postal'; or echo "-----"
end
function my_lat_lon
    set ip (my_ip)
    test -n "$ip"; and curl -s ipinfo.io/"$ip" | jq '.loc'; or echo "-,-"
end

function daynight
    ~/.tools/daynight -loc (my_lat_lon)
end

set -x TERM_PROFILE (daynight)

if [ $TERM_PROFILE = "Night" ];
    kitty @ set-colors -a -c "~/.config/kitty/themes/Gruvbox-dark.conf"
    set -x BAT_THEME "gruvbox-dark"
else
    kitty @ set-colors -a -c "~/.config/kitty/themes/Gruvbox-light.conf"
    set -x BAT_THEME "gruvbox-light"
end

if [ $TERM_PROFILE = "Night" ];
set -x FZF_DEFAULT_OPTS '
  --color fg:#ebdbb2,bg:#32302f,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
  --color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54
'
else
set -x FZF_DEFAULT_OPTS '
  --color fg:#3c3836,bg:#f2e5bc,hl:#b57614,fg+:#3c3836,bg+:#ebdbb2,hl+:#b57614
  --color info:#076678,prompt:#665c54,spinner:#b57614,pointer:#076678,marker:#af3a03,header:#bdae93
'
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source
