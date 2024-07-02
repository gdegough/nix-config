{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.digikam
    pkgs.kdePackages.dragon
    pkgs.kdePackages.kcolorchooser
    pkgs.kdePackages.kdenlive
    pkgs.krita
    pkgs.kdePackages.k3b
  ];
}
