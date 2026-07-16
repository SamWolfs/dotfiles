{
  extendedLib,
  options,
  config,
  pkgs,
  ...
}:

with extendedLib;
let
  cfg = config.modules.host;
in
{
  options.modules.host = with types; {
    name = mkOption {
      type = nullOr str;
      default = null;
      description = "Name of the host. Used to load host-specific config overlays.";
    };
  };

  config = mkIf (cfg.name != null) {
    home.configFile =
      with config.modules;
      mkMerge [
        (mkIf (desktop.i3.enable && builtins.pathExists ./${cfg.name}/config/i3/host.conf) {
          "i3/host.conf".source = ./${cfg.name}/config/i3/host.conf;
        })

        (mkIf (desktop.terminal.kitty.enable && builtins.pathExists ./${cfg.name}/config/kitty/host.conf) {
          "kitty/host.conf".source = ./${cfg.name}/config/kitty/host.conf;
        })

        (mkIf (editors.emacs.enable && builtins.pathExists ./${cfg.name}/config/doom/host.el) {
          "doom/host.el".source = ./${cfg.name}/config/doom/host.el;
        })

        (mkIf (shell.zsh.enable && builtins.pathExists ./${cfg.name}/config/zsh/host.zsh) {
          "zsh/host.zsh".source = ./${cfg.name}/config/zsh/host.zsh;
        })

        (mkIf (desktop.apps.rofi.enable && builtins.pathExists ./${cfg.name}/config/rofi/host.rasi) {
          "rofi/host.rasi".source = ./${cfg.name}/config/rofi/host.rasi;
        })

        (mkIf (services.dunst.enable && builtins.pathExists ./${cfg.name}/config/dunst/host.conf) {
          "dunst/host.conf".source = ./${cfg.name}/config/dunst/host.conf;
        })

        (mkIf (desktop.apps.rofi.enable && builtins.pathExists ./${cfg.name}/config/lofi-rofi/metadata) {
          "lofi-rofi/metadata".source = mkForce ./${cfg.name}/config/lofi-rofi/metadata;
        })

        (mkIf (desktop.apps.rofi.enable && builtins.pathExists ./${cfg.name}/config/lofi-rofi/config) {
          "lofi-rofi/config".source = mkForce ./${cfg.name}/config/lofi-rofi/config;
        })
      ];
  };
}
