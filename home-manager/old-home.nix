{ config, pkgs, lib, ... }:

with lib.hm.gvariant;

{
  imports = [ 
    ./abcde.nix
    ./alacritty.nix
    ./autostart.nix
    ./bash.nix
    ./beets.nix
    ./conky.nix
    ./dconf.nix
    ./dircolors.nix
    ./fonts.nix
    ./foot.nix
    ./git.nix
    ./gnome-terminal.nix
    ./html-tidy.nix
    ./i3blocks.nix
    ./inputrc.nix
    ./mutt.nix
    ./rofi.nix
    ./sway.nix
    ./systemd-environment.nix
    ./tmux.nix
    ./vim.nix
    ./waybar.nix
    ./wofi.nix
    ./x.nix
    ./xsettingsd.nix
    ./zsh.nix
  ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "gmdegoug";
  home.homeDirectory = "/home/gmdegoug";
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };
  targets.genericLinux.enable = true;
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    abcde
    adwaita-qt
    adwaita-qt6
    ardour
    audacious
    audacity
    beets-unstable
    bitwarden
    ccextractor
    celluloid
    conky
    dconf2nix
    dia
    dvdbackup
    easyeffects
    easytag
    emacs-gtk
    evolutionWithPlugins
    fdk-aac-encoder
    firefox
    fluidsynth
    font-awesome
    frescobaldi
    gcolor3
    gimp-with-plugins
    git
    gnome-browser-connector
    gnome.dconf-editor
    gnome.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.caffeine
    gnomeExtensions.dash-to-dock
    gnomeExtensions.internet-radio
    gnomeExtensions.lock-keys
    gnuchess
    gnupg
    google-chrome
    hack-font
    helvum
    html-tidy
    htop
    hunspell
    hwinfo
    ibm-plex
    iftop
    inkscape
    iotop
    lame
    libreoffice
    lilypond
    lnav
    makemkv
    megasync
    meld
    mkvtoolnix
    mpv
    mutt
    neofetch
    nmap
    nmon
    noto-fonts
    obs-studio
    pciutils
    picard
    pitivi
    plexamp
    powerline
    putty
    qalculate-gtk
    qgnomeplatform
    qgnomeplatform-qt6
    qsynth
    quodlibet-full
    ranger
    rhythmbox
    signal-desktop
    sops
    soundfont-fluid
    system76-keyboard-configurator
    texlive.combined.scheme-full
    tmux
    traceroute
    vivaldi
    vivaldi-ffmpeg-codecs
    vlc
    vmpk
    vscode-with-extensions
    wget
  ];

  fonts.fontconfig.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
