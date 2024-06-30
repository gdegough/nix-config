{
  config,
  pkgs,
  ...
}:
{
  programs.zsh = {
    shellAliases = {
      power-balanced = "sudo system76-power charge-thresholds --profile balanced && sudo system76-power profile balanced && brightnessctl set 50%";
      power-battery = "sudo system76-power charge-thresholds --profile balanced && sudo system76-power profile battery && brightnessctl set 50%";
    };
  };
}
