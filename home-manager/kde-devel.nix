{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    # pkgs.kdePackages.kdevelop
    pkgs.kdePackages.kontrast
    pkgs.okteta
    pkgs.kdePackages.umbrello
  ];
}
