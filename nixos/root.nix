{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: 
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.mutableUsers = false;
  users.users.root = {
    shell = pkgs.zsh;
    hashedPasswordFile = "/persist/passwords/root";
  };
}
