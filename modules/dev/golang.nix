{ config, lib, options, pkgs, ... }:

with lib;
let cfg = config.modules.dev.golang;
in {
  options.modules.dev.golang = {
    enable = mkEnableOption "Golang";
    hugo.enable = mkEnableOption "Hugo";
    tooling.enable = mkEnableOption "Golang Tooling";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      home.packages = with pkgs; [
        go_1_24
        (mkIf cfg.hugo.enable hugo)
        (mkIf cfg.tooling.enable revive)
      ];

      home.sessionVariables = {
        GOPATH = "$HOME/go";
      };

      home.sessionPath = [
        "$GOPATH/bin"
      ];
    })
  ];
}
