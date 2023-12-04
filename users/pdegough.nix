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
in
{
#  home-manager.users.${userName} = import ../hosts/${config.networking.hostName}/hm/${userName}-home.nix;

  users.mutableUsers = false;
  # sops.secrets."${userName}"-password = {
  #   sopsFile = ./secrets.yaml;
  #   neededForUsers = true;
  # };
  users.users."${userName}" = {
    isNormalUser = true;
    uid = 1003;
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
