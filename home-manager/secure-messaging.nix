{
  config,
  pkgs,
  ...
}:
{
  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  home.packages = [
    pkgs.signal-desktop
  ];
  home.file = {
    ".config/environment.d/70-signal.conf".text = ''
      SIGNAL_PASSWORD_STORE=gnome-libsecret
    '';
  };
}
