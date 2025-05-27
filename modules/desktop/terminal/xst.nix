{
  extendedLib,
  config,
  options,
  pkgs,
  ...
}:

with extendedLib;
let
  cfg = config.modules.desktop.terminal.xst;
in
{
  options.modules.desktop.terminal.xst = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      xst # st + nice-to-have extensions
      (mkLauncherEntry "Suckless Terminal" {
        description = "Open default terminal application";
        icon = "utilities-terminal";
        exec = "${xst}/bin/xst";
        categories = [
          "Development"
          "System"
          "Utility"
        ];
      })
    ];
  };
}
