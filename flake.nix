# Initialized from https://github.com/sindrip/dotfiles/blob/main/nix/flake.nix
{
  description = "Nix home profile";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils, home-manager, ... }@inputs:
    let
      args = {
        inherit self home-manager;
        inherit (nixpkgs) lib;
        pkgs = nixpkgs.legacyPackages.${system};
      };
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib = import ./lib args;
    in {
      environment.shells = with pkgs; [ zsh ];
      users.defaultUserShell = pkgs.zsh;

      packages.bootstrap = pkgs.writeShellApplication {
        name = "bootstrap";
        runtimeInputs = [ pkgs.git pkgs.nix ];
        text = ''
          DEST="$HOME/.dotfiles"
          if [ ! -d "$DEST" ]; then
            echo "Cloning dotfiles repo to $DEST..."
            git clone https://github.com/SamWolfs/dotfiles.git "$DEST"
          else
            echo "Dotfiles already exist at $DEST, skipping clone."
          fi

          cd "$DEST"
          echo "Applying home-manager configuration..."
          # Use nix run to ensure home-manager is available even on fresh installs
          nix run nixpkgs#home-manager -- switch --flake ".#$HOST"
        '';
      };

      homeConfigurations = lib.mapHosts ./hosts {
        inherit pkgs lib;
      };
    };
}
