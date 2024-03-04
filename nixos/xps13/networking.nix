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
    useDHCP = lib.mkForce true;
    # interfaces.wlp2s0.useDHCP = lib.mkDefault true;
    hostName = "xps13";
    domain = "natcky.rr.com";
    networkmanager.enable = true;
    nameservers = [ "1.0.0.1" "1.1.1.1" ];
    extraHosts = ''
      10.4.0.2	leanangle.natcky.rr.com leanangle
      10.4.0.3	lemurpro.natcky.rr.com lemurpro
    '';
  };

  # use systemd-resolved for DNS lookup
  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [ "1.0.0.1" "1.1.1.1" ];
    dnsovertls = "true";
  };

  # for l2tp VPN
  systemd = {
    tmpfiles.rules = [
      ''L /etc/ipsec.secrets - - - - /etc/ipsec.d/ipsec.nm-l2tp.secrets''
    ];
  };

  # mDNS
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  # services.avahi.nssmdns4 = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    iw
    networkmanager-l2tp
    networkmanagerapplet
  ];
}
