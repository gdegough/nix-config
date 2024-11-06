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
  hardware.opengl = { # stable 24.05
  # hardware.graphics = { # hardware.opengl in 24.05
    enable = true;
    extraPackages = [
      pkgs.intel-media-driver # LIBVA_DRIVER_NAME=iHD
      pkgs.vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      pkgs.intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
      pkgs.vaapiVdpau
      pkgs.libvdpau-va-gl
      pkgs.vpl-gpu-rt # QSV on 11th gen or newer
      pkgs.intel-media-sdk # QSV up to 11th gen
    ];
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}
