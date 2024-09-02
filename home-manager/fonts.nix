{
  config,
  pkgs,
  ...
}:
{
  fonts.fontconfig.enable = true;
  imports = [
    ./extra-fonts.nix
  ];
  home.packages = [
    pkgs.corefonts
    pkgs.dejavu_fonts
    pkgs.fira
    pkgs.fira-code
    pkgs.fira-code-symbols
    pkgs.font-awesome
    pkgs.google-fonts
    pkgs.ibm-plex
    pkgs.intel-one-mono
    pkgs.liberation_ttf
    pkgs.noto-fonts
    # pkgs.textfonts
    pkgs.ttf_bitstream_vera
    # pkgs.typodermic-free-fonts
    pkgs.typodermic-public-domain
    pkgs.vistafonts
  ];
  home.file = {
    ".config/fontconfig/fonts.conf".text = ''
      <?xml version='1.0'?>
      <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
      <fontconfig>
          <alias>
              <family>icon</family>
              <prefer>
                  <family>Font Awesome 6 Free</family>
                  <family>Font Awesome 6 Brands</family>
              </prefer>
          </alias>
          <match target="font">
              <test compare="contains" name="family">
                  <string>Song</string>
              </test>
              <!-- check to see if the font is just regular -->
              <test compare="less_eq" name="weight">
                  <int>100</int>
              </test>
              <test compare="more_eq" target="pattern" name="weight">
                  <int>180</int>
              </test>
              <edit mode="assign" name="embolden">
                  <bool>true</bool>
              </edit>
          </match>
          <match target="font">
              <test compare="contains" name="family">
                  <string>Sun</string>
              </test>
              <!-- check to see if the font is just regular -->
              <test compare="less_eq" name="weight">
                  <int>100</int>
              </test>
              <test compare="more_eq" target="pattern" name="weight">
                  <int>180</int>
              </test>
              <edit mode="assign" name="embolden">
                  <bool>true</bool>
              </edit>
          </match>
          <match target="font">
              <test compare="contains" name="family">
                  <string>Kai</string>
              </test>
              <!-- check to see if the font is just regular -->
              <test compare="less_eq" name="weight">
                  <int>100</int>
              </test>
              <test compare="more_eq" target="pattern" name="weight">
                  <int>180</int>
              </test>
              <edit mode="assign" name="embolden">
                  <bool>true</bool>
              </edit>
          </match>
          <match target="font">
              <test compare="contains" name="family">
                  <string>Ming</string>
              </test>
              <!-- check to see if the font is just regular -->
              <test compare="less_eq" name="weight">
                  <int>100</int>
              </test>
              <test compare="more_eq" target="pattern" name="weight">
                  <int>180</int>
              </test>
              <edit mode="assign" name="embolden">
                  <bool>true</bool>
              </edit>
          </match>
          <dir>~/.fonts</dir>
      </fontconfig>
    '';
  };
}
