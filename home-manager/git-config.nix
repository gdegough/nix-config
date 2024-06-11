{
  config,
  pkgs,
  ...
}:
{
  programs.git = {
    enable = true;
    userName = "gdegough";
    userEmail = "gdegough@gmail.com";
    extraConfig = {
      core = { editor = "vim"; };
    };
  };
}
