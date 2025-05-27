{
  config,
  extendedLib,
  options,
  pkgs,
  ...
}:

with extendedLib;
let
  cfg = config.modules.desktop.apps.rofi;
in
{
  options.modules.desktop.apps.rofi = with types; {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      rofi
    ];

    home.configFile = {
      "rofi" = {
        source = ../../../config/rofi;
        recursive = true;
      };

      "lofi-rofi" = {
        source = ../../../config/lofi-rofi;
        recursive = true;
      };
    };
  };
}
