{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/environment.d/00-bash.conf".text = ''
      PROMPT_DIRTRIM=3
    '';
    ".config/environment.d/02-xcursor.conf".text = ''
      XCURSOR_THEME="Adwaita"
    '';
    ".config/environment.d/05-country.conf".text = ''
      COUNTRY="US"
    '';
    ".config/environment.d/15-libva-intel.conf".text = ''
      LIBVA_DRIVER_NAME=iHD
    '';
    ".config/environment.d/20-mail.conf".text = ''
      MAIL="$HOME/.maildir"
      MAILPATH="$HOME/.maildir"
    '';
    ".config/environment.d/30-merge.conf".text = ''
      MERGE=vimdiff
    '';
    ".config/environment.d/40-pager.conf".text = ''
      PAGER=less
    '';
    ".config/environment.d/50-vim.conf".text = ''
      EDITOR=vim
      EXINIT="se sm smd scr=1 ai ruler redraw sw=4 filec=\t"
      SYSTEMD_EDITOR=vim
    '';
    ".config/environment.d/60-makemkv.conf".text = ''
      LIBAACS_PATH=libmmbd
      LIBBDPLUS_PATH=libmmbd
    '';
    ".config/environment.d/70-qt.conf".text = ''
      QT_QPA_PLATFORMTHEME=gnome
    '';
    ".config/environment.d/99-xdg.conf".text = ''
      XDG_CONFIG_HOME="$HOME/.config"
    '';
  };
}
