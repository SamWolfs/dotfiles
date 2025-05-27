{
  config,
  extendedLib,
  options,
  pkgs,
  ...
}:

with extendedLib;
let
  cfg = config.modules.shell.zsh;
in
{
  options.modules.shell.zsh = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      at
      bat # a better cat
      bc
      dust # a better du
      eza # a better ls
      fasd
      fd
      fzf
      gnumake
      neovim
      nix-zsh-completions
      ripgrep # a better grep
      tokei # for code statistics
      unar
    ];

    programs.zsh = {
      enable = true;
      # TODO: Is there another way that uses XDG_CONFIG?
      dotDir = ".config/zsh";
      enableCompletion = true;
      # Again. I configure the prompt myself, so disable the default.
      # promptInit = "";
      # Respect XDG please!
      history.path = "${config.home.stateDir}/zsh/history";
      # Implement these manually (and with caching)
      # enableLsColors = false;
      oh-my-zsh = {
        enable = true;
        custom = "$XDG_CONFIG_HOME/oh-my-zsh";
        plugins = [
          "direnv"
          "git"
          "history"
          "fzf"
        ];
        theme = config.modules.theme.active;
      };

      shellAliases = {
        k = "kubectl";
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";
        l = "ls -lFh";
        la = "ls -lAFh";
        lr = "ls -tRFh";
        lt = "ls -ltFh";
        ll = "ls -l";
        ldot = "ls -ld .*";
        lS = "ls -1FSsh";
        lart = "ls -1Fcart";
        lrt = "ls -1Fcrt";
        update-profile = "home-manager switch --flake $HOME/nix#$USER";
        pls = "please";
        please = "sudo $(fc -ln -1)";
      };
    };

    home.sessionVariables = {
      LANG = "en_US.UTF-8";
      LOCAL = "$HOME/.local/bin";
      ZDOTDIR = "${config.home.configDir}/zsh";
      ZGEN_DIR = "${config.home.dataDir}/zgenom";
      _FASD_DATA = "${config.home.cacheDir}/fasd";
      _FASD_VIMINFO = "${config.home.cacheDir}/viminfo";
    };

    home.sessionPath = [
      "$LOCAL"
    ];

    home.configFile = {
      # Link individual files (recursively), rather than whole directory, so
      # other modules (or the user) can write files there later.
      # "zsh" = {
      #   source = ../../config/zsh;
      #   recursive = true;
      # };

      "oh-my-zsh" = {
        source = ../../config/oh-my-zsh;
        recursive = true;
      };
    };
  };
}
