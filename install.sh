#!/bin/bash

if [ -d ~/.config/nvim ]; then
  rm -rf ~/.config/nvim
fi
git clone https://github.com/Mopsgamer/neovim-init.git ~/.config/nvim
