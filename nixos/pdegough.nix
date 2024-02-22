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
  users.users.pdegough = {
    isNormalUser = true;
    uid = 1003;
    description = "Peggy DeGough";
    extraGroups = [ 
    ] ++ ifTheyExist [
      "audio"
      "pipewire" 
      "shared-files" 
      "video" 
    ];
    shell = pkgs.bash;
    hashedPasswordFile = "/persist/passwords/pdegough";
  };
}
