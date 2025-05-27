{
  config,
  extendedLib,
  pkgs,
  nixpkgs,
  ...
}:

with extendedLib;
let
  cfg = config.home;
  lib = extendedLib;
in
{
  imports = [
    ../modules/home.nix
    ../modules/desktop
    ../modules/editors
    ../modules/dev
    ../modules/services
    ../modules/shell
    ../modules/themes
  ];

  home.username = "besam";
  home.homeDirectory = "/home/besam";

  nixpkgs.config.allowUnfreePredicate = _: true;

  home.packages = with pkgs; [
    maelstrom-clj

    # Core
    # aider-chat
    azure-cli
    devenv
    dive
    gh
    git
    google-cloud-sdk
    imagemagick
    jujutsu
    obsidian
    pass
    protobuf
    tree
    xst
    picom
    pavucontrol

    # Misc
    discord
    iosevka
    nerd-fonts.jetbrains-mono
    ffmpeg
    gimp
    spotify
    vlc
    wakatime
    xclip

    # Languages
    luajit
    nixfmt-rfc-style
    # (python3.withPackages
    #   (python-pkgs: [ python-pkgs.python-dotenv python-pkgs.pyyaml python-pkgs.google-generativeai python-pkgs.google ]))
    ruby
    rustup

    # gamedev
    gdtoolkit_4

    # Language Tools
    bashly
    go-task

    # ssl
    srtp
    openssl
  ];

  modules.desktop = {
    apps = {
      rofi.enable = true;
    };
    i3.enable = true;
    terminal.kitty.enable = true;
  };

  modules.dev = {
    elixir.enable = true;
    golang = {
      enable = true;
      tooling.enable = true;
    };
    json = {
      enable = true;
      yaml.enable = true;
    };
    node.enable = true;
    shell.enable = true;
  };

  modules.editors.emacs.enable = true;

  modules.services = {
    dunst.enable = true;
  };

  modules.shell = {
    direnv.enable = true;
    zsh.enable = true;
  };

  modules.theme.active = "gruvbox";

  fonts.fontconfig.enable = true;

  home.stateVersion = "23.11";

  home.sessionVariables = {
    # FIXME: Uncommenting breaks Nix
    # LIBCLANG_PATH = "${pkgs.libclang.lib}/lib";
    # LD_LIBRARY_PATH = lib.makeLibraryPath [
    #   "/usr/local/lib"
    #   pkgs.openssl
    #   pkgs.srtp
    # ];
  };

  programs.home-manager.enable = true;
}
