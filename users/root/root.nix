{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: 
{
  # root
#  sops.secrets.root-password = {
#    sopsFile = ./secrets.yaml;
#    neededForUsers = true;
#  };
  users.users.root = {
    shell = pkgs.zsh;
    hashedPasswordFile = "/persist/passwords/root";
  };
}
