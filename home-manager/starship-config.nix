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
      format = "[┌](bold green)([─\\(](bold green)$os[\\)](bold green))" +
        "([─\\(](bold green)$username)[@](bold yellow)($hostname[\\)](bold green))" +
        "([─\\(](bold green)$directory[\\)](bold green))$line_break[└─](bold green)$character";
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
        style = "bold yellow";
        trim_at = "";
        ssh_only = false;
      };
      os = {
        format = "[$symbol]($style)";
        style = "bold cyan";
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
