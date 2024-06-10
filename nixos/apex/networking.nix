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
    interfaces.enp86s0.useDHCP = true;
    interfaces.wlo1.useDHCP = true;
    hostName = "apex";
    domain = "natcky.rr.com";
    nameservers = [ "1.0.0.1" "1.1.1.1" ];
    extraHosts = ''
      10.4.0.2  leanangle.natcky.rr.com leanangle
      10.4.0.3  lemurpro.natcky.rr.com lemurpro
      10.4.0.4  xps13.natcky.rr.com xps13
    '';
    wireless = {
      enable = true;
      networks."GregsWLAN".psk = "ac4942274cae3be82fa8a05e54fa3a710b85204671631d85304051a8ce99ff00";
      extraConfig = "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=wheel";
    };
    networkmanager.enable = false;
  };
  systemd.network = {
    enable = true;
    networks."10-enp86s0" = {
      matchConfig.Name = "enp86s0";
      networkConfig.DHCP = "yes";
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
