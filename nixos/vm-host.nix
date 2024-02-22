{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: 
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    pkgs.swtpm
    pkgs.virt-manager
    pkgs.virt-viewer
  ];
}
