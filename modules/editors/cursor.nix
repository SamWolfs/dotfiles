{
  config,
  extendedLib,
  options,
  pkgs,
  ...
}:

with extendedLib;
let
  cfg = config.modules.editors.cursor;
in
{
  options.modules.editors.cursor = with types; {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ code-cursor ];
  };
}
