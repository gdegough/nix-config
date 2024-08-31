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
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];

  nixpkgs.overlays = with pkgs; [
    (
      final: prev:
        {
          jellyfin-web = prev.jellyfin-web.overrideAttrs (finalAttrs: previousAttrs: {
            installPhase = ''
              runHook preInstall

              # this is the important line
              sed -i "s#</head>#<script src=\"configurationpage?name=skip-intro-button.js\"></script></head>#" dist/index.html

              mkdir -p $out/share
              cp -a dist $out/share/jellyfin-web

              runHook postInstall
            '';
          });
        }
    )
  ];

  users.users.jellyfin = {
    extraGroups = [] ++ ifTheyExist [ 
      "media" 
    ];
  };
  # Enable jellyfin
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
}
