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
  users.users.gmdegoug = {
    isNormalUser = true;
    uid = 1000;
    description = "Gregory M. DeGough";
    extraGroups = [ 
      "systemd-journal" 
      "wheel" 
    ] ++ ifTheyExist [
      "audio"
      "media" 
      "networkmanager" 
      "pipewire" 
      "shared-files" 
      "video" 
    ];
    shell = pkgs.bash;
    hashedPasswordFile = "/persist/passwords/gmdegoug";
  };
  # Allow certain privileged users to use sudo without password
  security.sudo.extraRules = [
    { users = [ "gmdegoug" ];
      commands = [
        { command = "ALL" ;
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
