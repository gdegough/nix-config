{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    makemkv
  ];
  home.sessionVariables = {
      #
      # next two (2) lines to use makemkv libraries for aac and bluray
      #
      LIBAACS_PATH = "libmmbd";
      LIBBDPLUS_PATH = "libmmbd";
  };
  home.file = {
    ".config/environment.d/60-makemkv.conf".text = ''
      LIBAACS_PATH=libmmbd
      LIBBDPLUS_PATH=libmmbd
    '';
  };
}
