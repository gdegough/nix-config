{
  inputs
  , config
  , lib
  , pkgs
  , modulesPath
  , ...
}: 
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-powerlevel10k
  ];
  programs.zsh.enable = true; # the zsh shell
  environment.pathsToLink = [ "/share/zsh" ];
}
