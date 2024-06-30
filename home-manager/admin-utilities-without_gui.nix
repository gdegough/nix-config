{
  config,
  pkgs,
  ...
}: {
  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  home.packages = [
    pkgs.htop
    pkgs.hwinfo
    pkgs.iftop
    pkgs.iotop
    pkgs.lnav
    pkgs.nmap
    pkgs.nmon
    pkgs.pciutils
    pkgs.traceroute
  ];
}
