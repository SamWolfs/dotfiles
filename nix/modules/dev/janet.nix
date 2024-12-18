{ config, lib, pkgs, ... }:

# TODO: move mkWrapper to its own file, stole this from hlissner: https://github.com/hlissner/dotfiles/blob/1e2ca74b02d2d92005352bf328acc86abb10efbd/lib/pkgs.nix#L17
let
  mkWrapper = package: postBuild:
    let name = package;
        paths = [ package ];
    in pkgs.symlinkJoin  {
      inherit paths postBuild;
      name = "${name}-wrapped";
      buildInputs = [ pkgs.makeWrapper ];
    };
  janet = pkgs.janet;
  jpm = mkWrapper pkgs.jpm ''
    wrapProgram $out/bin/jpm --add-flags '--tree="$JANET_TREE" --binpath="$XDG_BIN_HOME" --headerpath=${janet}/include --libpath=${janet}/lib --ldflags=-L${pkgs.glibc}/lib '
  '';
in {
  home.packages = [
    janet
    jpm
  ];
}
