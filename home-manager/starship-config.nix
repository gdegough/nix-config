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
      format = "┌(─\\($os\\))(─\\($username)->($hostname\\))(─\\($directory\\))$line_break└─$character";
      character = { 
        success_symbol = "[>](bold green)";
        error_symbol = "[>](bold red)";
      };
      username = {
        format = "[$user]($style)";
        show_always = true;
      };
      hostname = {
        format = "[$ssh_symbol$hostname]($style)";
        trim_at = "";
        ssh_only = false;
      };
      os = {
        format = "[$symbol]($style)";
        disabled = false;
      };
      directory = {
        format = "[$path]($style)[$read_only]($read_only_style)";
        style = "white";
        truncation_symbol = "…/";
      };
    };
  };
}
