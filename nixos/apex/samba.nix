{ 
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  myInterfaces = "lo wlo1 enp86s0";
  myNetworks = "10.4. 127.";
  User01 = "gmdegoug";
  User02 = "pdegough";
in
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    pkgs.samba
  ];

  services.samba-wsdd.enable = true; # make shares visible for windows 10 clients

  # For samba (Windows 10, etc.)
  networking.firewall.allowedTCPPorts = [
    5357 # wsdd
  ];
  networking.firewall.allowedUDPPorts = [
    3702 # wsdd
  ];
  networking.firewall.allowPing = true;

  services.samba = {
    enable = true;
    securityType = "user";
    openFirewall = true;
    extraConfig = ''
      workgroup = WORKGROUP
      interfaces = ${myInterfaces}
      bind interfaces only = yes
      hosts allow = ${myNetworks}
      guest account = nobody
      map to guest = bad user
    '';
    shares = {
      public = {
        comment = "Public Stuff";
        path = "/srv/public";
        public = "yes";
        "read only" = "yes";
        "write list" = "@users @media";
      };
      "${User01}-samba" = {
        path = "/srv/samba/${User01}";
        "valid users" = "${User01}";
        public = "no";
        writable = "yes";
        printable = "no";
        "create mask" = "0765";
      };
      "${User02}-samba" = {
        path = "/srv/samba/${User02}";
        "valid users" = "${User02}";
        public = "no";
        writable = "yes";
        printable = "no";
        "create mask" = "0765";
      };
    }; 
  };
}
