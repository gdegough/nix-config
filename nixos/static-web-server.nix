{ 
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  # List packages installed in system profile:
  environment.systemPackages = [
    pkgs.static-web-server
  ];
  services.static-web-server = {
    enable = true;
    listen = "[::]:80";
    root = "/srv/www/htdocs";
    configuration = {
      general = {
        directory-listing = true;
        compression = true;
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 80 ];
}
