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
    pkgs.krita
    pkgs.kdePackages.k3b
    pkgs.kdePackages.minuet
  ];
}
