#!/bin/bash

versions=($(ls -d ${PWD}/neovim/.config/v* 2>/dev/null))
versionNames=($(ls -d ${PWD}/neovim/.config/v* 2>/dev/null | xargs -n 1 basename))
length=${#versions[@]}

for ((i=0;i<length;i++)); do
  if [ -L "${HOME}/.config/${versionNames[$i]}" ]; then
    echo "Symbolic link ~/.config/${versionNames[$i]} already exists, skipping."
  else
    echo "Creating symbolic link ~/.config/${versionNames[$i]} -> ${versions[$i]}"
    ln -s "${versions[$i]}" "${HOME}/.config/${versionNames[$i]}"
  fi

  # Check if the alias "n{versionName}" already exists
  if ! grep -q "alias n${versionNames[$i]}" ~/.bashrc; then
    echo "Adding alias n${versionNames[$i]} to ~/.bashrc"
    echo "alias n${versionNames[$i]}='NVIM_APPNAME=${versionNames[$i]} nvim'" >> ~/.bashrc
  else
    echo "Alias n${versionNames[$i]} already exists in ~/.bashrc, skipping."
  fi
done
