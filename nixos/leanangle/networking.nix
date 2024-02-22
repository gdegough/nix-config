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
    useDHCP = true;
    # interfaces.enp5s0.useDHCP = true;
    # interfaces.wlo1.useDHCP = true;
    hostName = "leanangle";
    domain = "natcky.rr.com";
    networkmanager.enable = true;
    nameservers = [ "1.0.0.1" "1.1.1.1" ];
    extraHosts = ''
      10.4.0.3	lemurpro.natcky.rr.com lemurpro
      10.4.0.4	xps13.natcky.rr.com xps13
    '';
  };

  # use systemd-resolved for DNS lookup
  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [ "1.0.0.1" "1.1.1.1" ];
    extraConfig = ''
      DNSOverTLS=yes
    '';
  };

  # for l2tp VPN
  systemd = {
    tmpfiles.rules = [
      ''L /etc/ipsec.secrets - - - - /etc/ipsec.d/ipsec.nm-l2tp.secrets''
    ];
  };

  # mDNS
  services.avahi.enable = true;
#  services.avahi.nssmdns4 = true;
  services.avahi.nssmdns = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    iw
    networkmanager-l2tp
    networkmanagerapplet
  ];
}
