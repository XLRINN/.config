#!/bin/bash

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Install Homebrew if not already installed
if ! command_exists brew; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed."
fi

# Install Nix if not already installed
if ! command_exists nix; then
  echo "Installing Nix..."
  sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume
else
  echo "Nix is already installed."
fi

