# NOTE: Not in use due to themes/default.nix taking care of the files
# {
#   extendedLib,
#   config,
#   ...
# }:

# with extendedLib;
# let
#   cfg = config.modules.theme;
# in
# mkIf (cfg.active == "catppuccin") {
#   home.configFile =
#     with config.modules;
#     mkMerge [
#       (mkIf desktop.i3.enable {
#         "i3/theme.conf".source = ./config/i3/theme.conf;
#       })

#       (mkIf desktop.terminal.kitty.enable {
#         "kitty/theme.conf".source = ./config/kitty/theme.conf;
#       })

#       (mkIf editors.emacs.enable {
#         "doom/theme.el".source = ./config/doom/theme.el;
#       })
#     ];
# }
