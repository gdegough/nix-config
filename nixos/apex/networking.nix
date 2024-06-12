{ 
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  # Network setup
  networking = {
    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    useDHCP = false;
    networkmanager.enable = false;
    hostName = "apex";
    domain = "natcky.rr.com";
    nameservers = [ "1.0.0.1" "1.1.1.1" ];
    extraHosts = ''
      10.4.0.2  leanangle.natcky.rr.com leanangle
      10.4.0.3  lemurpro.natcky.rr.com lemurpro
      10.4.0.4  xps13.natcky.rr.com xps13
    '';
  };
  systemd.network = {
    enable = true;
    networks."10-enp86s0" = {
      matchConfig.Name = "enp86s0";
      networkConfig.DHCP = "yes";
      dhcpV4config.RouteMetric = 100;
    };
    networks."20-wlo1" = {
      matchConfig.Name = "wlo1";
      networkConfig.DHCP = "yes";
      dhcpV4config.RouteMetric = 200;
    };
  };

  # use systemd-resolved for DNS lookup
  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [ "1.0.0.1" "1.1.1.1" ];
    dnsovertls = "true";
  };

  # mDNS
  services.avahi.enable = true;
  # services.avahi.nssmdns = true;
  services.avahi.nssmdns4 = true; 

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    iw
  ];
}
