{ config, lib, options, pkgs, ... }:

with lib;
let cfg = config.modules.dev.shell;
in {
  options.modules.dev.shell = {
    enable = mkEnableOption "Shell";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      home.packages = with pkgs; [
        shellcheck
        shfmt
      ];
    })
  ];
}
