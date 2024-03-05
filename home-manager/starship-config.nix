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
      format = "[┌](green)($os)($username)[@](bold yellow)($hostname)($directory)$line_break[└─](green)$character";
      character = { 
        success_symbol = "[>](bold green)";
        error_symbol = "[>](bold red)";
      };
      username = {
        format = "[─\\(](green)[$user]($style)";
        show_always = true;
      };
      hostname = {
        format = "[$ssh_symbol$hostname]($style)[\\)─](green)";
        style = "bold yellow";
        trim_at = "";
        ssh_only = false;
      };
      os = {
        format = "[─\\(](green)[$symbol]($style)[\\)─](green)";
        style = "bold cyan";
        disabled = false;
      };
      directory = {
        format = "[─\\(](green)[$path]($style)[$read_only]($read_only_style)[\\)](green)";
        style = "white";
        truncation_symbol = "…/";
      };
    };
  };
}
