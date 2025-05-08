#!/bin/bash

# get the folders in ../neovim/.config
dir=($(find .config/ -maxdepth 1 -type d -not -name '.config' -not -name '..' | sort))

config=$(printf "%s\n" "${dir[@]}" | fzf --prompt="Neovim Config " --height=~50% --layout=reverse --border --exit-0)
if [[ -z $config ]]; then
    echo "Nothing selected"
    exit 1
elif [[ $config == "v0" ]]; then
    config=""
fi
config=${config#*.config/}
config=${config%/}
config=${config#./}

NVIM_APPNAME=$config nvim $@