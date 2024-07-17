{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: 
{
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    extraPackages = [
      pkgs.intel-media-driver # LIBVA_DRIVER_NAME=iHD
      pkgs.vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      pkgs.vaapiVdpau
      pkgs.libvdpau-va-gl
    ];
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}
