{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".tidyrc".text = ''
      quiet:  yes
      bare:  no
      output-xhtml:  yes
      indent:  auto
      indent-spaces:  4
      tab-size:  4
      wrap:  80
      char-encoding:  ascii
      // char-encoding:  utf8
      gnu-emacs:  yes
      numeric-entities:  yes
    '';
  };
}
