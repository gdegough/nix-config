{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.starship
    ## 24.11
    #(pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; }) 
    ## 25.05
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.droid-sans-mono
];
  programs.starship = {
    enable = true;
  };
}
