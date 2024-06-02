#!/bin/bash

# Prompt the user for a cask name
read -p "Enter the name of the cask you want to install: " cask_name

# Check if the Brewfile exists in the home directory, if not create it
brewfile_path="$HOME/Brewfile"

if [ ! -f "$brewfile_path" ]; then
  echo "Creating Brewfile at $brewfile_path"
  touch "$brewfile_path"
fi

# Append the cask to the Brewfile
echo "cask \"$cask_name\"" >> "$brewfile_path"

# Display the updated Brewfile
echo "Updated Brewfile:"
cat "$brewfile_path"

# Run brew bundle to install the cask
brew bundle --file="$brewfile_path"

echo "Cask $cask_name has been added to the Brewfile and installed."

