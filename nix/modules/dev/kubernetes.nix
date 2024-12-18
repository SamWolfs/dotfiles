{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    argocd
    ctlptl
    docker-compose
    k9s
    kind
    kubectl
    kubelogin
    kubernetes-helm
    talosctl
    tilt
  ];
}
