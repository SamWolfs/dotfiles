{
  extendedLib,
  options,
  config,
  pkgs,
  ...
}:

with extendedLib;
let
  cfg = config.modules.theme;
in
{
  # imports = mapModules' ./. import;

  options.modules.theme = with types; {
    active = mkOption {
      type = nullOr str;
      default = null;
      apply =
        v:
        let
          theme = builtins.getEnv "THEME";
        in
        if theme != "" then theme else v;
      description = ''
        Name of the theme to enable. Can be overridden by the THEME environment
        variable. Themes can also be hot-swapped with 'hey theme $THEME'.
      '';
    };
  };

  config = {
    home.configFile =
      with config.modules;
      mkMerge [
        (mkIf desktop.apps.rofi.enable {
          "rofi/config.theme.rasi".source = ./${cfg.active}/config/rofi/config.theme.rasi;
        })

        (mkIf desktop.i3.enable {
          "i3/theme.conf".source = ./${cfg.active}/config/i3/theme.conf;
        })

        (mkIf desktop.terminal.kitty.enable {
          "kitty/theme.conf".source = ./${cfg.active}/config/kitty/theme.conf;
        })

        (mkIf editors.emacs.enable {
          "doom/theme.el".source = ./${cfg.active}/config/doom/theme.el;
        })
      ];
  };
}
