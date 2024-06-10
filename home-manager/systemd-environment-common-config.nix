{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/environment.d/00-bash.conf".text = ''
      PROMPT_DIRTRIM=3
    '';
    ".config/environment.d/05-country.conf".text = ''
      COUNTRY="US"
    '';
    ".config/environment.d/20-mail.conf".text = ''
      MAIL="$HOME/.maildir"
      MAILPATH="$HOME/.maildir"
    '';
    ".config/environment.d/40-pager.conf".text = ''
      PAGER=less
    '';
    ".config/environment.d/99-xdg.conf".text = ''
      XDG_CONFIG_HOME="$HOME/.config"
    '';
  };
}
