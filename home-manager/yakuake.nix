{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.kdePackages.yakuake
  ];
}
