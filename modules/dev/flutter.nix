{ config, lib, options, pkgs, ... }:

with lib;
let cfg = config.modules.dev.flutter;
in {
  options.modules.dev.flutter = {
    enable = mkEnableOption "Flutter";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      home.packages = with pkgs; [
        android-studio
        flutter
      ];
    })
  ];
}
