{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/environment.d/02-xcursor.conf".text = ''
      XCURSOR_THEME="Adwaita"
    '';
#    ".config/environment.d/70-qt.conf".text = ''
#      QT_QPA_PLATFORMTHEME=gnome
#    '';
  };
}
