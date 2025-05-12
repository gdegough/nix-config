{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".xprofile".text = ''
      # Load Xresources settings
      if [ -f $HOME/.Xresources ]; then
          xrdb -load -I$HOME $HOME/.Xresources
      fi
    '';
    ".xprofile".executable = true;
#    ".Xresources".text = ''
#      ! Xft.dpi: 144
#      ! Xcursor.size: 36
#      Xcursor.theme: Adwaita
#      Xcursor.theme_core: 1
#      ! #include ".Xresources.d/solarized-light"
#      #include ".Xresources.d/solarized-dark"
#      ! #include ".Xresources.d/terminal-dark"
#      ! #include ".Xresources.d/terminal-bloodmoon"
#      #include ".Xresources.d/xterm"
#      #include ".Xresources.d/zutty"
#    '';
    ".Xresources.d/solarized-light".text = ''
      ! Solarized color scheme for the X Window System
      !
      ! http://ethanschoonover.com/solarized

      ! Common Colors
      #define S_yellow        #b58900
      #define S_orange        #cb4b16
      #define S_red           #dc322f
      #define S_magenta       #d33682
      #define S_violet        #6c71c4
      #define S_blue          #268bd2
      #define S_cyan          #2aa198
      #define S_green         #859900

      ! Base Colors
      #define S_base03        #002b36
      #define S_base02        #073642
      #define S_base01        #586e75
      #define S_base00        #657b83
      #define S_base0         #839496
      #define S_base1         #93a1a1
      #define S_base2         #eee8d5
      #define S_base3         #fdf6e3

      ! To only apply colors to your terminal, for example, prefix
      ! the color assignment statement with its name. Example:
      !
      ! URxvt*background:            S_base03
      *background:              S_base3
      *bg:                      S_base3
      *foreground:              S_base00
      *fg:                      S_base00
      *fading:                  40
      *fadeColor:               S_base3
      *cursorColor:             S_base01
      *cr:                      S_base01
      *pointerColorBackground:  S_base1
      *pointerColorForeground:  S_base01

      *color0:                  S_base2
      *color1:                  S_red
      *color2:                  S_green
      *color3:                  S_yellow
      *color4:                  S_blue
      *color5:                  S_magenta
      *color6:                  S_cyan
      *color7:                  S_base02
      *color8:                  S_base3
      *color9:                  S_orange
      *color10:                 S_base1
      *color11:                 S_base0
      *color12:                 S_base00
      *color13:                 S_violet
      *color14:                 S_base01
      *color15:                 S_base03
    '';
    ".Xresources.d/solarized-dark".text = ''
      ! Solarized color scheme for the X Window System
      !
      ! http://ethanschoonover.com/solarized

      ! Common Colors
      #define S_yellow        #b58900
      #define S_orange        #cb4b16
      #define S_red           #dc322f
      #define S_magenta       #d33682
      #define S_violet        #6c71c4
      #define S_blue          #268bd2
      #define S_cyan          #2aa198
      #define S_green         #859900

      ! Base Colors
      #define S_base03        #002b36
      #define S_base02        #073642
      #define S_base01        #586e75
      #define S_base00        #657b83
      #define S_base0         #839496
      #define S_base1         #93a1a1
      #define S_base2         #eee8d5
      #define S_base3         #fdf6e3

      ! To only apply colors to your terminal, for example, prefix
      ! the color assignment statement with its name. Example:
      !
      ! URxvt*background:            S_base03
      *background:              S_base03
      *bg:                      S_base03
      *foreground:              S_base0
      *fg:                      S_base0
      *fading:                  40
      *fadeColor:               S_base03
      *cursorColor:             S_base1
      *cr:                      S_base1
      *pointerColorBackground:  S_base01
      *pointerColorForeground:  S_base1

      *color0:                  S_base02
      *color1:                  S_red
      *color2:                  S_green
      *color3:                  S_yellow
      *color4:                  S_blue
      *color5:                  S_magenta
      *color6:                  S_cyan
      *color7:                  S_base2
      *color8:                  S_base03
      *color9:                  S_orange
      *color10:                 S_base01
      *color11:                 S_base00
      *color12:                 S_base0
      *color13:                 S_violet
      *color14:                 S_base1
      *color15:                 S_base3
    '';
    ".Xresources.d/terminal-dark".text = ''
      ! special
      *.foreground:   #c5c8c6
      *.fg:           #c5c8c6
      *.background:   #1d1f21
      *.bg:           #1d1f21
      *.cursorColor:  #c5c8c6
      *.cr:           #c5c8c6

      ! black
      *.color0:       #282a2e
      *.color8:       #373b41

      ! red
      *.color1:       #a54242
      *.color9:       #cc6666

      ! green
      *.color2:       #8c9440
      *.color10:      #b5bd68

      ! yellow
      *.color3:       #de935f
      *.color11:      #f0c674

      ! blue
      *.color4:       #5f819d
      *.color12:      #81a2be

      ! magenta
      *.color5:       #85678f
      *.color13:      #b294bb

      ! cyan
      *.color6:       #5e8d87
      *.color14:      #8abeb7

      ! white
      *.color7:       #707880
      *.color15:      #c5c8c6
    '';
    ".Xresources.d/terminal-bloodmoon".text = ''
      ! special
      *.foreground:   #C6C6C4
      *.fg:           #C6C6C4
      *.background:   #10100E
      *.bg:           #10100E
      *.cursorColor:  #c5c8c6
      *.cr:           #c5c8c6

      ! black
      *.color0:       #10100E
      *.color8:       #696969

      ! red
      *.color1:       #C40233
      *.color9:       #FF2400

      ! green
      *.color2:       #009F6B
      *.color10:      #03C03C

      ! yellow
      *.color3:       #FFD700
      *.color11:      #FDFF00

      ! blue
      *.color4:       #0087BD
      *.color12:      #007FFF

      ! magenta
      *.color5:       #9A4EAE
      *.color13:      #FF1493

      ! cyan
      *.color6:       #20B2AA
      *.color14:      #00CCCC

      ! white
      *.color7:       #C6C6C4
      *.color15:      #FFFAFA
    '';
    ".Xresources.d/xterm".text = ''
      ! XTerm
      XTerm*termName:           xterm-256color
      XTerm*VT100.geometry:     132x43
      XTerm*faceName:           IBM Plex Mono Text
      XTerm*faceSize:           11
      XTerm*dynamicColors:      true
      XTerm*utf8:               2
      XTerm*eightBitInput:      true
      XTerm*saveLines:          10000
      XTerm*scrollKey:          true
      XTerm*scrollTtyOutput:    false
      XTerm*scrollBar:          false
      XTerm*rightScrollBar:     false
      XTerm*jumpScroll:         true
      XTerm*multiScroll:        true
      XTerm*toolBar:            false
      XTerm*locale:             true
      XTerm*selectToClipboard:  true
      XTerm*visualBell:         false
      XTerm*loginShell:         false
      XTerm*metaSendsEscape:    true

      ! UXTerm
      UXTerm*termName:           xterm-256color
      UXTerm*VT100.geometry:     132x43
      UXTerm*faceName:           IBM Plex Mono Text
      UXTerm*faceSize:           11
      UXTerm*dynamicColors:      true
      UXTerm*utf8:               2
      UXTerm*eightBitInput:      true
      UXTerm*saveLines:          10000
      UXTerm*scrollKey:          true
      UXTerm*scrollTtyOutput:    false
      UXTerm*scrollBar:          false
      UXTerm*rightScrollBar:     false
      UXTerm*jumpScroll:         true
      UXTerm*multiScroll:        true
      UXTerm*toolBar:            false
      UXTerm*locale:             true
      UXTerm*selectToClipboard:  true
      UXTerm*visualBell:         false
      UXTerm*loginShell:         false
      UXTerm*metaSendsEscape:    true
    '';
    ".Xresources.d/zutty".text = ''
      Zutty.altScroll:           true
      Zutty.autoCopy:            false
      Zutty.boldColors:          false
      Zutty.font:                IBMPlexMonoText
      Zutty.fontsize:            11
      Zutty.geometry:            132x43
      Zutty.login:               false
      Zutty.rv:                  false
      Zutty.saveLines:           10000
      Zutty.showWraps:           true
      Zutty.altSendsEscape:      false
      !Zutty.border:              2
    '';
  };
}
