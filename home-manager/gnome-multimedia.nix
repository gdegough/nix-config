{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.celluloid
    pkgs.rhythmbox
  ];
}
