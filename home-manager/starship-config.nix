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
      format = "$directory$line_break\(($os)\)$username@$hostname$character ";
      character = { 
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      username = {
        show_always = true;
      };
      hostname = {
        format = "[$ssh_symbol$hostname]($style)";
        style = "bold yellow";
        trim_at = "";
        ssh_only = false;
      };
      os = {
        style = "cyan";
        disabled = false;
      };
    };
  };
}
