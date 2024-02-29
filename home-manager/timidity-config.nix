{
  config,
  pkgs,
  ...
}:
{
  programs.timidity = {
    enable = true;
    extraConfig = ''
      soundfont $HOME/.nix-profile/share/soundfonts/FluidR3_GM2-2.sf2
    '';
  };
}
