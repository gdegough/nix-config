{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.starship
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];
  programs.starship = {
    enable = true;
  };
}
