{
  extendedLib,
  config,
  options,
  pkgs,
  ...
}:

with extendedLib;
let
  cfg = config.modules.desktop.terminal.kitty;
in
{
  options.modules.desktop.terminal.kitty = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ ];

    home.configFile."kitty" = {
      source = ../../../config/kitty;
      recursive = true;
    };
  };
}
