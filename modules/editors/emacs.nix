{
  config,
  extendedLib,
  options,
  pkgs,
  ...
}:

with extendedLib;
let
  cfg = config.modules.editors.emacs;
in
{
  options.modules.editors.emacs = with types; {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ ];

    home.configFile."doom" = {
      source = ../../config/doom;
      recursive = true;
    };

    home.sessionVariables = {
      DOOM = "$HOME/.config/emacs/bin";
      EDITOR = "emacs";
    };

    home.sessionPath = [
      "$DOOM"
    ];
  };
}
