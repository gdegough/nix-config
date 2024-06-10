{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.starship
    pkgs.nerdfonts
  ];
  programs.starship = {
    enable = true;
  };
}
