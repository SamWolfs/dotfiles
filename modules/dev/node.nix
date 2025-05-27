{
  config,
  lib,
  options,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.dev.node;
in
{
  options.modules.dev.node = {
    enable = mkEnableOption "Node";
    yarn.enable = mkEnableOption "Yarn";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      home.packages = with pkgs; [
        nodejs
        (mkIf cfg.yarn.enable yarn)
      ];
    })

    {
      home.sessionVariables = {
        NPM_CONFIG_USERCONFIG = "$XDG_CONFIG_HOME/npm/config";
        NPM_CONFIG_CACHE = "$XDG_CACHE_HOME/npm";
        NPM_CONFIG_PREFIX = "$XDG_CACHE_HOME/npm";
        NPM_CONFIG_TMP = "$XDG_RUNTIME_DIR/npm";
        NODE_REPL_HISTORY = "$XDG_CACHE_HOME/node/repl_history";
      };

      home.configFile."npm/config".text = ''
        cache=''${XDG_CACHE_HOME}/npm
        prefix=''${XDG_DATA_HOME}/npm
        tmp=''${XDG_RUNTIME_DIR}/npm
      '';
    }
  ];
}
