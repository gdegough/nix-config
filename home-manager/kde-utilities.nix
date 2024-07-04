{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.kdePackages.kweather
  ];
}
