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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    pkgs.virt-manager
    pkgs.virt-viewer
  ];

  # To enable UEFI firmware support in Virt-Manager, Libvirt, Gnome-Boxes, etc.
  systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];
}
