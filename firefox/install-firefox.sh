#!/usr/bin/env bash

profile_dir=$(find ~/.mozilla/firefox -maxdepth 1 -name '*.default-release' | head -1)

[ ! -d ~/.dotfiles/firefox/Betterfox ] && \
  git clone https://github.com/yokoffing/Betterfox.git ~/.dotfiles/firefox/Betterfox

ln -sf ~/.dotfiles/firefox/Betterfox/user.js "$profile_dir/user.js"

# append overrides
cat ~/.dotfiles/firefox/user-overrides.js >> "$profile_dir/user.js"
