{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/environment.d/15-libva-intel.conf".text = ''
      LIBVA_DRIVER_NAME=i965
    '';
  };
}
