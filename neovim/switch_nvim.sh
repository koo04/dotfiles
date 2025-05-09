#!/bin/bash

if ! command -v fzf &>/dev/null; then
  sudo apt install fzf
fi

dir=($(find $(dirname "$0")/.config/ -maxdepth 1 -type d -not -name '.config' -not -name '..' | sort))
config=$(printf "%s\n" "${dir[@]}" | fzf --prompt="Neovim Config " --layout=reverse --border --exit-0)
if [[ -z $config ]]; then
  echo "Nothing selected"
  exit 1
elif [[ $config == "v0" ]]; then
  config=""
fi
config=${config#*.config/}
config=${config%/}
config=${config#./}

# NVIM_APPNAME=$config nvim $@
