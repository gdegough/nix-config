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
    pkgs.unstable.plex
  ];
  # local groups I use for plex server
  users.groups.media.gid = 901;
  users.groups.shared-files.gid = 902;

  # Enable plexmediaserver
  users.users.plex.extraGroups = [ "media" ];
  services.plex = {
    enable = true;
    openFirewall = true;
  };
}
