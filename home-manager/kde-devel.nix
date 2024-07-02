{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    # pkgs.kdePackages.kdevelop # currently broken
    pkgs.kdePackages.kontrast
    pkgs.okteta
    # pkgs.kdePackages.umbrello # currently broken
  ];
}
