# Initialized from https://github.com/sindrip/dotfiles/blob/main/nix/flake.nix
{
  description = "Nix home profile";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, flake-utils, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      environment.shells = with pkgs; [ zsh ];
      users.defaultUserShell = pkgs.zsh;

      packages.bootstrap = pkgs.writeShellApplication {
        name = "bootstrap";
        runtimeInputs = [ pkgs.git ];
        text = ''
          echo "Initializing dotfiles repo: $HOME/.cfg/" && \
          git clone --bare https://github.com/SamWolfs/dotfiles-v2.git $HOME/.cfg/ && \
          git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout && \
          cd $HOME/nix && \
          nix profile install
        '';
      };

      homeConfigurations = {
        besam = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./hosts/niflheim.nix ];
        };
      };
    };
}
