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
  ## 24.11 
  #hardware.pulseaudio.enable = false;
  ## 25.05
  services.pulseaudio.enable = false;
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
