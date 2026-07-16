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
    ../modules/hosts
    ../modules/services
    ../modules/shell
    ../modules/themes
  ];

  home.username = "sam";
  home.homeDirectory = "/home/sam";

  nixpkgs.config.allowUnfreePredicate = _: true;

  home.packages = with pkgs; [
    # Core
    azure-cli
    devenv
    # dive
    firefox
    gh
    git
    google-cloud-sdk
    imagemagick
    # jujutsu
    (symlinkJoin {
      name = "obsidian";
      paths = [ obsidian ];
      buildInputs = [ makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/obsidian \
          --add-flags "--no-sandbox"
      '';
    })
    pass
    protobuf
    rtk
    tree
    totp-cli
    xst
    picom
    pavucontrol

    # Misc
    iosevka
    ffmpeg
    nerd-fonts.jetbrains-mono
    haskellPackages.greenclip
    # ffmpeg
    gimp
    # spotify
    # vlc
    wakatime-cli
    xclip
    xdg-ninja

    # DevOps
    actionlint
    apko

    # Languages
    luajit
    nixfmt
    # (python3.withPackages
    #   (python-pkgs: [ python-pkgs.python-dotenv python-pkgs.pyyaml python-pkgs.google-generativeai python-pkgs.google ]))
    rustup

    # Language Tools
    awscli2
    bashly
    bazel_7
    bazel-buildtools
    clang-tools
    claude-code
    gemini-cli
    httptoolkit
    markdownlint-cli
    openapi-generator-cli
    prometheus
    redli
    semgrep

    # ssl
    # srtp
    # openssl
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

  modules.editors = {
    cursor.enable = true;
    emacs = {
      enable = true;
      user = {
        fullName = "Sam Wolfs";
        mailAddress = "sam.wolfs@motorolasolutions.com";
      };
    };
  };

  modules.services = {
    dunst.enable = true;
  };

  modules.shell = {
    direnv.enable = true;
    tmux.enable = true;
    zsh.enable = true;
  };

  modules.host.name = "kqcb73-x02.ds.mot.com";
  modules.theme.active = "gruvbox";

  fonts.fontconfig.enable = true;

  home.stateVersion = "23.11";

  home.sessionVariables = {
    AWS_PROFILE = "ClaudeCodeLP";
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
