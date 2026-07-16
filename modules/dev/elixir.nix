{ config, lib, options, pkgs, ... }:

with lib;
let cfg = config.modules.dev.elixir;
in {
  options.modules.dev.elixir = {
    enable = mkEnableOption "Elixir";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      home.packages = with pkgs; [
        beam.packages.erlang_28.elixir_1_18
        rebar3
      ];

      home.sessionVariables = {
        ERL_AFLAGS = "-kernel shell-history enabled";
      };
    })
  ];
}
