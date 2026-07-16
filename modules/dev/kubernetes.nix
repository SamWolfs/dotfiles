{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    argocd
    ctlptl
    docker-compose
    k9s
    kind
    kubectl
    (kubelogin.overrideAttrs (oldAttrs: rec {
      version = "0.1.9";
      src = pkgs.fetchFromGitHub {
        owner = "Azure";
        repo = "kubelogin";
        rev = "v${version}";
        sha256 = "sha256-u9Fj2YkHVbFHpxrrxdYrRBvbGsLvxQQlsPHf4++L0g0=";
      };
      patches = [];
      vendorHash = "sha256-HYUI0x4fCA8nhIHPguGCJ+F36fxb7m97bgyigwiXWd8=";
      doCheck = false;
    }))
    kubernetes-helm
    talosctl
    tilt
  ];
}
