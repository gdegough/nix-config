{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: 
let 
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  userName = "pdegough";
  userDescription = "Peggy DeGough";
  userID = 1003;
in
{
  home-manager.users.${userName} = import ../hosts/${config.networking.hostName}/hm/${userName}-home.nix;

  users.mutableUsers = false;
  # sops.secrets.${userName}-password = {
  #   sopsFile = ./secrets.yaml;
  #   neededForUsers = true;
  # };
  users.users = {
    name = "${userName}";
    isNormalUser = true;
    uid = "${userID}";
    description = "${userDescription}";
    extraGroups = [ 
      "audio"
      "video" 
    ] ++ ifTheyExist [
      "pipewire" 
      "shared-files" 
    ];
    shell = pkgs.zsh;
    hashedPasswordFile = "/persist/passwords/${userName}";
  };
}
