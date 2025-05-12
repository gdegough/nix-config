{ 
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  # Enable sound with pipewire.
  # hardware.pulseaudio.enable = false; # stable 24.11
  services.pulseaudio.enable = false; # 25.05
  security.rtkit.enable = true;
  # sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true; # for JACK applications
  };
}
