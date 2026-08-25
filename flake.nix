# Initialized from https://github.com/sindrip/dotfiles/blob/main/nix/flake.nix
{
  description = "Nix home profile";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    peon-ping.url = "github:PeonPing/peon-ping";
    peon-ping.inputs.nixpkgs.follows = "nixpkgs";
    herdr.url = "github:herdrdev/herdr/v0.8.0";
  };

  outputs = { self, nixpkgs, flake-utils, home-manager, peon-ping, herdr, ... }@inputs:
    let
      args = {
        inherit self home-manager;
        inherit (nixpkgs) lib;
        pkgs = nixpkgs.legacyPackages.${system};
      };
      system = "x86_64-linux";
      # Expose flake-input packages that aren't in nixpkgs (e.g. peon-ping) as
      # `pkgs.<name>` so modules can refer to them like any other package.
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            peon-ping = peon-ping.packages.${system}.default;
            herdr = herdr.packages.${system}.default;
          })
        ];
      };
      lib = import ./lib args;
    in {
      packages.${system} = {
        bootstrap = pkgs.writeShellApplication {
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
      };

      homeConfigurations = lib.mapHosts ./hosts {
        inherit pkgs lib;
        extraModules = [ peon-ping.homeManagerModules.default ];
      };
    };
}
