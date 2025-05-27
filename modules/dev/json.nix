{ config, lib, options, pkgs, ... }:

with lib;
let cfg = config.modules.dev.json;
in {
  options.modules.dev.json = {
    enable = mkEnableOption "Json";
    yaml.enable = mkEnableOption "Yaml";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      home.packages = with pkgs; [
        jq
        (mkIf cfg.yaml.enable yq-go)
      ];
    })
  ];
}
