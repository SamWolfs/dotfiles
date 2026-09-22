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
      system = "x86_64-linux";
      extraPackagesOverlay = final: prev: {
        peon-ping = peon-ping.packages.${system}.default;
        herdr = herdr.packages.${system}.default;
      };
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ extraPackagesOverlay ];
      };
      args = {
        inherit self home-manager pkgs;
        inherit (nixpkgs) lib;
      };
      lib = import ./lib args;
      homeModules = {
        home     = ./modules/home.nix;
        desktop  = ./modules/desktop;
        editors  = ./modules/editors;
        dev      = ./modules/dev;
        services = ./modules/services;
        shell    = ./modules/shell;
        themes   = ./modules/themes;
        peonPing = peon-ping.homeManagerModules.default;
      };
    in
    {
      inherit lib homeModules;
      overlays.default = extraPackagesOverlay;

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
