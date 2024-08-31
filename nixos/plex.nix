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
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    pkgs.plex
  ];
  users.users.plex = {
    extraGroups = [] ++ ifTheyExist [ 
      "media" 
    ];
  };
  # Enable plexmediaserver
  services.plex = {
    enable = true;
    openFirewall = true;
  };
}
