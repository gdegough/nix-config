{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.kdePackages.dragon
    pkgs.kdePackages.kcolorchooser
    pkgs.kdePackages.kdenlive
    pkgs.kdePackages.krita
    pkgs.kdePackages.k3b
    pkgs.kdePackages.minuet
  ];
}
