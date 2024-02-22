{ 
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  myNetwork01 = "10.4.0.0/22";
  myNetwork02 = "127.0.0.0/8";
  myNetwork03 = "[::ffff:127.0.0.0]/104";
  myNetwork04 = "[::1]/128";
  systemOwner = "gmdegoug";
in
{
  environment.systemPackages = [
    pkgs.postfix
  ];
  # Enable postfix
  services.postfix = {
    enable = true;
    networks = [ "${myNetwork01}" "${myNetwork02}" "${myNetwork03}" "${myNetwork04}" ];
    hostname = "${config.networking.hostName}";
    domain = "${config.networking.domain}";
    destination = [ "localhost" "${config.networking.hostName}" "${config.networking.hostName}.${config.networking.domain}" ];
    rootAlias = "${systemOwner}";
    config = {
      home_mailbox = ".maildir/";
      inet_interfaces = "loopback-only";
      inet_protocols = "all";
    };
  };
}
