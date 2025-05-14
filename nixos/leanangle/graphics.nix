{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: 
{
  #nixpkgs.config.packageOverrides = pkgs: {
  #  vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  #};
  hardware.graphics = {
    enable = true;
    extraPackages = [
      pkgs.vpl-gpu-rt         # for newer GPUs on NixOS >24.05
      pkgs.intel-media-driver # LIBVA_DRIVER_NAME=iHD
      pkgs.intel-compute-runtime
      pkgs.libvdpau-va-gl
    ];
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    NIXOS_OZONE_WL = "1";
  };
}
