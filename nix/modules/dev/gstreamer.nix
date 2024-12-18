{ config, lib, options, pkgs, ... }:

with lib;
let cfg = config.modules.dev.gstreamer;
in {
  options.modules.dev.gstreamer = {
    enable = mkEnableOption "GStreamer";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      home.packages = with pkgs; [
        gst_all_1.gstreamer
        gst_all_1.gst-devtools
        gst_all_1.gst-plugins-bad
        gst_all_1.gst-plugins-base
        gst_all_1.gst-plugins-good
        gst_all_1.gst-plugins-rs
        libnice
      ];
    })
  ];
}
