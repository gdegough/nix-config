{
  inputs,
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: 
let 
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  # Mutation of users outside of the config?
  users.mutableUsers = false;

  # root
#  sops.secrets.root-password = {
#    sopsFile = ./secrets.yaml;
#    neededForUsers = true;
#  };
  users.users.root = {
    shell = pkgs.zsh;
    hashedPasswordFile = "/persist/passwords/root";
#    hashedPasswordFile = config.sops.secrets.root-password.path;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCmhJIl7WJNvnigGjC6rSXxeaTQxy7OSRzSKbaWIUpEYgZE5BJ+vlVOgp8ZxP4D9ruZp2RSmbKJs6Ih68GaQiccof42VVYM2QF4MtieXISjn2+dvvwLcRerkXmN4tA/8JMHX56lMVwF2NvaTs41NZSeWcnlhuQ8iRQJiHCuj18ikiG2ob1Qo1iHu6pSI2twQlONmgbOB5ZmHONq1mCBWPvNUdo50oRdcx0h3EjiKXJyTgDfR5bhidfzVr/5e9fLCiHg+wIQuzJlRRbge9ywpyZhv1szUz1TlSjd4QMUj4MGCu2R1GCspYdfY56PMoQatQRdOVOxiV2fXOd4I7U8pB0rUdd4n3Z20hmmOYCirfFn3ZZwMjWF6gDHg50KuGuwUycIcpFCC6y2Vr24MzRlbtsqzzyaQA2czhtZzQMN68nPUmGNB1WYvHmt/k5R2rMvdRf0TOg8TciSkWCt/bFixOpVB5pxoKgHgqDHi/eMsksbsYEkAyStARVX5No0y3kjrqBurV7BM3BnhyfefofpHSIVFwIFlZD/LTJ1eQKNyIVDFDH/2DkuMrS4fEbFXuQ4T+mLzD1KLLU8Xg/whonKAJ7O6UliMHLBp+vqfm1hT24z4LPgy9b5oyFeSofMYDZfHn5DF9nCgX/QttyYQ281Xm0vF/dX6umcHKA7HkoFCzeFIQ== root"
    ];
  };

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
#    hashedPasswordFile = config.sops.secrets.gmdegoug-password.path;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCmhJIl7WJNvnigGjC6rSXxeaTQxy7OSRzSKbaWIUpEYgZE5BJ+vlVOgp8ZxP4D9ruZp2RSmbKJs6Ih68GaQiccof42VVYM2QF4MtieXISjn2+dvvwLcRerkXmN4tA/8JMHX56lMVwF2NvaTs41NZSeWcnlhuQ8iRQJiHCuj18ikiG2ob1Qo1iHu6pSI2twQlONmgbOB5ZmHONq1mCBWPvNUdo50oRdcx0h3EjiKXJyTgDfR5bhidfzVr/5e9fLCiHg+wIQuzJlRRbge9ywpyZhv1szUz1TlSjd4QMUj4MGCu2R1GCspYdfY56PMoQatQRdOVOxiV2fXOd4I7U8pB0rUdd4n3Z20hmmOYCirfFn3ZZwMjWF6gDHg50KuGuwUycIcpFCC6y2Vr24MzRlbtsqzzyaQA2czhtZzQMN68nPUmGNB1WYvHmt/k5R2rMvdRf0TOg8TciSkWCt/bFixOpVB5pxoKgHgqDHi/eMsksbsYEkAyStARVX5No0y3kjrqBurV7BM3BnhyfefofpHSIVFwIFlZD/LTJ1eQKNyIVDFDH/2DkuMrS4fEbFXuQ4T+mLzD1KLLU8Xg/whonKAJ7O6UliMHLBp+vqfm1hT24z4LPgy9b5oyFeSofMYDZfHn5DF9nCgX/QttyYQ281Xm0vF/dX6umcHKA7HkoFCzeFIQ== gmdegoug"
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

  # pdegough
#  sops.secrets.pdegough-password = {
#    sopsFile = ./secrets.yaml;
#    neededForUsers = true;
#  };
  users.users.pdegough = {
    isNormalUser = true;
    uid = 1003;
    description = "Peggy DeGough";
    extraGroups = [ 
      "audio"
      "video" 
    ] ++ ifTheyExist [
      "pipewire" 
      "shared-files" 
    ];
    shell = pkgs.bash;
    hashedPasswordFile = "/persist/passwords/pdegough";
#    hashedPasswordFile = config.sops.secrets.pdegough-password.path;
  };
}
