{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: 
{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;
      ovmf.packages = [ 
        pkgs.OVMFFull.fd 
      ];
    };
  };

  # enable USB redirection
  virtualisation.spiceUSBRedirection.enable = true;
  services.spice-vdagentd.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    pkgs.virt-manager
    pkgs.virt-viewer
  ];
}
