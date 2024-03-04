{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.starship
  ];
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$line_break[($username@$hostname)](yellow bold)[\$ ]$character";
      character = { 
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
    };
  };
}
