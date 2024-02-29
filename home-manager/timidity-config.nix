{
  config,
  pkgs,
  ...
}:
{
  programs.timidity = {
    enable = true;
    extraConfig = ''
      soundfont ${pkgs.soundfont-fluid}/share/soundfonts/FluidR3_GM2-2.sf2
    '';
  };
}
