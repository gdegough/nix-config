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
    shell = pkgs.bash;
    hashedPasswordFile = "/persist/passwords/gmdegoug";
    extraGroups = [ 
      "systemd-journal" 
      "wheel" 
    ] ++ ifTheyExist [
      "audio"
      "libvirtd"
      "media" 
      "networkmanager" 
      "pipewire" 
      "shared-files" 
      "video" 
    ];
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
