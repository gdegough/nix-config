# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs {pkgs = final;};

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    megasync = prev.megasync.overrideAttrs (oldAttrs: rec {
      buildInputs = [
        c-ares
        cryptopp
        curl
        ffmpeg
        libmediainfo
        libraw
        libsodium
        libuv
        libzen
        qtbase
        qtx11extras
        sqlite
        wget
      ];
      configureFlags = [
        "--disable-examples"
        "--disable-java"
        "--disable-php"
        "--enable-chat"
        "--with-cares"
        "--with-cryptopp"
        "--with-curl"
        "--with-ffmpeg"
        "--without-freeimage"
        "--without-readline"
        "--without-termcap"
        "--with-sodium"
        "--with-sqlite"
        "--with-zlib"
      ];
    });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
