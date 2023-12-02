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
  # gmdegoug
#  sops.secrets.gmdegoug-password = {
#    sopsFile = ./secrets.yaml;
#    neededForUsers = true;
#  };
  users.users.gmdegoug = {
    isNormalUser = true;
    uid = 1000;
    description = "Gregory M. DeGough";
    extraGroups = [ 
      "audio"
      "networkmanager" 
      "systemd-journal" 
      "video" 
      "wheel" 
    ] ++ ifTheyExist [
      "media" 
      "pipewire" 
      "shared-files" 
    ];
    shell = pkgs.zsh;
    hashedPasswordFile = "/persist/passwords/gmdegoug";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCep44EPJn1kgwz3ldF3UYgSVfTXxDl//XYiQVV2ZCQfmlNY2QKST15GhogZ8woVzd5Mzg9WhnoMCqmXQbUkGY6JvYuH6qBpVBEg8G7GrD2IyoABjCz7nw4HNQ1kL4o7K8Vf8nUkZQK2Yj+3lD9eq/f49SqSKwzs2iTqSARXlmlRAkXZUUEnjCf9/xxUodODX5xEKAh2M8QU7LsV6MlY1KOX7xMg74ravFqsTLSZLZBcYWwtE3flEU4v2qhz24SlaN+7XZDE4SH98w1pA50vw36ExeoNb4WirFjixXWDY/pjneyNMt5ASBkV6/CnVYEaL93/4Zu9CFPfY3g0IduSeh7 gmdegoug"
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
