{ pkgs, ... }: {
  home.username = "david"; # REPLACE ME
  home.homeDirectory = "/Users/david"; # REPLACE ME
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

 home.packages =  with pkgs; [
    sl
#   hollywood
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
  ];

  programs.git = {
    enable = true;
    includes = [{ path = "~/.config/gitconfig"; }];
  };

}
