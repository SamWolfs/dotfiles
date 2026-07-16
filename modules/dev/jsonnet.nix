{ config, lib, options, pkgs, ... }:

with lib;
let cfg = config.modules.dev.jsonnet;
in {
  options.modules.dev.jsonnet = {
    enable = mkEnableOption "Jsonnet";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      home.packages = with pkgs; [
        go-jsonnet
        jsonnet-language-server
      ];

      home.sessionVariables = {};
    })
  ];
}
