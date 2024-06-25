{

description = "DARWIN-LOKI";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    darwin.url = "github:LnL7/nix-darwin";
    home-manager.url = "github:nix-community/home-manager/master";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, darwin, nix-homebrew, ... }:
    let
      system = "x86_64-darwin";
      pkgs = import nixpkgs {
        system = system;
        config.allowUnfree = true;
      };
    in {
      darwinConfigurations = {
        loki = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = [
            {
              services.nix-daemon.enable = true;
              system.stateVersion = 4;
            }
          ];
        };
      };

      homeConfigurations = {
        david = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
          ];
        };
      };

      modules = [
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            user = "david";
            autoMigrate = true;
          };
        }
        {
          # Module to read and install Homebrew packages from Brewfile
          homebrewPackages = pkgs.stdenv.mkDerivation {
            name = "homebrew-packages";
            src = /Users/david/.config/Brewfile;  # Path to your Brewfile
            buildPhase = ''
              export HOMEBREW_NO_AUTO_UPDATE=1
              homebrewPath=${pkgs.brew}/bin
              $homebrewPath/brew bundle --file=$src
            '';
            installPhase = ''
              echo "Homebrew packages installed"
            '';
          };
        }
      ];
    };
}

