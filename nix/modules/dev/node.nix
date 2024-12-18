{ config, lib, options, pkgs, ... }:

with lib;
let cfg = config.modules.dev.node;
in {
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
  ];
}
