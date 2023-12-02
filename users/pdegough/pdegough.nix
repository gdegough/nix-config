{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: 
let 
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  # pdegough
  # sops.secrets.pdegough-password = {
  #   sopsFile = ./secrets.yaml;
  #   neededForUsers = true;
  # };
  users.users.pdegough = {
    isNormalUser = true;
    uid = 1003;
    description = "Peggy DeGough";
    extraGroups = [ 
      "audio"
      "video" 
    ] ++ ifTheyExist [
      "pipewire" 
      "shared-files" 
    ];
    shell = pkgs.zsh;
    hashedPasswordFile = "/persist/passwords/pdegough";
  };
}
