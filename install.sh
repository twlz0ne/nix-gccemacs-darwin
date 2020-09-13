#!/usr/bin/env bash
set -e

if ! command -v nix > /dev/null 2>&1; then
   echo "Nix not installed (use 'language: nix' in Travis)" >&2
   exit 1
fi

# Work around unfortunate issues in the MacOS Nix support on Travis
if [ "$(uname)" = "Darwin" ]; then
    sudo mkdir -p /etc/nix
    echo "trusted-users = root $USER" | sudo tee -a /etc/nix/nix.conf
    sudo launchctl kickstart -k system/org.nixos.nix-daemon || true
fi
