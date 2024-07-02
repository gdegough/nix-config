{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    # pkgs.kdePackages.kdevelop # currently broken
    pkgs.kdePackages.kontrast
    pkgs.kdePackages.okteta
    pkgs.kdePackages.umbrello
  ];
}
