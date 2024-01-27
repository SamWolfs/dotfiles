# Initiated from https://github.com/sindrip/dotfiles/blob/main/nix/flake.nix
{
  description = "Nix home profile";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        inherit (nixpkgs.lib) optional;
        pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.buildEnv {
          name = "Home";
          paths = with pkgs; [
            # Core
            fd
            fzf
            gh
            git
            gnumake
            jq
            neovim
            protobuf
            ripgrep
            tmux
            tree

            # Shell
            zsh

            # Misc
            iosevka
            (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })

            # Kubernetes
            ctlptl
            kind
            kubectl
            kubelogin
            kubernetes-helm
            tilt

            # Languages
            beam.packages.erlangR26.elixir_1_15
            nixfmt
            rebar3
            rustup

            # Scripts
            (writeScriptBin "update-profile" ''
              #!${stdenv.shell}
              nix profile upgrade '.*'
            '')
          ];
          pathsToLink = [ "/share" "/bin" ];
          extraOutputsToInstall = [ "man" "doc" ];
        };

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
        #formatter = pkgs.nixfmt;
      });
}
