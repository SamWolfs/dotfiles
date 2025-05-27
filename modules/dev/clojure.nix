{ config, lib, options, pkgs, ... }:

with lib;
let cfg = config.modules.dev.clojure;
in {
  options.modules.dev.clojure = {
    enable = mkEnableOption "Clojure";
    scripting.enable = mkEnableOption "Babashka";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      home.packages = with pkgs; [
        clojure
        joker
        leiningen
        (mkIf cfg.scripting.enable babashka)
      ];
    })
  ];
}
