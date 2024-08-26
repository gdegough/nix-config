{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/autostart/org.codeberg.dnkl.foot-server.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Exec=foot --server
      Icon=foot
      Terminal=false
      Categories=System;TerminalEmulator;
      Keywords=shell;prompt;command;commandline;

      Name=Foot Server
      GenericName=Terminal
      Comment=A wayland native terminal emulator (server)
      NotShowIn=sway;hyprland;GNOME;KDE;
    '';
    ".config/foot/foot-transparent.ini".text = ''
      [main]
      term=xterm-256color
      font=IBM Plex Mono:size=10
      dpi-aware=no
      initial-window-size-chars=132x43
      include=~/.config/foot/colorscheme

      [colors]
      alpha=0.8

      [scrollback]
      lines=10000

      [cursor]
      blink=yes
    '';
    ".config/foot/foot-opaque.ini".text = ''
      [main]
      term=xterm-256color
      font=IBM Plex Mono:size=10
      dpi-aware=no
      initial-window-size-chars=132x43
      include=~/.config/foot/colorscheme

      [colors]
      alpha=1.0

      [scrollback]
      lines=10000

      [cursor]
      blink=yes
    '';
    ".config/foot/colorschemes.d/afterglow".text = ''
      # Afterglow
      [colors]
      # Default colors
      foreground=d6d6d6
      background=2c2c2c

      # Normal colors
      regular0=1c1c1c
      regular1=bc5653
      regular2=909d63
      regular3=ebc17a
      regular4=7eaac7
      regular5=aa6292
      regular6=86d3ce
      regular7=cacaca

      # Bright colors
      bright0=636363
      bright1=bc5653
      bright2=909d63
      bright3=ebc17a
      bright4=7eaac7
      bright5=aa6292
      bright6=86d3ce
      bright7=f7f7f7

      # Dim colors
      dim0=232323
      dim1=74423f
      dim2=5e6547
      dim3=8b7653
      dim4=556b79
      dim5=6e4962
      dim6=5c8482
      dim7=828282
    '';
    ".config/foot/colorschemes.d/argonaut".text = ''
      # Argonaut
      [colors]
      foreground=EBEBEB
      background=292C3E

      # Normal colors
      regular0=0d0d0d
      regular1=FF301B
      regular2=A0E521
      regular3=FFC620
      regular4=1BA6FA
      regular5=8763B8
      regular6=21DEEF
      regular7=EBEBEB

      # Bright colors
      bright0=6D7070
      bright1=FF4352
      bright2=B8E466
      bright3=FFD750
      bright4=1BA6FA
      bright5=A578EA
      bright6=73FBF1
      bright7=FEFEF8
    '';
    ".config/foot/colorschemes.d/ayu-dark".text = ''
      # Ayu (dark)
      [colors]
      # Default colors
      foreground=B3B1AD
      background=0A0E14

      # Normal colors
      regular0=01060E
      regular1=EA6C73
      regular2=91B362
      regular3=F9AF4F
      regular4=53BDFA
      regular5=FAE994
      regular6=90E1C6
      regular7=C7C7C7

      # Bright colors
      bright0=686868
      bright1=F07178
      bright2=C2D94C
      bright3=FFB454
      bright4=59C2FF
      bright5=FFEE99
      bright6=95E6CB
      bright7=FFFFFF
    '';
    ".config/foot/colorschemes.d/ayu-mirage".text = ''
      # Ayu Mirage
      [colors]
      # Default colors
      foreground=CBCCC6
      background=202734

      # Normal colors
      regular0=191E2A
      regular1=FF3333
      regular2=BAE67E
      regular3=FFA759
      regular4=73D0FF
      regular5=FFD580
      regular6=95E6CB
      regular7=C7C7C7

      # Bright colors
      bright0=686868
      bright1=F27983
      bright2=A6CC70
      bright3=FFCC66
      bright4=5CCFE6
      bright5=FFEE99
      bright6=95E6CB
      bright7=FFFFFF
    '';
    ".config/foot/colorschemes.d/base16-default-dark".text = ''
      # Base16 Default (dark)
      [colors]
      # Default colors
      foreground=d8d8d8
      background=181818

      # Normal colors
      regular0=181818
      regular1=ab4642
      regular2=a1b56c
      regular3=f7ca88
      regular4=7cafc2
      regular5=ba8baf
      regular6=86c1b9
      regular7=d8d8d8

      # Bright colors
      bright0=585858
      bright1=ab4642
      bright2=a1b56c
      bright3=f7ca88
      bright4=7cafc2
      bright5=ba8baf
      bright6=86c1b9
      bright7=f8f8f8
    '';
    ".config/foot/colorschemes.d/bloodmoon".text = ''
      # Bloodmoon
      [colors]
      # Default colors
      foreground=C6C6C4
      background=10100E

      # Normal colors
      regular0=10100E
      regular1=C40233
      regular2=009F6B
      regular3=FFD700
      regular4=0087BD
      regular5=9A4EAE
      regular6=20B2AA
      regular7=C6C6C4

      # Bright colors
      bright0=696969
      bright1=FF2400
      bright2=03C03C
      bright3=FDFF00
      bright4=007FFF
      bright5=FF1493
      bright6=00CCCC
      bright7=FFFAFA
    '';
    ".config/foot/colorschemes.d/breeze".text = ''
      # Breeze
      [colors]
      # Default colors
      foreground=fcfcfc
      background=232627

      # Normal colors
      regular0=232627
      regular1=ed1515
      regular2=11d116
      regular3=f67400
      regular4=1d99f3
      regular5=9b59b6
      regular6=1abc9c
      regular7=fcfcfc

      # Bright colors
      bright0=7f8c8d
      bright1=c0392b
      bright2=1cdc9a
      bright3=fdbc4b
      bright4=3daee9
      bright5=8e44ad
      bright6=16a085
      bright7=ffffff

      # Dim colors
      dim0=31363b
      dim1=783228
      dim2=17a262
      dim3=b65619
      dim4=1b668f
      dim5=614a73
      dim6=186c60
      dim7=63686d
    '';
    ".config/foot/colorschemes.d/campbell".text = ''
      # Campbell
      [colors]
      # Default colors
      foreground=cccccc
      background=0c0c0c

      # Normal colors
      regular0=0c0c0c
      regular1=c50f1f
      regular2=13a10e
      regular3=c19c00
      regular4=0037da
      regular5=881798
      regular6=3a96dd
      regular7=cccccc

      # Bright colors
      bright0=767676
      bright1=e74856
      bright2=16c60c
      bright3=f9f1a5
      bright4=3b78ff
      bright5=b4009e
      bright6=61d6d6
      bright7=f2f2f2
    '';
    ".config/foot/colorschemes.d/cobalt2".text = ''
      # Cobalt2
      [colors]
      # Default colors
      foreground=ffffff
      background=132738

      # Normal colors
      regular0=000000
      regular1=ff0000
      regular2=38de21
      regular3=ffe50a
      regular4=1460d2
      regular5=ff005d
      regular6=00bbbb
      regular7=bbbbbb

      # Bright colors
      bright0=555555
      bright1=f40e17
      bright2=3bd01d
      bright3=edc809
      bright4=5555ff
      bright5=ff55ff
      bright6=6ae3fa
      bright7=ffffff
    '';
    ".config/foot/colorschemes.d/darkside".text = ''
      # Darkside
      [colors]
      # Default colors
      foreground=BABABA
      background=222324

      # Normal colors
      regular0=000000
      regular1=E8341C
      regular2=68C256
      regular3=F2D42C
      regular4=1C98E8
      regular5=8E69C9
      regular6=1C98E8
      regular7=BABABA

      # Bright colors
      bright0=666666
      bright1=E05A4F
      bright2=77B869
      bright3=EFD64B
      bright4=387CD3
      bright5=957BBE
      bright6=3D97E2
      bright7=BABABA
    '';
    ".config/foot/colorschemes.d/darktooth".text = ''
      # Darktooth
      [colors]
      # Default colors
      foreground=fdf4c1
      background=282828

      # Normal colors
      regular0=282828
      regular1=9d0006
      regular2=79740e
      regular3=b57614
      regular4=076678
      regular5=8f3f71
      regular6=00a7af
      regular7=fdf4c1

      # Bright colors
      bright0=32302f
      bright1=fb4933
      bright2=b8bb26
      bright3=fabd2f
      bright4=83a598
      bright5=d3869b
      bright6=3fd7e5
      bright7=ffffc8

      # Dim colors (Optional)
      dim0=1d2021
      dim1=421e1e
      dim2=232b0f
      dim3=4d3b27
      dim4=2b3c44
      dim5=4e3d45
      dim6=205161
      dim7=f4e8ba
    '';
    ".config/foot/colorschemes.d/dracula".text = ''
      # Dracula
      [colors]
      # Default colors
      foreground=f8f8f2
      background=282a36

      # Normal colors
      regular0=000000
      regular1=ff5555
      regular2=50fa7b
      regular3=f1fa8c
      regular4=caa9fa
      regular5=ff79c6
      regular6=8be9fd
      regular7=bfbfbf

      # Bright colors
      bright0=575b70
      bright1=ff6e67
      bright2=5af78e
      bright3=f4f99d
      bright4=caa9fa
      bright5=ff92d0
      bright6=9aedfe
      bright7=e6e6e6
    '';
    ".config/foot/colorschemes.d/gnome-dark".text = ''
      # GNOME (dark)
      [colors]
      # Default colors
      foreground=d0cfcc
      background=171421

      # Normal colors
      regular0=171421
      regular1=c01c28
      regular2=26a269
      regular3=a2734c
      regular4=12488b
      regular5=a347ba
      regular6=2aa1b3
      regular7=d0cfcc

      # Bright colors
      bright0=5e5c64
      bright1=f66151
      bright2=33d17a
      bright3=e9ad0c
      bright4=2a7bde
      bright5=c061cb
      bright6=33c7de
      bright7=ffffff
    '';
    ".config/foot/colorschemes.d/gnome-light".text = ''
      # GNOME (light)
      [colors]
      # Default colors
      foreground=171421
      background=ffffff

      # Normal colors
      regular0=171421
      regular1=c01c28
      regular2=26a269
      regular3=a2734c
      regular4=12488b
      regular5=a347ba
      regular6=2aa1b3
      regular7=d0cfcc

      # Bright colors
      bright0=5e5c64
      bright1=f66151
      bright2=33d17a
      bright3=e9ad0c
      bright4=2a7bde
      bright5=c061cb
      bright6=33c7de
      bright7=ffffff
    '';
    ".config/foot/colorschemes.d/gruvbox-dark".text = ''
      # Gruvbox (dark)
      [colors]
      # Default colors
      foreground=fbf1c7
      background=282828

      # Normal colors 
      regular0=282828
      regular1=cc241d
      regular2=98971a
      regular3=d79921
      regular4=458588
      regular5=b16286
      regular6=689d6a
      regular7=a89984

      # Bright colors 
      bright0=928374
      bright1=fb4934
      bright2=b8bb26
      bright3=fabd2f
      bright4=83a598
      bright5=d3869b
      bright6=8ec07c
      bright7=ebdbb2

      # Dim colors 
      dim0=32302f
      dim1=9d0006
      dim2=79740e
      dim3=b57614
      dim4=076678
      dim5=8f3f71
      dim6=427b58
      dim7=928374
    '';
    ".config/foot/colorschemes.d/gruvbox-light".text = ''
      # Gruvbox (light)
      [colors]
      # Default colors
      foreground=3c3836
      background=fbf1c7

      # Normal colors
      regular0=fbf1c7
      regular1=cc241d
      regular2=98971a
      regular3=d79921
      regular4=458588
      regular5=b16286
      regular6=689d6a
      regular7=7c6f64

      # Bright colors
      bright0=928374
      bright1=9d0006
      bright2=79740e
      bright3=b57614
      bright4=076678
      bright5=8f3f71
      bright6=427b58
      bright7=3c3836
    '';
    ".config/foot/colorschemes.d/hybrid".text = ''
      # Hybrid
      [colors]
      # Default colors
      foreground=d0d2d1
      background=27292c

      # Normal colors
      regular0=35383b
      regular1=b05655
      regular2=769972
      regular3=e1a574
      regular4=7693ac
      regular5=977ba0
      regular6=749e99
      regular7=848b92

      # Bright colors
      bright0=484c52
      bright1=d27c7b
      bright2=dffebe
      bright3=f0d189
      bright4=96b1c9
      bright5=bfa5c7
      bright6=9fc9c3
      bright7=fcf7e2
    '';
    ".config/foot/colorschemes.d/hyper".text = ''
      # Hyper
      [colors]
      # Default colors
      foreground=ffffff
      background=000000

      # Normal colors
      regular0=000000
      regular1=fe0100
      regular2=33ff00
      regular3=feff00
      regular4=0066ff
      regular5=cc00ff
      regular6=00ffff
      regular7=d0d0d0

      # Bright colors
      bright0=808080
      bright1=fe0100
      bright2=33ff00
      bright3=feff00
      bright4=0066ff
      bright5=cc00ff
      bright6=00ffff
      bright7=FFFFFF
    '';
    ".config/foot/colorschemes.d/iceberg-dark".text = ''
      # Iceberg (dark)
      [colors]
      # Default colors
      foreground=d2d4de
      background=161821

      # Normal colors
      regular0=161821
      regular1=e27878
      regular2=b4be82
      regular3=e2a478
      regular4=84a0c6
      regular5=a093c7
      regular6=89b8c2
      regular7=c6c8d1

      # Bright colors
      bright0=6b7089
      bright1=e98989
      bright2=c0ca8e
      bright3=e9b189
      bright4=91acd1
      bright5=ada0d3
      bright6=95c4ce
      bright7=d2d4de
    '';
    ".config/foot/colorschemes.d/iceberg-light".text = ''
      # Iceberg (light)
      [colors]
      # Default colors
      foreground=33374c
      background=e8e9ec

      # Normal colors
      regular0=dcdfe7
      regular1=cc517a
      regular2=668e3d
      regular3=c57339
      regular4=2d539e
      regular5=7759b4
      regular6=3f83a6
      regular7=33374c

      # Bright colors
      bright0=8389a3
      bright1=cc3768
      bright2=598030
      bright3=b6662d
      bright4=22478e
      bright5=6845ad
      bright6=327698
      bright7=262a3f
    '';
    ".config/foot/colorschemes.d/ir-black".text = ''
      # IR Black
      [colors]
      # Default colors
      foreground=ffffff
      background=000000

      # Normal colors
      regular0=4e4e4e
      regular1=ff6c60
      regular2=a8ff60
      regular3=ffffb6
      regular4=96cbfe
      regular5=ff73fd
      regular6=c6c5fe
      regular7=eeeeee

      # Bright colors
      bright0=7c7c7c
      bright1=ffb6b0
      bright2=ceffab
      bright3=ffffcb
      bright4=b5dcfe
      bright5=ff9cfe
      bright6=dfdffe
      bright7=ffffff
    '';
    ".config/foot/colorschemes.d/iterm-default".text = ''
      # iTerm (default)
      [colors]
      # Default colors
      foreground=fffbf6
      background=101421

      # Normal colors
      regular0=2e2e2e
      regular1=eb4129
      regular2=abe047
      regular3=f6c744
      regular4=47a0f3
      regular5=7b5cb0
      regular6=64dbed
      regular7=e5e9f0

      # Bright colors
      bright0=565656
      bright1=ec5357
      bright2=c0e17d
      bright3=f9da6a
      bright4=49a4f8
      bright5=a47de9
      bright6=99faf2
      bright7=ffffff
    '';
    ".config/foot/colorschemes.d/jellybeans".text = ''
      # Jellybeans
      [colors]
      # Default colors
      foreground=e4e4e4
      background=161616

      # Normal colors
      regular0=a3a3a3
      regular1=e98885
      regular2=a3c38b
      regular3=ffc68d
      regular4=a6cae2
      regular5=e7cdfb
      regular6=00a69f
      regular7=e4e4e4

      # Bright colors
      bright0=c8c8c8
      bright1=ffb2b0
      bright2=c8e2b9
      bright3=ffe1af
      bright4=bddff7
      bright5=fce2ff
      bright6=0bbdb6
      bright7=feffff
    '';
    ".config/foot/colorschemes.d/kali-dark".text = ''
      # Kali (dark)
      [colors]
      # Default colors
      background=171421
      foreground=FFFFFF

      # Normal colors
      regular0=1F2229
      regular1=D41919
      regular2=5EBDAB
      regular3=FEA44C
      regular4=367BF0
      regular5=9755B3
      regular6=49AEE6
      regular7=E6E6E6

      # Bright colors
      bright0=198388
      bright1=EC0101
      bright2=47D4B9
      bright3=FF8A18
      bright4=277FFF
      bright5=962AC3
      bright6=05A1F7
      bright7=FFFFFF
    '';
    ".config/foot/colorschemes.d/kitty".text = ''
      # Kitty
      [colors]
      # Default colors
      foreground=dddddd
      background=000000

      # Normal colors
      regular0=000000
      regular1=cc0403
      regular2=19cb00
      regular3=cecb00
      regular4=0d73cc
      regular5=cb1ed1
      regular6=0dcdcd
      regular7=dddddd

      # Bright colors
      bright0=767676
      bright1=f2201f
      bright2=23fd00
      bright3=fffd00
      bright4=1a8fff
      bright5=fd28ff
      bright6=14ffff
      bright7=ffffff
    '';
    ".config/foot/colorschemes.d/material".text = ''
      # Material
      [colors]
      # Default colors
      foreground=eeffff
      background=263238

      # Normal colors
      regular0=000000  # Arbitrary
      regular1=e53935
      regular2=91b859
      regular3=ffb62c
      regular4=6182b8
      regular5=ff5370  # Dark pink of the original material theme
      regular6=39adb5
      regular7=a0a0a0  # Arbitrary

      # Bright colors
      bright0=4e4e4e  # Arbitrary
      bright1=ff5370
      bright2=c3e88d
      bright3=ffcb6b
      bright4=82aaff
      bright5=f07178  # Pink of the original material theme
      bright6=89ddff
      bright7=ffffff  # Arbitrary
    '';
    ".config/foot/colorschemes.d/molokai".text = ''
      # Molokai
      [colors]
      # Default colors
      foreground=F8F8F2
      background=1B1D1E

      # Normal colors
      regular0=333333
      regular1=C4265E
      regular2=86B42B
      regular3=B3B42B
      regular4=6A7EC8
      regular5=8C6BC8
      regular6=56ADBC
      regular7=E3E3DD

      # Bright colors
      bright0=666666
      bright1=F92672
      bright2=A6E22E
      bright3=E2E22E
      bright4=819AFF
      bright5=AE81FF
      bright6=66D9EF
      bright7=F8F8F2
    '';
    ".config/foot/colorschemes.d/monokai".text = ''
      # Monokai
      [colors]
      # Default colors
      foreground=F8F8F2
      background=272822

      # Normal colors
      regular0=272822
      regular1=F92672
      regular2=A6E22E
      regular3=F4BF75
      regular4=66D9EF
      regular5=AE81FF
      regular6=A1EFE4
      regular7=F8F8F2

      # Bright colors
      bright0=75715E
      bright1=F92672
      bright2=A6E22E
      bright3=F4BF75
      bright4=66D9EF
      bright5=AE81FF
      bright6=A1EFE4
      bright7=F9F8F5
    '';
    ".config/foot/colorschemes.d/monokai-pro".text = ''
      # Monokai Pro
      [colors]
      # Default colors
      foreground=FCFCFA
      background=2D2A2E

      # Normal colors
      regular0=403E41
      regular1=FF6188
      regular2=A9DC76
      regular3=FFD866
      regular4=FC9867
      regular5=AB9DF2
      regular6=78DCE8
      regular7=FCFCFA

      # Bright colors
      bright0=727072
      bright1=FF6188
      bright2=A9DC76
      bright3=FFD866
      bright4=FC9867
      bright5=AB9DF2
      bright6=78DCE8
      bright7=FCFCFA
    '';
    ".config/foot/colorschemes.d/monokai-soda".text = ''
      # Monokai Soda
      [colors]
      # Default colors
      foreground=c4c5b5
      background=1a1a1a

      # Normal colors
      regular0=1a1a1a
      regular1=f4005f
      regular2=98e024
      regular3=fa8419
      regular4=9d65ff
      regular5=f4005f
      regular6=58d1eb
      regular7=c4c5b5

      # Bright colors
      bright0=625e4c
      bright1=f4005f
      bright2=98e024
      bright3=e0d561
      bright4=9d65ff
      bright5=f4005f
      bright6=58d1eb
      bright7=f6f6ef
    '';
    ".config/foot/colorschemes.d/new-moon".text = ''
      # New Moon
      [colors]
      # Default colors
      foreground=B3B9C5
      background=2D2D2D

      # Normal colors
      regular0=2D2D2D
      regular1=F2777A
      regular2=92D192
      regular3=FFD479
      regular4=6AB0F3
      regular5=E1A6F2
      regular6=76D4D6
      regular7=B3B9C5

      # Bright colors
      bright0=777C85
      bright1=F2777A
      bright2=76D4D6
      bright3=FFEEA6
      bright4=6AB0F3
      bright5=E1A6F2
      bright6=76D4D6
      bright7=FFFFFF
    '';
    ".config/foot/colorschemes.d/nightfly".text = ''
      # Nightfly
      [colors]
      # Default colors
      foreground=acb4c2
      background=011627

      # Normal colors
      regular0=1d3b53
      regular1=fc514e
      regular2=a1cd5e
      regular3=e3d18a
      regular4=82aaff
      regular5=c792ea
      regular6=7fdbca
      regular7=a1aab8

      # Bright colors
      bright0=7c8f8f
      bright1=ff5874
      bright2=21c7a8
      bright3=ecc48d
      bright4=82aaff
      bright5=ae81ff
      bright6=7fdbca
      bright7=d6deeb
    '';
    ".config/foot/colorschemes.d/night-owl".text = ''
      # Night Owl
      [colors]
      # Default colors
      foreground=d6deeb
      background=011627

      # Normal colors
      regular0=011627
      regular1=ef5350
      regular2=22da6e
      regular3=c5e478
      regular4=82aaff
      regular5=c792ea
      regular6=21c7a8
      regular7=ffffff

      # Bright colors
      bright0=575656
      bright1=ef5350
      bright2=22da6e
      bright3=ffeb95
      bright4=82aaff
      bright5=c792ea
      bright6=7fdbca
      bright7=ffffff
    '';
    ".config/foot/colorschemes.d/nord".text = ''
      # Nord
      [colors]
      # Default colors
      foreground=D8DEE9
      background=2E3440

      # Normal colors
      regular0=3B4252
      regular1=BF616A
      regular2=A3BE8C
      regular3=EBCB8B
      regular4=81A1C1
      regular5=B48EAD
      regular6=88C0D0
      regular7=E5E9F0

      # Bright colors
      bright0=4C566A
      bright1=BF616A
      bright2=A3BE8C
      bright3=EBCB8B
      bright4=81A1C1
      bright5=B48EAD
      bright6=8FBCBB
      bright7=ECEFF4
    '';
    ".config/foot/colorschemes.d/nova".text = ''
      # Nova
      [colors]
      # Default colors
      foreground=C5D4DD
      background=3C4C55

      # Normal colors
      regular0=3C4C55
      regular1=DF8C8C
      regular2=A8CE93
      regular3=DADA93
      regular4=83AFE5
      regular5=9A93E1
      regular6=7FC1CA
      regular7=C5D4DD

      # Bright colors
      bright0=899BA6
      bright1=F2C38F
      bright2=A8CE93
      bright3=DADA93
      bright4=83AFE5
      bright5=D18EC2
      bright6=7FC1CA
      bright7=E6EEF3
    '';
    ".config/foot/colorschemes.d/oceanic-next".text = ''
      # Oceanic Next
      [colors]
      # Default colors
      foreground=d8dee9
      background=1b2b34

      # Normal colors
      regular0=343d46
      regular1=EC5f67
      regular2=99C794
      regular3=FAC863
      regular4=6699cc
      regular5=c594c5
      regular6=5fb3b3
      regular7=d8dee9

      # Bright colors
      bright0=343d46
      bright1=EC5f67
      bright2=99C794
      bright3=FAC863
      bright4=6699cc
      bright5=c594c5
      bright6=5fb3b3
      bright7=d8dee9
    '';
    ".config/foot/colorschemes.d/one-dark".text = ''
      # One (dark)
      [colors]
      # Default colors
      foreground=d8dee9
      background=1b2b34

      # Normal colors
      regular0=343d46
      regular1=EC5f67
      regular2=99C794
      regular3=FAC863
      regular4=6699cc
      regular5=c594c5
      regular6=5fb3b3
      regular7=d8dee9

      # Bright colors
      bright0=343d46
      bright1=EC5f67
      bright2=99C794
      bright3=FAC863
      bright4=6699cc
      bright5=c594c5
      bright6=5fb3b3
      bright7=d8dee9
    '';
    ".config/foot/colorschemes.d/one-light".text = ''
      # One (light)
      [colors]
      # Default colors
      foreground=383a42
      background=fafafa

      # Normal colors
      regular0=696c77
      regular1=e45649
      regular2=50a14f
      regular3=c18401
      regular4=4078f2
      regular5=a626a4
      regular6=0184bc
      regular7=a0a1a7
    '';
    ".config/foot/colorschemes.d/oxide".text = ''
      # Oxide
      [colors]
      # Default colors
      foreground=c0c5ce
      background=212121

      # Normal colors
      regular0=212121
      regular1=e57373
      regular2=a6bc69
      regular3=fac863
      regular4=6699cc
      regular5=c594c5
      regular6=5fb3b3
      regular7=c0c5ce

      # Bright colors
      bright0=5c5c5c
      bright1=e57373
      bright2=a6bc69
      bright3=fac863
      bright4=6699cc
      bright5=c594c5
      bright6=5fb3b3
      bright7=f3f4f5
    '';
    ".config/foot/colorschemes.d/panda".text = ''
      # Panda
      [colors]
      # Default colors
      foreground=E6E6E6
      background=292A2B

      # Normal colors
      regular0=292A2B
      regular1=FF2C6D
      regular2=19f9d8
      regular3=FFB86C
      regular4=45A9F9
      regular5=FF75B5
      regular6=67d3c2
      regular7=E6E6E6

      # Bright colors
      bright0=292A2B
      bright1=FF2C6D
      bright2=19f9d8
      bright3=ffcc95
      bright4=6FC1FF
      bright5=FF9AC1
      bright6=67d3c2
      bright7=ffffff
    '';
    ".config/foot/colorschemes.d/pear-dark-blue".text = ''
      # Pear Dark Blue
      [colors]
      # Default colors
      foreground=ffffff
      background=222226

      # Normal colors
      regular0=222226
      regular1=f841a0
      regular2=25c141
      regular3=fdf454
      regular4=2f9ded
      regular5=f97137
      regular6=19cde6
      regular7=ffffff

      # Bright colors
      bright0=969696
      bright1=f6188f
      bright2=1ebb2b
      bright3=fdf834
      bright4=2186ec
      bright5=f85a21
      bright6=12c3e2
      bright7=ffffff
    '';
    ".config/foot/colorschemes.d/pencil-dark".text = ''
      # Pencil (dark)
      [colors]
      # Default Colors
      foreground=f1f1f1
      background=212121

      # Normal colors
      regular0=212121
      regular1=c30771
      regular2=10a778
      regular3=a89c14
      regular4=008ec4
      regular5=523c79
      regular6=20a5ba
      regular7=e0e0e0

      # Bright colors
      bright0=212121
      bright1=fb007a
      bright2=5fd7af
      bright3=f3e430
      bright4=20bbfc
      bright5=6855de
      bright6=4fb8cc
      bright7=f1f1f1
    '';
    ".config/foot/colorschemes.d/pencil-light".text = ''
      # Pencil (light)
      [colors]
      # Default Colors
      foreground=424242
      background=f1f1f1

      # Normal colors
      regular0=212121
      regular1=c30771
      regular2=10a778
      regular3=a89c14
      regular4=008ec4
      regular5=523c79
      regular6=20a5ba
      regular7=e0e0e0

      # Bright colors
      bright0=212121
      bright1=fb007a
      bright2=5fd7af
      bright3=f3e430
      bright4=20bbfc
      bright5=6855de
      bright6=4fb8cc
      bright7=f1f1f1
    '';
    ".config/foot/colorschemes.d/pop_os-dark".text = ''
    # Pop!_OS (dark)
    [colors]
    # Default colors
    foreground=F2F2F2
    background=333333

    # Normal colors
    regular0=333333
    regular1=CC0000
    regular2=4E9A06
    regular3=C4A000
    regular4=3465A4
    regular5=75507B
    regular6=06989A
    regular7=D3D7CF

    # Bright colors
    bright0=88807C
    bright1=F15D22
    bright2=73C48F
    bright3=FFCE51
    bright4=48B9C7
    bright5=AD7FA8
    bright6=34E2E2
    bright7=EEEEEC
  '';
  ".config/foot/colorschemes.d/seabird".text = ''
    # Seabird
    [colors]
    # Default colors
    foreground=61707a
    background=ffffff

    # Normal colors
    regular0=0b141a
    regular1=ff4053
    regular2=11ab00
    regular3=bf8c00
    regular4=0099ff
    regular5=9854ff
    regular6=00a5ab
    regular7=ffffff

    # Bright colors
    bright0=0b141a
    bright1=ff4053
    bright2=11ab00
    bright3=bf8c00
    bright4=0099ff
    bright5=9854ff
    bright6=00a5ab
    bright7=ffffff
  '';
  ".config/foot/colorschemes.d/seoul256".text = ''
    # Seoul256
    [colors]
    # Default colors
    foreground=d0d0d0
    background=3a3a3a

    # Normal colors
    regular0=4e4e4e
    regular1=d68787
    regular2=5f865f
    regular3=d8af5f
    regular4=85add4
    regular5=d7afaf
    regular6=87afaf
    regular7=d0d0d0

    # Bright colors
    bright0=626262
    bright1=d75f87
    bright2=87af87
    bright3=ffd787
    bright4=add4fb
    bright5=ffafaf
    bright6=87d7d7
    bright7=e4e4e4
  '';
  ".config/foot/colorschemes.d/snazzy".text = ''
    # Snazzy
    [colors]
    # Default colors
    foreground=eff0eb
    background=282a36

    # Normal colors
    regular0=282a36
    regular1=ff5c57
    regular2=5af78e
    regular3=f3f99d
    regular4=57c7ff
    regular5=ff6ac1
    regular6=9aedfe
    regular7=f1f1f0

    # Bright colors
    bright0=686868
    bright1=ff5c57
    bright2=5af78e
    bright3=f3f99d
    bright4=57c7ff
    bright5=ff6ac1
    bright6=9aedfe
    bright7=f1f1f0
  '';
  ".config/foot/colorschemes.d/solarized-dark".text = ''
    # Solarized (dark)
    [csd]
    color=ff292929
    button-color=ffffffff

    [colors]
    # Default colors
    background=002b36 # base03
    foreground=839496 # base0

    # Normal colors
    regular0=073642 # base02
    regular1=dc322f # red
    regular2=859900 # green
    regular3=b58900 # yellow
    regular4=268bd2 # blue
    regular5=d33682 # magenta
    regular6=2aa198 # cyan
    regular7=eee8d5 # base2
        
    # Bright colors
    bright0=002b36 # base03
    bright1=cb4b16 # orange
    bright2=586e75 # base01
    bright3=657b83 # base00
    bright4=839496 # base0
    bright5=6c71c4 # violet
    bright6=93a1a1 # base1
    bright7=fdf6e3 # base3
  '';
  ".config/foot/colorschemes.d/solarized-light".text = ''
      # Solarized (light)
      [colors]
      # Default colors
      foreground=657b83 # base00
      background=fdf6e3 # base3

      # Normal colors
      regular0=073642 # base02
      regular1=dc322f # red
      regular2=859900 # green
      regular3=b58900 # yellow
      regular4=268bd2 # blue
      regular5=d33682 # magenta
      regular6=2aa198 # cyan
      regular7=eee8d5 # base2

      # Bright colors
      bright0=002b36 # base03
      bright1=cb4b16 # orange
      bright2=586e75 # base01
      bright3=657b83 # base00
      bright4=839496 # base0
      bright5=6c71c4 # violet
      bright6=93a1a1 # base1
      bright7=fdf6e3 # base3
    '';
    ".config/foot/colorschemes.d/sourcerer".text = ''
      # Sourcerer
      [colors]
      # Default colors
      foreground=c2c2b0
      background=222222

      # Normal colors
      regular0=111111
      regular1=aa4450
      regular2=719611
      regular3=cc8800
      regular4=6688aa
      regular5=8f6f8f
      regular6=528b8b
      regular7=d3d3d3

      # Bright colors
      bright0=181818
      bright1=ff6a6a
      bright2=b1d631
      bright3=ff9800
      bright4=90b0d1
      bright5=8181a6
      bright6=87ceeb
      bright7=c1cdc1
    '';
    ".config/foot/colorschemes.d/spacemacs-light".text = ''
      # Spacemacs (light)
      [colors]
      # Default colors
      foreground=64526F
      background=FAF7EE

      # Normal colors
      regular0=FAF7EE
      regular1=DF201C
      regular2=29A0AD
      regular3=DB742E
      regular4=3980C2
      regular5=2C9473
      regular6=6B3062
      regular7=64526F

      # Bright colors
      bright0=9F93A1
      bright1=DF201C
      bright2=29A0AD
      bright3=DB742E
      bright4=3980C2
      bright5=2C9473
      bright6=6B3062
      bright7=64526F
    '';
    ".config/foot/colorschemes.d/substrata".text = ''
      # Substrata
      [colors]
      # Default colors
      foreground=b5b4c9
      background=191c25

      # Normal colors
      regular0=2e313d
      regular1=cf8164
      regular2=76a065
      regular3=ab924c
      regular4=8296b0
      regular5=a18daf
      regular6=659ea2
      regular7=b5b4c9

      # Bright colors
      bright0=5b5f71
      bright1=fe9f7c
      bright2=92c47e
      bright3=d2b45f
      bright4=a0b9d8
      bright5=c6aed7
      bright6=7dc2c7
      bright7=f0ecfe
    '';
    ".config/foot/colorschemes.d/taerminal".text = ''
      # Taerminal
      [colors]
      # Default colors
      foreground=f0f0f0
      background=26282a

      # Normal colors
      regular0=26282a
      regular1=ff8878
      regular2=b4fb73
      regular3=fffcb7
      regular4=8bbce5
      regular5=ffb2fe
      regular6=a2e1f8
      regular7=f1f1f1

      # Bright colors
      bright0=6f6f6f
      bright1=fe978b
      bright2=d6fcba
      bright3=fffed5
      bright4=c2e3ff
      bright5=ffc6ff
      bright6=c0e9f8
      bright7=ffffff
    '';
    ".config/foot/colorschemes.d/tango".text = ''
      # Tango
      [colors]
      # Default colors
      foreground=00ff00
      background=000000

      # Normal colors
      regular0=2e3436
      regular1=cc0000
      regular2=73d216
      regular3=edd400
      regular4=3465a4
      regular5=75507b
      regular6=06989a
      regular7=d3d7cf

      # Bright colors
      bright0=2e3436
      bright1=ef2929
      bright2=8ae234
      bright3=fce94f
      bright4=729fcf
      bright5=ad7fa8
      bright6=34e2e2
      bright7=eeeeec
    '';
    ".config/foot/colorschemes.d/tangoish".text = ''
      # Tangoish
      [colors]
      # Default colors
      foreground=eeeeec
      background=2e3436

      # Normal colors
      regular0=2e3436
      regular1=cc0000
      regular2=73d216
      regular3=edd400
      regular4=3465a4
      regular5=75507b
      regular6=f57900
      regular7=d3d7cf

      # Bright colors
      bright0=2e3436
      bright1=ef2929
      bright2=8ae234
      bright3=fce94f
      bright4=729fcf
      bright5=ad7fa8
      bright6=fcaf3e
      bright7=eeeeec
    '';
    ".config/foot/colorschemes.d/tender".text = ''
      # Tender
      [colors]
      # Default colors
      foreground=eeeeee
      background=282828

      # Normal colors
      regular0=282828
      regular1=f43753
      regular2=c9d05c
      regular3=ffc24b
      regular4=b3deef
      regular5=d3b987
      regular6=73cef4
      regular7=eeeeee

      # Bright colors
      bright0=4c4c4c
      bright1=f43753
      bright2=c9d05c
      bright3=ffc24b
      bright4=b3deef
      bright5=d3b987
      bright6=73cef4
      bright7=feffff
    '';
    ".config/foot/colorschemes.d/terminal-app".text = ''
      # Terminal App
      [colors]
      # Default colors
      foreground=b6b6b6
      background=000000

      # Normal colors
      regular0=000000
      regular1=990000
      regular2=00a600
      regular3=999900
      regular4=0000b2
      regular5=b200b2
      regular6=00a6b2
      regular7=bfbfbf

      # Bright colors
      bright0=666666
      bright1=e50000
      bright2=00d900
      bright3=e5e500
      bright4=0000ff
      bright5=e500e5
      bright6=00e5e5
      bright7=e5e5e5
    '';
    ".config/foot/colorschemes.d/terminal-app-basic".text = ''
      # Terminal App (basic)
      [colors]
      # Default colors
      foreground=000000
      background=FFFFFF

      # Default colors
      regular0=000000
      regular1=990000
      regular2=00A600
      regular3=999900
      regular4=0000B2
      regular5=B200B2
      regular6=00A6B2
      regular7=BFBFBF

      # Default colors
      bright0=666666
      bright1=E50000
      bright2=00D900
      bright3=E5E500
      bright4=0000FF
      bright5=E500E5
      bright6=00E5E5
      bright7=E5E5E5
    '';
    ".config/foot/colorschemes.d/tomorrow-night".text = ''
      # Tomorrow Night
      [colors]
      # Default colors
      foreground=c5c8c6
      background=1d1f21

      # Normal colors
      regular0=1d1f21
      regular1=cc6666
      regular2=b5bd68
      regular3=e6c547
      regular4=81a2be
      regular5=b294bb
      regular6=70c0ba
      regular7=373b41

      # Bright colors
      bright0=666666
      bright1=ff3334
      bright2=9ec400
      bright3=f0c674
      bright4=81a2be
      bright5=b77ee0
      bright6=54ced6
      bright7=282a2e
    '';
    ".config/foot/colorschemes.d/tomorrow-night-bright".text = ''
      # Tomorrow Night (bright)
      [colors]
      # Default colors
      foreground=eaeaea
      background=000000

      # Normal colors
      regular0=000000
      regular1=d54e53
      regular2=b9ca4a
      regular3=e6c547
      regular4=7aa6da
      regular5=c397d8
      regular6=70c0ba
      regular7=424242

      # Bright colors
      bright0=666666
      bright1=ff3334
      bright2=9ec400
      bright3=e7c547
      bright4=7aa6da
      bright5=b77ee0
      bright6=54ced6
      bright7=2a2a2a
    '';
    ".config/foot/colorschemes.d/ubuntu".text = ''
      # Ubuntu
      [colors]
      # Default colors
      foreground=eeeeec
      background=300a24

      # Normal colors
      regular0=2e3436
      regular1=cc0000
      regular2=4e9a06
      regular3=c4a000
      regular4=3465a4
      regular5=75507b
      regular6=06989a
      regular7=d3d7cf

      # Bright colors
      bright0=555753
      bright1=ef2929
      bright2=8ae234
      bright3=fce94f
      bright4=729fcf
      bright5=ad7fa8
      bright6=34e2e2
      bright7=eeeeec
    '';
    ".config/foot/colorschemes.d/vscode-terminal".text = ''
      # VSCode Terminal
      [colors]
      # Default colors
      foreground=ffffff
      background=000000

      # Normal colors
      regular0=000000
      regular1=cd3131
      regular2=0dbc79
      regular3=e5e510
      regular4=2472c8
      regular5=bc3fbc
      regular6=11a8cd
      regular7=e5e5e5

      # Bright colors
      bright0=666666
      bright1=f14c4c
      bright2=23d18b
      bright3=f5f543
      bright4=3b8eea
      bright5=d670d6
      bright6=29b8db
      bright7=e5e5e5
    '';
    ".config/foot/colorschemes.d/wombat".text = ''
      # Wombat
      [colors]
      # Default colors
      foreground=e5e1d8
      background=1f1f1f

      # Normal colors
      regular0=000000
      regular1=f7786d
      regular2=bde97c
      regular3=efdfac
      regular4=6ebaf8
      regular5=ef88ff
      regular6=90fdf8
      regular7=e5e1d8

      # Bright colors
      bright0=b4b4b4
      bright1=f99f92
      bright2=e3f7a1
      bright3=f2e9bf
      bright4=b3d2ff
      bright5=e5bdff
      bright6=c2fefa
      bright7=ffffff
    '';
    ".config/foot/colorschemes.d/xterm".text = ''
      # Xterm
      [colors]
      # Default colors
      foreground=ffffff
      background=000000

      # Normal colors
      regular0=000000
      regular1=cd0000
      regular2=00cd00
      regular3=cdcd00
      regular4=0000ee
      regular5=cd00cd
      regular6=00cdcd
      regular7=e5e5e5

      # Bright colors
      bright0=7f7f7f
      bright1=ff0000
      bright2=00ff00
      bright3=ffff00
      bright4=5c5cff
      bright5=ff00ff
      bright6=00ffff
      bright7=ffffff
    '';
    ".config/foot/colorschemes.d/zenburn".text = ''
      # Zenburn
      [colors]
      # Default colors
      foreground=ffffff
      background=333333

      # Normal colors
      regular0=4d4d4d
      regular1=bb0000
      regular2=98f898
      regular3=f0e68c
      regular4=96853f
      regular5=ffdead
      regular6=ffa0a0
      regular7=f5deb3

      # Bright colors
      bright0=555555
      bright1=ff5555
      bright2=55ff55
      bright3=ffff55
      bright4=87ceeb
      bright5=ff55ff
      bright6=ffd700
      bright7=ffffff
    '';
  };
}
