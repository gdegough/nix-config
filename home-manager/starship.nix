{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.starship
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    pkgs.fira-code
    pkgs.droid-sans-mono
  ];
  programs.starship = {
    enable = true;
  };
}
