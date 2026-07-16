{
  config,
  extendedLib,
  options,
  pkgs,
  ...
}:

with extendedLib;
let
  cfg = config.modules.shell.tmux;
in
{
  options.modules.shell.tmux = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      tmux
    ];

    home.configFile = {
      "tmux/tmux.conf" = {
        source = ../../config/tmux/tmux.conf;
      };
    };
  };
}
