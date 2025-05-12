{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.starship
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    pkgs.fira-code
    pkgs.droid-sans-mono
  ];
  programs.starship = {
    enable = true;
  };
}
