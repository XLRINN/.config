{ pkgs, ... }: {
  home.username = "david"; # REPLACE ME
  home.homeDirectory = "/Users/david"; # REPLACE ME
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

 home.packages =  with pkgs; [
    sl
    neovim 
    lazygit
    ranger
    neofetch
    git
    tmux
    bitwarden-cli
    thefuck
    zoxide
    fzf
    pkgs.fontconfig
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];


  programs.git = {
    enable = true;
    includes = [{ path = "~/.config/gitconfig"; }];
  };


  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      # add_newline = false;

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      # package.disabled = true;
    };
  };



/*
programs.zsh = {
    enable = true;
    initExtra = builtins.readFile ./.zshrc;
  };
*/

}
