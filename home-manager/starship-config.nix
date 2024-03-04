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
      format = "$all";
      character = { 
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
    };
  };
}
