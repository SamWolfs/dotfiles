{ config, pkgs, nixpkgs, ... }:

{
  home.username = "besam";
  home.homeDirectory = "/home/besam";

  # Allow unfree packages (e.g. Discord, Spotify)
  nixpkgs.config.allowUnfreePredicate = _: true;

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    yq-go # yaml processer https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’

    # Core
    # emacs
    android-studio
    fd
    fzf
    gh
    git
    gnumake
    jq
    neovim
    pass
    protobuf
    ripgrep
    rofi
    tmux
    tree
    xst
    picom
    pavucontrol

    # Shell
    zsh

    # Misc
    discord
    iosevka
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    gimp
    spotify
    vlc
    wakatime
    xclip

    # Kubernetes
    argocd
    ctlptl
    docker-compose
    k9s
    kind
    kubectl
    kubelogin
    kubernetes-helm
    talosctl
    tilt

    # Languages
    beam.packages.erlangR26.elixir_1_15
    flutter
    go_1_21
    luajit
    nixfmt
    nodejs
    (python3.withPackages (python-pkgs: [
      python-pkgs.python-dotenv
      python-pkgs.pyyaml
    ]))
    rebar3
    ruby
    rustup

    # Language Tools
    bashly
    hugo
    revive
    shellcheck
    shfmt
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Sam Wolfs";
    userEmail = "be.samwolfs@gmail.com";
  };

  fonts.fontconfig.enable = true;

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
