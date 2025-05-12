{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.starship
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.droid-sans-mono
  ];
  programs.starship = {
    enable = true;
  };
}
