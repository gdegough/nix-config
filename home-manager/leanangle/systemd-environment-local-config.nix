{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/environment.d/15-libva-intel.conf".text = ''
      LIBVA_DRIVER_NAME=iHD
    '';
    ".config/environment.d/03-gtk.conf".text = ''
      GDK_DPI_SCALE=0.75
    '';
  };
}
