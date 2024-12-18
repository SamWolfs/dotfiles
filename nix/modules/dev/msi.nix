{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # trash
    ansible
  ];
}
