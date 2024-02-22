{ 
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    pkgs.plex
  ];
  # local groups I use for plex server
  users.groups.media.gid = 1004;
  users.groups.shared-files.gid = 1001;

  # Enable plexmediaserver
  users.users.plex.extraGroups = [ "media" ];
  services.plex = {
    enable = true;
    openFirewall = true;
  };
}
