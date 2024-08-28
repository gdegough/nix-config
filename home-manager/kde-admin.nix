{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/autostart/org.kde.kgpg.desktop".text = ''
      # KDE Config File
      [Desktop Entry]
      Type=Application
      Exec=kgpg %U
      Icon=kgpg
      X-DocPath=kgpg/index.html
      MimeType=application/pgp-encrypted;application/pgp-signature;application/pgp-keys;
      GenericName=Encryption Tool
      GenericName[en_GB]=Encryption Tool
      Comment=A GnuPG frontend
      Comment[en_GB]=A GnuPG frontend
      Name=KGpg
      Name[en_GB]=KGpg
      X-KDE-autostart-condition=kgpgrc:User Interface:AutoStart:false
      Categories=Qt;KDE;Utility;X-KDE-Utilities-PIM;
      NotShowIn=sway;hyprland;GNOME;cosmic;
    '';
    ".config/autostart/org.kde.kclockd-autostart.desktop".text = ''
      [Desktop Entry]
      DBusActivatable=true
      Exec=kclockd
      Name=org.kde.kclockd-autostart
      Type=Application
      X-Flatpak=org.kde.kclockd-autostart
      NotShowIn=sway;hyprland;GNOME;cosmic;
    '';
  };
  home.packages = [
    pkgs.kdePackages.isoimagewriter
    pkgs.kdePackages.kclock
    pkgs.kdePackages.kget
    pkgs.kdePackages.kgpg
    pkgs.kdePackages.kleopatra
    # pkgs.kdePackages.kompare # currently broken
    pkgs.kdePackages.ktimer
    pkgs.kdePackages.ktorrent
    pkgs.kdePackages.partitionmanager
  ];
}
