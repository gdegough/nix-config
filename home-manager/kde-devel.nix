{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.kdePackages.kdevelop
    pkgs.kdePackages.kontrast
    pkgs.kdePackages.okteta
    pkgs.kdePackages.umbrello
  ];
}
