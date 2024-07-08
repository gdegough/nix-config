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
    pkgs.alacritty
  ];
  home.file = {
    ".config/alacritty/alacritty-transparent.toml".text = ''
      import = ["~/.config/alacritty/colorscheme.toml"]

      [colors]
      transparent_background_colors = true
      draw_bold_text_with_bright_colors = true

      [cursor.style]
      blinking = "Always"
      shape = "Block"

      [env]
      TERM = "xterm-256color"

      [font]
      size = 11

      [font.bold]
      family = "IBM Plex Mono"
      style = "Bold"

      [font.bold_italic]
      family = "IBM Plex Mono"
      style = "Bold Italic"

      [font.italic]
      family = "IBM Plex Mono"
      style = "Italic"

      [font.normal]
      family = "IBM Plex Mono"

      [mouse]
      hide_when_typing = false

      [scrolling]
      history = 10000

      [window]
      decorations = "full"
      dynamic_padding = true
      dynamic_title = true
      opacity = 0.9

      [window.dimensions]
      columns = 132
      lines = 43
    '';
    ".config/alacritty/alacritty-opaque.toml".text = ''
      import = ["~/.config/alacritty/colorscheme.toml"]

      [colors]
      transparent_background_colors = true
      draw_bold_text_with_bright_colors = true

      [cursor.style]
      blinking = "Always"
      shape = "Block"

      [env]
      TERM = "xterm-256color"

      [font]
      size = 11

      [font.bold]
      family = "IBM Plex Mono"
      style = "Bold"

      [font.bold_italic]
      family = "IBM Plex Mono"
      style = "Bold Italic"

      [font.italic]
      family = "IBM Plex Mono"
      style = "Italic"

      [font.normal]
      family = "IBM Plex Mono"

      [mouse]
      hide_when_typing = false

      [scrolling]
      history = 10000

      [window]
      decorations = "full"
      dynamic_padding = true
      dynamic_title = true
      opacity = 1.0 

      [window.dimensions]
      columns = 132
      lines = 43
    '';
    ".config/alacritty/alacritty-transparent.yml".text = ''
      ---
      env:
      #    WINIT_X11_SCALE_FACTOR: "1.5"
          TERM: xterm-256color
      window:
        dimensions:
          columns: 132
          lines: 43
        dynamic_padding: true
        dynamic_title: true
        decorations: full
        opacity: 0.9
      scrolling:
        history: 10000
      # Scrolling distance multiplier.
      #  multiplier: 3
      cursor:
        style:
          shape: Block
          blinking: Always
      # Font configuration
      font:
        # Normal (roman) font face
        normal:
          family: IBM Plex Mono
        # Bold font face
        bold:
          family: IBM Plex Mono
          style: Bold
        # Italic font face
        italic:
          family: IBM Plex Mono
          style: Italic
        # Bold italic font face
        bold_italic:
          family: IBM Plex Mono
          style: Bold Italic
        # Point size
        size: 11
      mouse:
        hide_when_typing: false
      colors:
        transparent_background_colors: true
        # If `true`, bold text is drawn using the bright color variants.
        draw_bold_text_with_bright_colors: true
      # Import color scheme
      import:
        - ~/.config/alacritty/colorscheme.yml
    '';
    ".config/alacritty/alacritty-opaque.yml".text = ''
      ---
      env:
      #    WINIT_X11_SCALE_FACTOR: "1.5"
          TERM: xterm-256color
      window:
        dimensions:
          columns: 132
          lines: 43
        dynamic_padding: true
        dynamic_title: true
        decorations: full
        opacity: 1.0
      scrolling:
        history: 10000
      # Scrolling distance multiplier.
      #  multiplier: 3
      cursor:
        style:
          shape: Block
          blinking: Always
      # Font configuration
      font:
        # Normal (roman) font face
        normal:
          family: IBM Plex Mono
        # Bold font face
        bold:
          family: IBM Plex Mono
          style: Bold
        # Italic font face
        italic:
          family: IBM Plex Mono
          style: Italic
        # Bold italic font face
        bold_italic:
          family: IBM Plex Mono
          style: Bold Italic
        # Point size
        size: 11
      mouse:
        hide_when_typing: false
      colors:
        transparent_background_colors: true
        # If `true`, bold text is drawn using the bright color variants.
        draw_bold_text_with_bright_colors: true
      # Import color scheme
      import:
        - ~/.config/alacritty/colorscheme.yml
    '';
    ".config/alacritty/colorschemes.d/toml/afterglow.toml".text = ''
      # Default colors
      [colors.primary]
      background = '#2c2c2c'
      foreground = '#d6d6d6'

      dim_foreground    = '#dbdbdb'
      bright_foreground = '#d9d9d9'

      # Cursor colors
      [colors.cursor]
      text   = '#2c2c2c'
      cursor = '#d9d9d9'

      # Normal colors
      [colors.normal]
      black   = '#1c1c1c'
      red     = '#bc5653'
      green   = '#909d63'
      yellow  = '#ebc17a'
      blue    = '#7eaac7'
      magenta = '#aa6292'
      cyan    = '#86d3ce'
      white   = '#cacaca'

      # Bright colors
      [colors.bright]
      black   = '#636363'
      red     = '#bc5653'
      green   = '#909d63'
      yellow  = '#ebc17a'
      blue    = '#7eaac7'
      magenta = '#aa6292'
      cyan    = '#86d3ce'
      white   = '#f7f7f7'

      # Dim colors
      [colors.dim]
      black   = '#232323'
      red     = '#74423f'
      green   = '#5e6547'
      yellow  = '#8b7653'
      blue    = '#556b79'
      magenta = '#6e4962'
      cyan    = '#5c8482'
      white   = '#828282'
    '';
    ".config/alacritty/colorschemes.d/yml/afterglow.yml".text = ''
    schemes:
      afterglow:  &afterglow
        # Default colors
        primary:
          background: '#2c2c2c'
          foreground: '#d6d6d6'
          dim_foreground:    '#dbdbdb'
          bright_foreground: '#d9d9d9'
          dim_background:    '#202020' # not sure
          bright_background: '#3a3a3a' # not sure
        # Cursor colors
        cursor:
          text:   '#2c2c2c'
          cursor: '#d9d9d9'
        # Normal colors
        normal:
          black:   '#1c1c1c'
          red:     '#bc5653'
          green:   '#909d63'
          yellow:  '#ebc17a'
          blue:    '#7eaac7'
          magenta: '#aa6292'
          cyan:    '#86d3ce'
          white:   '#cacaca'
        # Bright colors
        bright:
          black:   '#636363'
          red:     '#bc5653'
          green:   '#909d63'
          yellow:  '#ebc17a'
          blue:    '#7eaac7'
          magenta: '#aa6292'
          cyan:    '#86d3ce'
          white:   '#f7f7f7'
        # Dim colors
        dim:
          black:   '#232323'
          red:     '#74423f'
          green:   '#5e6547'
          yellow:  '#8b7653'
          blue:    '#556b79'
          magenta: '#6e4962'
          cyan:    '#5c8482'
          white:   '#828282'
    colors:  *afterglow
    '';
    ".config/alacritty/colorschemes.d/toml/alabaster-dark.toml".text = ''
      # Colors (Alabaster Dark)
      # author tonsky

      [colors.primary]
      background = '#0E1415'
      foreground = '#CECECE'

      [colors.cursor]
      text = '#0E1415'
      cursor = '#CECECE'

      [colors.normal]
      black = '#0E1415'
      red = '#e25d56'
      green = '#73ca50'
      yellow = '#e9bf57'
      blue = '#4a88e4'
      magenta = '#915caf'
      cyan = '#23acdd'
      white = '#f0f0f0'

      [colors.bright]
      black = '#777777'
      red = '#f36868'
      green = '#88db3f'
      yellow = '#f0bf7a'
      blue = '#6f8fdb'
      magenta = '#e987e9'
      cyan = '#4ac9e2'
      white = '#FFFFFF'
    '';
    ".config/alacritty/colorschemes.d/toml/alabaster.toml".text = ''
      # Colors (Alabaster)
      # author tonsky

      [colors.primary]
      background = '#F7F7F7'
      foreground = '#434343'

      [colors.cursor]
      text = '#F7F7F7'
      cursor = '#434343'

      [colors.normal]
      black = '#000000'
      red = '#AA3731'
      green = '#448C27'
      yellow = '#CB9000'
      blue = '#325CC0'
      magenta = '#7A3E9D'
      cyan = '#0083B2'
      white = '#BBBBBB'

      [colors.bright]
      black = '#777777'
      red = '#F05050'
      green = '#60CB00'
      yellow = '#FFBC5D'
      blue = '#007ACC'
      magenta = '#E64CE6'
      cyan = '#00AACB'
      white = '#FFFFFF'
    '';
    ".config/alacritty/colorschemes.d/toml/alacritty_0_12.toml".text = ''
      # Alacritty's default color scheme pre-0.13 (based on tomorrow-night)
      # https://github.com/alacritty/alacritty/blob/v0.12.3/alacritty/src/config/color.rs

      [colors.primary]
      foreground = "#c5c8c6"
      background = "#1d1f21"

      [colors.normal]
      black = "#1d1f21"
      red = "#cc6666"
      green = "#b5bd68"
      yellow = "#f0c674"
      blue = "#81a2be"
      magenta = "#b294bb"
      cyan = "#8abeb7"
      white = "#c5c8c6"

      [colors.bright]
      black = "#666666"
      red = "#d54e53"
      green = "#b9ca4a"
      yellow = "#e7c547"
      blue = "#7aa6da"
      magenta = "#c397d8"
      cyan = "#70c0b1"
      white = "#eaeaea"

      [colors.dim]
      black = "#131415"
      red = "#864343"
      green = "#777c44"
      yellow = "#9e824c"
      blue = "#556a7d"
      magenta = "#75617b"
      cyan = "#5b7d78"
      white = "#828482"

      [colors.hints]
      start = { foreground = "#1d1f21", background = "#e9ff5e" }
      end = { foreground = "#e9ff5e", background = "#1d1f21" }

      [colors.search]
      matches = { foreground = "#000000", background = "#ffffff" }
      focused_match = { foreground = "#ffffff", background = "#000000" }
    '';
    ".config/alacritty/colorschemes.d/toml/blood-moon.toml".text = ''
      # Colors (Blood Moon)

      # Default colors
      [colors.primary]
      background = '#10100E'
      foreground = '#C6C6C4'

      # Normal colors
      [colors.normal]
      black   = '#10100E'
      red     = '#C40233'
      green   = '#009F6B'
      yellow  = '#FFD700'
      blue    = '#0087BD'
      magenta = '#9A4EAE'
      cyan    = '#20B2AA'
      white   = '#C6C6C4'

      # Bright colors
      [colors.bright]
      black   = '#696969'
      red     = '#FF2400'
      green   = '#03C03C'
      yellow  = '#FDFF00'
      blue    = '#007FFF'
      magenta = '#FF1493'
      cyan    = '#00CCCC'
      white   = '#FFFAFA'
    '';
    ".config/alacritty/colorschemes.d/yml/blood-moon.yml".text = ''
      schemes:
        bloodmoon:  &bloodmoon
          # Default colors
          primary:
            background: '#10100E'
            foreground: '#C6C6C4'
          # Normal colors
          normal:
            black:   '#10100E'
            red:     '#C40233'
            green:   '#009F6B'
            yellow:  '#FFD700'
            blue:    '#0087BD'
            magenta: '#9A4EAE'
            cyan:    '#20B2AA'
            white:   '#C6C6C4'
          # Bright colors
          bright:
            black:   '#696969'
            red:     '#FF2400'
            green:   '#03C03C'
            yellow:  '#FDFF00'
            blue:    '#007FFF'
            magenta: '#FF1493'
            cyan:    '#00CCCC'
            white:   '#FFFAFA'
      colors:  *bloodmoon
    '';
    ".config/alacritty/colorschemes.d/toml/bluish.toml".text = ''
      # Default colors
      [colors.primary]
      background = '#2c3640'
      foreground = '#297dd3'

      # Normal colors
      [colors.normal]
      black   = '#0b0b0c'
      red     = '#377fc4'
      green   = '#2691e7'
      yellow  = '#2090c1'
      blue    = '#2c5e87'
      magenta = '#436280'
      cyan    = '#547aa2'
      white   = '#536679'

      # Bright colors
      [colors.bright]
      black   = '#23272c'
      red     = '#66a5cc'
      green   = '#59b0f2'
      yellow  = '#4bb0d3'
      blue    = '#487092'
      magenta = '#50829e'
      cyan    = '#658795'
      white   = '#4d676b'
    '';
    ".config/alacritty/colorschemes.d/toml/argonaut.toml".text = ''
      # Default colors
      [colors.primary]
      background = '#292C3E'
      foreground = '#EBEBEB'

      # Cursor colors
      [colors.cursor]
      text = '#EBEBEB'
      cursor = '#FF261E'

      # Normal colors
      [colors.normal]
      black   = '#0d0d0d'
      red     = '#FF301B'
      green   = '#A0E521'
      yellow  = '#FFC620'
      blue    = '#1BA6FA'
      magenta = '#8763B8'
      cyan    = '#21DEEF'
      white   = '#EBEBEB'

      # Bright colors
      [colors.bright]
      black   = '#6D7070'
      red     = '#FF4352'
      green   = '#B8E466'
      yellow  = '#FFD750'
      blue    = '#1BA6FA'
      magenta = '#A578EA'
      cyan    = '#73FBF1'
      white   = '#FEFEF8'
    '';
    ".config/alacritty/colorschemes.d/yml/argonaut.yml".text = ''
    schemes:
      argonaut:  &argonaut
        # Default colors
        primary:
          background: '#292C3E'
          foreground: '#EBEBEB'
        # Cursor colors
        cursor:
          text: '#FF261E'
          cursor: '#FF261E'
        # Normal colors
        normal:
          black:   '#0d0d0d'
          red:     '#FF301B'
          green:   '#A0E521'
          yellow:  '#FFC620'
          blue:    '#1BA6FA'
          magenta: '#8763B8'
          cyan:    '#21DEEF'
          white:   '#EBEBEB'
        # Bright colors
        bright:
          black:   '#6D7070'
          red:     '#FF4352'
          green:   '#B8E466'
          yellow:  '#FFD750'
          blue:    '#1BA6FA'
          magenta: '#A578EA'
          cyan:    '#73FBF1'
          white:   '#FEFEF8'
    colors:  *argonaut
    '';
    ".config/alacritty/colorschemes.d/toml/ashes-dark.toml".text = ''
      [colors.primary]
      background = '#1c2023'
      foreground = '#c7ccd1'

      [colors.cursor]
      text = '#1c2023'
      cursor = '#c7ccd1'

      [colors.normal]
      black   = '#1c2023'
      red     = '#c7ae95'
      green   = '#95c7ae'
      yellow  = '#aec795'
      blue    = '#ae95c7'
      magenta = '#c795ae'
      cyan    = '#95aec7'
      white   = '#c7ccd1'

      [colors.bright]
      black   = '#747c84'
      red     = '#c7ae95'
      green   = '#95c7ae'
      yellow  = '#aec795'
      blue    = '#ae95c7'
      magenta = '#c795ae'
      cyan    = '#95aec7'
      white   = '#f3f4f5'
    '';
    ".config/alacritty/colorschemes.d/toml/ashes-light.toml".text = ''
      [colors.primary]
      background = '#f3f4f5'
      foreground = '#565e65'

      [colors.cursor]
      text = '#f3f4f5'
      cursor = '#565e65'

      [colors.normal]
      black   = '#1c2023'
      red     = '#c7ae95'
      green   = '#95c7ae'
      yellow  = '#aec795'
      blue    = '#ae95c7'
      magenta = '#c795ae'
      cyan    = '#95aec7'
      white   = '#c7ccd1'

      [colors.bright]
      black   = '#747c84'
      red     = '#c7ae95'
      green   = '#95c7ae'
      yellow  = '#aec795'
      blue    = '#ae95c7'
      magenta = '#c795ae'
      cyan    = '#95aec7'
      white   = '#f3f4f5'
    '';
    ".config/alacritty/colorschemes.d/toml/atom-one-light.toml".text = ''
      [colors.primary]
      background = '#f8f8f8'
      foreground = '#2a2b33'

      [colors.normal]
      black   = '#000000'
      red     = '#de3d35'
      green   = '#3e953a'
      yellow  = '#d2b67b'
      blue    = '#2f5af3'
      magenta = '#a00095'
      cyan    = '#3e953a'
      white   = '#bbbbbb'

      [colors.bright]
      black   = '#000000'
      red     = '#de3d35'
      green   = '#3e953a'
      yellow  = '#d2b67b'
      blue    = '#2f5af3'
      magenta = '#a00095'
      cyan    = '#3e953a'
      white   = '#ffffff'
    '';
    ".config/alacritty/colorschemes.d/toml/ayu-dark.toml".text = ''
      # Colors (Ayu Dark)

      # Default colors
      [colors.primary]
      background = '#0A0E14'
      foreground = '#B3B1AD'

      # Normal colors
      [colors.normal]
      black   = '#01060E'
      red     = '#EA6C73'
      green   = '#91B362'
      yellow  = '#F9AF4F'
      blue    = '#53BDFA'
      magenta = '#FAE994'
      cyan    = '#90E1C6'
      white   = '#C7C7C7'

      # Bright colors
      [colors.bright]
      black   = '#686868'
      red     = '#F07178'
      green   = '#C2D94C'
      yellow  = '#FFB454'
      blue    = '#59C2FF'
      magenta = '#FFEE99'
      cyan    = '#95E6CB'
      white   = '#FFFFFF'
    '';
    ".config/alacritty/colorschemes.d/toml/ayu-light.toml".text = ''
      # Colors (Ayu Light)

      # Default colors - taken from ayu-colors
      [colors.primary]
      background = '#FCFCFC'
      foreground = '#5C6166'

      # Normal colors - taken from ayu-iTerm
      [colors.normal]
      black   = '#010101'
      red     = '#e7666a'
      green   = '#80ab24'
      yellow  = '#eba54d'
      blue    = '#4196df'
      magenta = '#9870c3'
      cyan    = '#51b891'
      white   = '#c1c1c1'

      # Bright colors - pastel lighten 0.1 <normal> except black lighten with 0.2
      [colors.bright]
      black   = '#343434'
      red     = '#ee9295'
      green   = '#9fd32f'
      yellow  = '#f0bc7b'
      blue    = '#6daee6'
      magenta = '#b294d2'
      cyan    = '#75c7a8'
      white   = '#dbdbdb'
    '';
    ".config/alacritty/colorschemes.d/yml/ayu-dark.yml".text = ''
    schemes:
      ayu_dark:  &ayu_dark
        # Default colors
        primary:
          background: '#0A0E14'
          foreground: '#B3B1AD'
        # Normal colors
        normal:
          black: '#01060E'
          red: '#EA6C73'
          green: '#91B362'
          yellow: '#F9AF4F'
          blue: '#53BDFA'
          magenta: '#FAE994'
          cyan: '#90E1C6'
          white: '#C7C7C7'
        # Bright colors
        bright:
          black: '#686868'
          red: '#F07178'
          green: '#C2D94C'
          yellow: '#FFB454'
          blue: '#59C2FF'
          magenta: '#FFEE99'
          cyan: '#95E6CB'
          white: '#FFFFFF'
    colors:  *ayu_dark
    '';
    ".config/alacritty/colorschemes.d/yml/ayu-mirage.yml".text = ''
    schemes:
      ayu_mirage:  &ayu_mirage
        # Default colors
        primary:
          background: '#202734'
          foreground: '#CBCCC6'
        # Normal colors
        normal:
          black: '#191E2A'
          red: '#FF3333'
          green: '#BAE67E'
          yellow: '#FFA759'
          blue: '#73D0FF'
          magenta: '#FFD580'
          cyan: '#95E6CB'
          white: '#C7C7C7'
        # Bright colors
        bright:
          black: '#686868'
          red: '#F27983'
          green: '#A6CC70'
          yellow: '#FFCC66'
          blue: '#5CCFE6'
          magenta: '#FFEE99'
          cyan: '#95E6CB'
          white: '#FFFFFF'
    colors:  *ayu_mirage
    '';
    ".config/alacritty/colorschemes.d/toml/baitong.toml".text = ''
      # Colors (Baitong)

      [colors.primary]
      background = '#112a2a'
      foreground = '#33ff33'

      [colors.cursor]
      text = '#112a2a'
      cursor = '#ff00ff'

      [colors.vi_mode_cursor]
      text = '#112a2a'
      cursor = '#ff00ff'

      [colors.search]
      matches = { foreground = '#000000', background = '#1AE642' }
      focused_match = { foreground = '#000000', background = '#ff00ff' }

      [colorshints]
      start = { foreground = '#1d1f21', background = '#1AE642' }
      end = { foreground = '#1AE642', background = '#1d1f21' }

      [colors.line_indicator]
      foreground = '#33ff33'
      background = '#1d1f21'

      [colors.footer_bar]
      background = '#731d8b'
      foreground = '#ffffff'

      [colors.selection]
      text = '#112a2a'
      background = '#1AE642'

      # Normal colors
      [colors.normal]
      black   = '#000000'
      red     = '#f77272'
      green   = '#33ff33'
      yellow  = '#1AE642'
      blue    = '#68FDFE'
      magenta = '#ff66ff'
      cyan    = '#87CEFA'
      white   = '#dbdbd9'

      # Bright colors
      [colors.bright]
      black   = '#ffffff'
      red     = '#f77272'
      green   = '#33ff33'
      yellow  = '#1AE642'
      blue    = '#68FDFE'
      magenta = '#ff66ff'
      cyan    = '#68FDFE'
      white   = '#dbdbd9'
    '';
    ".config/alacritty/colorschemes.d/toml/base16-default-dark.toml".text = ''
      # Colors (Base16 Default Dark)

      # Default colors
      [colors.primary]
      background = '#181818'
      foreground = '#d8d8d8'

      [colors.cursor]
      text = '#181818'
      cursor = '#d8d8d8'

      # Normal colors
      [colors.normal]
      black   = '#181818'
      red     = '#ab4642'
      green   = '#a1b56c'
      yellow  = '#f7ca88'
      blue    = '#7cafc2'
      magenta = '#ba8baf'
      cyan    = '#86c1b9'
      white   = '#d8d8d8'

      # Bright colors
      [colors.bright]
      black   = '#585858'
      red     = '#ab4642'
      green   = '#a1b56c'
      yellow  = '#f7ca88'
      blue    = '#7cafc2'
      magenta = '#ba8baf'
      cyan    = '#86c1b9'
      white   = '#f8f8f8'
    '';
    ".config/alacritty/colorschemes.d/yml/base16-default-dark.yml".text = ''
    schemes:
      base16_default_dark:  &base16_default_dark
        # Default colors
        primary:
          background: '#181818'
          foreground: '#d8d8d8'
        # Colors the cursor will use if `custom_cursor_colors` is true
        cursor:
          text: '#d8d8d8'
          cursor: '#d8d8d8'
        # Normal colors
        normal:
          black:   '#181818'
          red:     '#ab4642'
          green:   '#a1b56c'
          yellow:  '#f7ca88'
          blue:    '#7cafc2'
          magenta: '#ba8baf'
          cyan:    '#86c1b9'
          white:   '#d8d8d8'
        # Bright colors
        bright:
          black:   '#585858'
          red:     '#ab4642'
          green:   '#a1b56c'
          yellow:  '#f7ca88'
          blue:    '#7cafc2'
          magenta: '#ba8baf'
          cyan:    '#86c1b9'
          white:   '#f8f8f8'
    colors:  *base16_default_dark
    '';
    ".config/alacritty/colorschemes.d/toml/breeze.toml".text = ''
      # KDE Breeze (Ported from Konsole)

      # Default colors
      [colors.primary]
      background = '#232627'
      foreground = '#fcfcfc'

      dim_foreground = '#eff0f1'
      bright_foreground = '#ffffff'

      # Normal colors
      [colors.normal]
      black = '#232627'
      red = '#ed1515'
      green = '#11d116'
      yellow = '#f67400'
      blue = '#1d99f3'
      magenta = '#9b59b6'
      cyan = '#1abc9c'
      white = '#fcfcfc'

      # Bright colors
      [colors.bright]
      black = '#7f8c8d'
      red = '#c0392b'
      green = '#1cdc9a'
      yellow = '#fdbc4b'
      blue = '#3daee9'
      magenta = '#8e44ad'
      cyan = '#16a085'
      white = '#ffffff'

      # Dim colors
      [colors.dim]
      black = '#31363b'
      red = '#783228'
      green = '#17a262'
      yellow = '#b65619'
      blue = '#1b668f'
      magenta = '#614a73'
      cyan = '#186c60'
      white = '#63686d'
    '';
    ".config/alacritty/colorschemes.d/yml/breeze.yml".text = ''
    schemes:
      breeze:  &breeze
        # Default colors
        primary:
          background: '#232627'
          foreground: '#fcfcfc'
          dim_foreground: '#eff0f1'
          bright_foreground: '#ffffff'
          dim_background: '#31363b'
          bright_background: '#000000'
        # Normal colors
        normal:
          black: '#232627'
          red: '#ed1515'
          green: '#11d116'
          yellow: '#f67400'
          blue: '#1d99f3'
          magenta: '#9b59b6'
          cyan: '#1abc9c'
          white: '#fcfcfc'
        # Bright colors
        bright:
          black: '#7f8c8d'
          red: '#c0392b'
          green: '#1cdc9a'
          yellow: '#fdbc4b'
          blue: '#3daee9'
          magenta: '#8e44ad'
          cyan: '#16a085'
          white: '#ffffff'
        # Dim colors
        dim:
          black: '#31363b'
          red: '#783228'
          green: '#17a262'
          yellow: '#b65619'
          blue: '#1b668f'
          magenta: '#614a73'
          cyan: '#186c60'
          white: '#63686d'
    colors:  *breeze
    '';
    ".config/alacritty/colorschemes.d/toml/campbell.toml".text = ''
      # Campbell (Windows 10 default)

      # Default colors
      [colors.primary]
      background = '#0c0c0c'
      foreground = '#cccccc'

      # Normal colors
      [colors.normal]
      black      = '#0c0c0c'
      red        = '#c50f1f'
      green      = '#13a10e'
      yellow     = '#c19c00'
      blue       = '#0037da'
      magenta    = '#881798'
      cyan       = '#3a96dd'
      white      = '#cccccc'

      # Bright colors
      [colors.bright]
      black      = '#767676'
      red        = '#e74856'
      green      = '#16c60c'
      yellow     = '#f9f1a5'
      blue       = '#3b78ff'
      magenta    = '#b4009e'
      cyan       = '#61d6d6'
      white      = '#f2f2f2'
    '';
    ".config/alacritty/colorschemes.d/yml/campbell.yml".text = ''
    schemes:
      campbell:  &campbell
        # Default colors
        primary:
          background: '#0c0c0c'
          foreground: '#cccccc'
        # Normal colors
        normal:
          black:      '#0c0c0c'
          red:        '#c50f1f'
          green:      '#13a10e'
          yellow:     '#c19c00'
          blue:       '#0037da'
          magenta:    '#881798'
          cyan:       '#3a96dd'
          white:      '#cccccc'
        # Bright colors
        bright:
          black:      '#767676'
          red:        '#e74856'
          green:      '#16c60c'
          yellow:     '#f9f1a5'
          blue:       '#3b78ff'
          magenta:    '#b4009e'
          cyan:       '#61d6d6'
          white:      '#f2f2f2'
    colors:  *campbell
    '';
    ".config/alacritty/colorschemes.d/toml/carbonfox.toml".text = ''
      # Default colors
      [colors.primary]
      background = '#161616'
      foreground = '#f2f4f8'

      # Normal colors
      [colors.normal]
      black   = '#282828'
      red     = '#ee5396'
      green   = '#25be6a'
      yellow  = '#08bdba'
      blue    = '#78a9ff'
      magenta = '#be95ff'
      cyan    = '#33b1ff'
      white   = '#dfdfe0'

      # Bright colors
      [colors.bright]
      black   = '#484848'
      red     = '#f16da6'
      green   = '#46c880'
      yellow  = '#2dc7c4'
      blue    = '#8cb6ff'
      magenta = '#c8a5ff'
      cyan    = '#52bdff'
      white   = '#e4e4e5'
    '';
    ".config/alacritty/colorschemes.d/toml/catppuccin-frappe.toml".text = ''
      # Default colors
      [colors.primary]
      background = '#303446' # base
      foreground = '#C6D0F5' # text
      # Bright and dim foreground colors
      dim_foreground = '#C6D0F5' # text
      bright_foreground = '#C6D0F5' # text

      # Cursor colors
      [colors.cursor]
      text = '#303446' # base
      cursor = '#F2D5CF' # rosewater

      [colors.vi_mode_cursor]
      text = '#303446' # base
      cursor = '#BABBF1' # lavender

      # Search colors
      [colors.search.matches]
      foreground = '#303446' # base
      background = '#A5ADCE' # subtext0
      [colors.search.focused_match]
      foreground = '#303446' # base
      background = '#A6D189' # green
      [colors.footer_bar]
      foreground = '#303446' # base
      background = '#A5ADCE' # subtext0

      # Keyboard regex hints
      [colors.hints.start]
      foreground = '#303446' # base
      background = '#E5C890' # yellow
      [colors.hints.end]
      foreground = '#303446' # base
      background = '#A5ADCE' # subtext0

      # Selection colors
      [colors.selection]
      text = '#303446' # base
      background = '#F2D5CF' # rosewater

      # Normal colors
      [colors.normal]
      black = '#51576D' # surface1
      red = '#E78284' # red
      green = '#A6D189' # green
      yellow = '#E5C890' # yellow
      blue = '#8CAAEE' # blue
      magenta = '#F4B8E4' # pink
      cyan = '#81C8BE' # teal
      white = '#B5BFE2' # subtext1

      # Bright colors
      [colors.bright]
      black = '#626880' # surface2
      red = '#E78284' # red
      green = '#A6D189' # green
      yellow = '#E5C890' # yellow
      blue = '#8CAAEE' # blue
      magenta = '#F4B8E4' # pink
      cyan = '#81C8BE' # teal
      white = '#A5ADCE' # subtext0

      # Dim colors
      [colors.dim]
      black = '#51576D' # surface1
      red = '#E78284' # red
      green = '#A6D189' # green
      yellow = '#E5C890' # yellow
      blue = '#8CAAEE' # blue
      magenta = '#F4B8E4' # pink
      cyan = '#81C8BE' # teal
      white = '#B5BFE2' # subtext1
    '';
    ".config/alacritty/colorschemes.d/toml/catppuccin-latte.toml".text = ''
      # Default colors
      [colors.primary]
      background = '#EFF1F5' # base
      foreground = '#4C4F69' # text
      # Bright and dim foreground colors
      dim_foreground = '#4C4F69' # text
      bright_foreground = '#4C4F69' # text

      # Cursor colors
      [colors.cursor]
      text = '#EFF1F5' # base
      cursor = '#DC8A78' # rosewater

      [colors.vi_mode_cursor]
      text = '#EFF1F5' # base
      cursor = '#7287FD' # lavender

      # Search colors
      [colors.search.matches]
      foreground = '#EFF1F5' # base
      background = '#6C6F85' # subtext0

      [colors.search.focused_match]
      foreground = '#EFF1F5' # base
      background = '#40A02B' # green

      [colors.footer_bar]
      foreground = '#EFF1F5' # base
      background = '#6C6F85' # subtext0

      # Keyboard regex hints
      [colors.hints.start]
      foreground = '#EFF1F5' # base
      background = '#DF8E1D' # yellow

      [colors.hints.end]
      foreground = '#EFF1F5' # base
      background = '#6C6F85' # subtext0

      # Selection colors
      [colors.selection]
      text = '#EFF1F5' # base
      background = '#DC8A78' # rosewater

      # Normal colors
      [colors.normal]
      black = '#5C5F77' # subtext1
      red = '#D20F39' # red
      green = '#40A02B' # green
      yellow = '#DF8E1D' # yellow
      blue = '#1E66F5' # blue
      magenta = '#EA76CB' # pink
      cyan = '#179299' # teal
      white = '#ACB0BE' # surface2

      # Bright colors
      [colors.bright]
      black = '#6C6F85' # subtext0
      red = '#D20F39' # red
      green = '#40A02B' # green
      yellow = '#DF8E1D' # yellow
      blue = '#1E66F5' # blue
      magenta = '#EA76CB' # pink
      cyan = '#179299' # teal
      white = '#BCC0CC' # surface1

      # Dim colors
      [colors.dim]
      black = '#5C5F77' # subtext1
      red = '#D20F39' # red
      green = '#40A02B' # green
      yellow = '#DF8E1D' # yellow
      blue = '#1E66F5' # blue
      magenta = '#EA76CB' # pink
      cyan = '#179299' # teal
      white = '#ACB0BE' # surface2
    '';
    ".config/alacritty/colorschemes.d/toml/catppuccin-macchiato.toml".text = ''
      # Default colors
      [colors.primary]
      background = '#24273A' # base
      foreground = '#CAD3F5' # text
      # Bright and dim foreground colors
      dim_foreground = '#CAD3F5' # text
      bright_foreground = '#CAD3F5' # text

      # Cursor colors
      [colors.cursor]
      text = '#24273A' # base
      cursor = '#F4DBD6' # rosewater

      [colors.vi_mode_cursor]
      text = '#24273A' # base
      cursor = '#B7BDF8' # lavender

      # Search colors
      [colors.search.matches]
      foreground = '#24273A' # base
      background = '#A5ADCB' # subtext0

      [colors.search.focused_match]
      foreground = '#24273A' # base
      background = '#A6DA95' # green

      [colors.footer_bar]
      foreground = '#24273A' # base
      background = '#A5ADCB' # subtext0

      # Keyboard regex hints
      [colors.hints.start]
      foreground = '#24273A' # base
      background = '#EED49F' # yellow

      [colors.hints.end]
      foreground = '#24273A' # base
      background = '#A5ADCB' # subtext0

      # Selection colors
      [colors.selection]
      text = '#24273A' # base
      background = '#F4DBD6' # rosewater

      # Normal colors
      [colors.normal]
      black = '#494D64' # surface1
      red = '#ED8796' # red
      green = '#A6DA95' # green
      yellow = '#EED49F' # yellow
      blue = '#8AADF4' # blue
      magenta = '#F5BDE6' # pink
      cyan = '#8BD5CA' # teal
      white = '#B8C0E0' # subtext1

      # Bright colors
      [colors.bright]
      black = '#5B6078' # surface2
      red = '#ED8796' # red
      green = '#A6DA95' # green
      yellow = '#EED49F' # yellow
      blue = '#8AADF4' # blue
      magenta = '#F5BDE6' # pink
      cyan = '#8BD5CA' # teal
      white = '#A5ADCB' # subtext0

      # Dim colors
      [colors.dim]
      black = '#494D64' # surface1
      red = '#ED8796' # red
      green = '#A6DA95' # green
      yellow = '#EED49F' # yellow
      blue = '#8AADF4' # blue
      magenta = '#F5BDE6' # pink
      cyan = '#8BD5CA' # teal
      white = '#B8C0E0' # subtext1
    '';
    ".config/alacritty/colorschemes.d/toml/catppuccin-mocha.toml".text = ''
      [colors.primary]
      background = '#1E1E2E' # base
      foreground = '#CDD6F4' # text
      # Bright and dim foreground colors
      dim_foreground = '#CDD6F4' # text
      bright_foreground = '#CDD6F4' # text

      # Cursor colors
      [colors.cursor]
      text = '#1E1E2E' # base
      cursor = '#F5E0DC' # rosewater

      [colors.vi_mode_cursor]
      text = '#1E1E2E' # base
      cursor = '#B4BEFE' # lavender

      # Search colors
      [colors.search.matches]
      foreground = '#1E1E2E' # base
      background = '#A6ADC8' # subtext0

      [colors.search.focused_match]
      foreground = '#1E1E2E' # base
      background = '#A6E3A1' # green

      [colors.footer_bar]
      foreground = '#1E1E2E' # base
      background = '#A6ADC8' # subtext0

      # Keyboard regex hints
      [colors.hints.start]
      foreground = '#1E1E2E' # base
      background = '#F9E2AF' # yellow

      [colors.hints.end]
      foreground = '#1E1E2E' # base
      background = '#A6ADC8' # subtext0

      # Selection colors
      [colors.selection]
      text = '#1E1E2E' # base
      background = '#F5E0DC' # rosewater

      # Normal colors
      [colors.normal]
      black = '#45475A' # surface1
      red = '#F38BA8' # red
      green = '#A6E3A1' # green
      yellow = '#F9E2AF' # yellow
      blue = '#89B4FA' # blue
      magenta = '#F5C2E7' # pink
      cyan = '#94E2D5' # teal
      white = '#BAC2DE' # subtext1

      # Bright colors
      [colors.bright]
      black = '#585B70' # surface2
      red = '#F38BA8' # red
      green = '#A6E3A1' # green
      yellow = '#F9E2AF' # yellow
      blue = '#89B4FA' # blue
      magenta = '#F5C2E7' # pink
      cyan = '#94E2D5' # teal
      white = '#A6ADC8' # subtext0

      # Dim colors
      [colors.dim]
      black = '#45475A' # surface1
      red = '#F38BA8' # red
      green = '#A6E3A1' # green
      yellow = '#F9E2AF' # yellow
      blue = '#89B4FA' # blue
      magenta = '#F5C2E7' # pink
      cyan = '#94E2D5' # teal
      white = '#BAC2DE' # subtext1
    '';
    ".config/alacritty/colorschemes.d/toml/catppuccin.toml".text = ''
      # Catppuccino theme scheme for Alacritty

      [colors.primary]
      background = '#1E1E2E'
      foreground = '#D6D6D6'

      [colors.cursor]
      text = '#1E1E2E'
      cursor = '#D9D9D9'

      [colors.normal]
      black = '#181A1F'
      red = '#E86671'
      green = '#98C379'
      yellow = '#E5C07B'
      blue = '#61AFEF'
      magenta = '#C678DD'
      cyan = '#54AFBC'
      white = '#ABB2BF'

      [colors.bright]
      black = '#5C6370'
      red = '#E86671'
      green = '#98C379'
      yellow = '#E5C07B'
      blue = '#61AFEF'
      magenta = '#C678DD'
      cyan = '#54AFBC'
      white = '#F7F7F7'

      [colors.dim]
      black = '#5C6370'
      red = '#74423F'
      green = '#98C379'
      yellow = '#E5C07B'
      blue = '#61AFEF'
      magenta = '#6E4962'
      cyan = '#5C8482'
      white = '#828282'
    '';
    ".config/alacritty/colorschemes.d/toml/challenger-deep.toml".text = ''
      # Colors (Challenger Deep)

      # Default colors
      [colors.primary]
      background = '#1e1c31'
      foreground = '#cbe1e7'

      [colors.cursor]
      text = '#ff271d'
      cursor = '#fbfcfc'

      # Normal colors
      [colors.normal]
      black   = '#141228'
      red     = '#ff5458'
      green   = '#62d196'
      yellow  = '#ffb378'
      blue    = '#65b2ff'
      magenta = '#906cff'
      cyan    = '#63f2f1'
      white   = '#a6b3cc'

      # Bright colors
      [colors.bright]
      black   = '#565575'
      red     = '#ff8080'
      green   = '#95ffa4'
      yellow  = '#ffe9aa'
      blue    = '#91ddff'
      magenta = '#c991e1'
      cyan    = '#aaffe4'
      white   = '#cbe3e7'
    '';
    ".config/alacritty/colorschemes.d/toml/citylights.toml".text = ''
      # Default colors
      [colors.primary]
      background = '#171d23'
      foreground = '#ffffff'

      # Cursor colors
      [colors.cursor]
      text   = '#fafafa'
      cursor = '#008b94'

      # Normal colors
      [colors.normal]
      black   = '#333f4a'
      red     = '#d95468'
      green   = '#8bd49c'
      blue    = '#539afc'
      magenta = '#b62d65'
      cyan    = '#70e1e8'
      white   = '#b7c5d3'

      # Bright colors
      [colors.bright]
      black   = '#41505e'
      red     = '#d95468'
      green   = '#8bd49c'
      yellow  = '#ebbf83'
      blue    = '#5ec4ff'
      magenta = '#e27e8d'
      cyan    = '#70e1e8'
      white   = '#ffffff'
    '';
    ".config/alacritty/colorschemes.d/toml/Cobalt2.toml".text = ''
      # From the famous Cobalt2 sublime theme
      # Source  https//github.com/wesbos/cobalt2/tree/master/Cobalt2

      # Default colors
      [colors.primary]
      background = '#122637'
      foreground = '#ffffff'

      [colors.cursor]
      text = '#122637'
      cursor = '#f0cb09'

      # Normal colors
      [colors.normal]
      black   = '#000000'
      red     = '#ff0000'
      green   = '#37dd21'
      yellow  = '#fee409'
      blue    = '#1460d2'
      magenta = '#ff005d'
      cyan    = '#00bbbb'
      white   = '#bbbbbb'

      # Bright colors
      [colors.bright]
      black   = '#545454'
      red     = '#f40d17'
      green   = '#3bcf1d'
      yellow  = '#ecc809'
      blue    = '#5555ff'
      magenta = '#ff55ff'
      cyan    = '#6ae3f9'
      white   = '#ffffff'
    '';
    ".config/alacritty/colorschemes.d/yml/cobalt2.yml".text = ''
    schemes:
      cobalt2:  &cobalt2
        cursor:
          text: '#fefff2'
          cursor: '#f0cc09'
        selection:
          text: '#b5b5b5'
          background: '#18354f'
        # Default colors
        primary:
          background: '#132738'
          foreground: '#ffffff'
        # Normal colors
        normal:
          black:   '#000000'
          red:     '#ff0000'
          green:   '#38de21'
          yellow:  '#ffe50a'
          blue:    '#1460d2'
          magenta: '#ff005d'
          cyan:    '#00bbbb'
          white:   '#bbbbbb'
        # Bright colors
        bright:
          black:   '#555555'
          red:     '#f40e17'
          green:   '#3bd01d'
          yellow:  '#edc809'
          blue:    '#5555ff'
          magenta: '#ff55ff'
          cyan:    '#6ae3fa'
          white:   '#ffffff'
    colors:  *cobalt2
    '';
    ".config/alacritty/colorschemes.d/toml/cyberpunk-neon.toml".text = ''
      # Cyber Punk Neon
      # Source https//github.com/Roboron3042/Cyberpunk-Neon

      # Default colors
      [colors.primary]
      background = '#000b1e'
      foreground = '#0abdc6'

      [colors.cursor]
      text   = '#000b1e'
      cursor = '#0abdc6'

      # Normal colors
      [colors.normal]
      black   = '#123e7c'
      red     = '#ff0000'
      green   = '#d300c4'
      yellow  = '#f57800'
      blue    = '#123e7c'
      magenta = '#711c91'
      cyan    = '#0abdc6'
      white   = '#d7d7d5'

      # Bright colors
      [colors.bright]
      black   = '#1c61c2'
      red     = '#ff0000'
      green   = '#d300c4'
      yellow  = '#f57800'
      blue    = '#00ff00'
      magenta = '#711c91'
      cyan    = '#0abdc6'
      white   = '#d7d7d5'
    '';
    ".config/alacritty/colorschemes.d/toml/darcula.toml".text = ''
      # Colors (Darcula)

      # Default colors
      [colors.primary]
      background = '#282a36'
      foreground = '#f8f8f2'

      # Normal colors
      [colors.normal]
      black   = '#000000'
      red     = '#ff5555'
      green   = '#50fa7b'
      yellow  = '#f1fa8c'
      blue    = '#caa9fa'
      magenta = '#ff79c6'
      cyan    = '#8be9fd'
      white   = '#bfbfbf'

      # Bright colors
      [colors.bright]
      black   = '#282a35'
      red     = '#ff6e67'
      green   = '#5af78e'
      yellow  = '#f4f99d'
      blue    = '#caa9fa'
      magenta = '#ff92d0'
      cyan    = '#9aedfe'
      white   = '#e6e6e6'
    '';
    ".config/alacritty/colorschemes.d/toml/dark-pastels.toml".text = ''
      # Colors (Konsole's Dark Pastels)

      # Default colors
      [colors.primary]
      background = '#2C2C2C'
      foreground = '#DCDCCC'

      # Normal colors
      [colors.normal]
      black   = '#3F3F3F'
      red     = '#705050'
      green   = '#60B48A'
      yellow  = '#DFAF8F'
      blue    = '#9AB8D7'
      magenta = '#DC8CC3'
      cyan    = '#8CD0D3'
      white   = '#DCDCCC'

      # Bright colors
      [colors.bright]
      black   = '#709080'
      red     = '#DCA3A3'
      green   = '#72D5A3'
      yellow  = '#F0DFAF'
      blue    = '#94BFF3'
      magenta = '#EC93D3'
      cyan    = '#93E0E3'
      white   = '#FFFFFF'
    '';
    ".config/alacritty/colorschemes.d/yml/darkside.yml".text = ''
    schemes:
      darkside:  &darkside
        # Default colors
        primary:
          background: '#222324'
          foreground: '#BABABA'
        # Normal colors
        normal:
          black:    '#000000'
          red:      '#E8341C'
          green:    '#68C256'
          yellow:   '#F2D42C'
          blue:     '#1C98E8'
          magenta:  '#8E69C9'
          cyan:     '#1C98E8'
          white:    '#BABABA'
        # Bright colors
        bright:
          black:    '#666666'
          red:      '#E05A4F'
          green:    '#77B869'
          yellow:   '#EFD64B'
          blue:     '#387CD3'
          magenta:  '#957BBE'
          cyan:     '#3D97E2'
          white:    '#BABABA'
    colors:  *darkside
    '';
    ".config/alacritty/colorschemes.d/yml/darktooth.yml".text = ''
    schemes:
      darktooth:  &darktooth
        # Default colors
        primary:
          background: '#282828'
          foreground: '#fdf4c1'
        # Normal colors
        normal:
          black:   '#282828'
          red:     '#9d0006'
          green:   '#79740e'
          yellow:  '#b57614'
          blue:    '#076678'
          magenta: '#8f3f71'
          cyan:    '#00a7af'
          white:   '#fdf4c1'
        # Bright colors
        bright:
          black:   '#32302f'
          red:     '#fb4933'
          green:   '#b8bb26'
          yellow:  '#fabd2f'
          blue:    '#83a598'
          magenta: '#d3869b'
          cyan:    '#3fd7e5'
          white:   '#ffffc8'
        # Dim colors (Optional)
        dim:
          black:   '#1d2021'
          red:     '#421e1e'
          green:   '#232b0f'
          yellow:  '#4d3b27'
          blue:    '#2b3c44'
          magenta: '#4e3d45'
          cyan:    '#205161'
          white:   '#f4e8ba'
    colors:  *darktooth
    '';
    ".config/alacritty/colorschemes.d/toml/deep-space.toml".text = ''
      # Source https//github.com/tyrannicaltoucan/vim-deep-space

      # Default colors
      [colors.primary]
      background = '#1b202a'
      foreground = '#9aa7bd'

      # Colors the cursor will use if `custom_cursor_colors` is true
      [colors.cursor]
      text = '#232936'
      cursor = '#51617d'

      # Normal colors
      [colors.normal]
      black = '#1b202a'
      red = '#b15e7c'
      green = '#709d6c'
      yellow = '#b5a262'
      blue = '#608cc3'
      magenta = '#8f72bf'
      cyan = '#56adb7'
      white = '#9aa7bd'

      # Bright colors
      [colors.bright]
      black = '#232936'
      red = '#b3785d'
      green = '#709d6c'
      yellow = '#d5b875'
      blue = '#608cc3'
      magenta = '#c47ebd'
      cyan = '#51617d'
      white = '#9aa7bd'
    '';
    ".config/alacritty/colorschemes.d/toml/doom-one.toml".text = ''
      # Colors (Doom One)

      # Default colors
      [colors.primary]
      background = '#282c34'
      foreground = '#bbc2cf'

      # Normal colors
      [colors.normal]
      black   = '#282c34'
      red     = '#ff6c6b'
      green   = '#98be65'
      yellow  = '#ecbe7b'
      blue    = '#51afef'
      magenta = '#c678dd'
      cyan    = '#46d9ff'
      white   = '#bbc2cf'
    '';
    ".config/alacritty/colorschemes.d/toml/dracula.toml".text = ''
      # Colors (Dracula)

      # Default colors
      [colors.primary]
      background = '#282a36'
      foreground = '#f8f8f2'

      # Normal colors
      [colors.normal]
      black   = '#000000'
      red     = '#ff5555'
      green   = '#50fa7b'
      yellow  = '#f1fa8c'
      blue    = '#bd93f9'
      magenta = '#ff79c6'
      cyan    = '#8be9fd'
      white   = '#bbbbbb'

      # Bright colors
      [colors.bright]
      black   = '#555555'
      red     = '#ff5555'
      green   = '#50fa7b'
      yellow  = '#f1fa8c'
      blue    = '#caa9fa'
      magenta = '#ff79c6'
      cyan    = '#8be9fd'
      white   = '#ffffff'
    '';
    ".config/alacritty/colorschemes.d/yml/dracula.yml".text = ''
    schemes:
      dracula:  &dracula
        # Default colors
        primary:
          background: '#282a36'
          foreground: '#f8f8f2'
        # Normal colors
        normal:
          black:   '#000000'
          red:     '#ff5555'
          green:   '#50fa7b'
          yellow:  '#f1fa8c'
          blue:    '#caa9fa'
          magenta: '#ff79c6'
          cyan:    '#8be9fd'
          white:   '#bfbfbf'
        # Bright colors
        bright:
          black:   '#575b70'
          red:     '#ff6e67'
          green:   '#5af78e'
          yellow:  '#f4f99d'
          blue:    '#caa9fa'
          magenta: '#ff92d0'
          cyan:    '#9aedfe'
          white:   '#e6e6e6'
    colors:  *dracula
    '';
    ".config/alacritty/colorschemes.d/toml/everforest-dark.toml".text = ''
      # Colors (Everforest Dark)

      # Default colors
      [colors.primary]
      background = '#2d353b'
      foreground = '#d3c6aa'

      # Normal colors
      [colors.normal]
      black   = '#475258'
      red     = '#e67e80'
      green   = '#a7c080'
      yellow  = '#dbbc7f'
      blue    = '#7fbbb3'
      magenta = '#d699b6'
      cyan    = '#83c092'
      white   = '#d3c6aa'

      # Bright colors
      [colors.bright]
      black   = '#475258'
      red     = '#e67e80'
      green   = '#a7c080'
      yellow  = '#dbbc7f'
      blue    = '#7fbbb3'
      magenta = '#d699b6'
      cyan    = '#83c092'
      white   = '#d3c6aa'
    '';
    ".config/alacritty/colorschemes.d/toml/everforest-light.toml".text = ''
      # Colors (Everforest Light)

      # Default colors
      [colors.primary]
      background = '#fdf6e3'
      foreground = '#5c6a72'

      # Normal colors
      [colors.normal]
      black   = '#5c6a72'
      red     = '#f85552'
      green   = '#8da101'
      yellow  = '#dfa000'
      blue    = '#3a94c5'
      magenta = '#df69ba'
      cyan    = '#35a77c'
      white   = '#e0dcc7'

      # Bright Colors
      [colors.bright]
      black   = '#5c6a72'
      red     = '#f85552'
      green   = '#8da101'
      yellow  = '#dfa000'
      blue    = '#3a94c5'
      magenta = '#df69ba'
      cyan    = '#35a77c'
      white   = '#e0dcc7'
    '';
    ".config/alacritty/colorschemes.d/toml/falcon.toml".text = ''
      # falcon colorscheme for alacritty
      # by fenetikm, https//github.com/fenetikm/falcon

      # Default colors
      [colors.primary]
      background = '#020221'
      foreground = '#b4b4b9'

      [colors.cursor]
      text = '#020221'
      cursor = '#ffe8c0'

      # Normal colors
      [colors.normal]
      black   = '#000004'
      red     = '#ff3600'
      green   = '#718e3f'
      yellow  = '#ffc552'
      blue    = '#635196'
      magenta = '#ff761a'
      cyan    = '#34bfa4'
      white   = '#b4b4b9'

      # Bright colors
      [colors.bright]
      black   = '#020221'
      red     = '#ff8e78'
      green   = '#b1bf75'
      yellow  = '#ffd392'
      blue    = '#99a4bc'
      magenta = '#ffb07b'
      cyan    = '#8bccbf'
      white   = '#f8f8ff'
    '';
    ".config/alacritty/colorschemes.d/toml/flat-remix.toml".text = ''
      [colors.primary]
      background = '#272a34'
      foreground = '#FFFFFF'

      [colors.normal]
      black   = '#1F2229'
      red     = '#EC0101'
      green   = '#47D4B9'
      yellow  = '#FF8A18'
      blue    = '#277FFF'
      magenta = '#D71655'
      cyan    = '#05A1F7'
      white   = '#FFFFFF'

      [colors.bright]
      black   = '#1F2229'
      red     = '#D41919'
      green   = '#5EBDAB'
      yellow  = '#FEA44C'
      blue    = '#367bf0'
      magenta = '#BF2E5D'
      cyan    = '#49AEE6'
      white   = '#FFFFFF'
    '';
    ".config/alacritty/colorschemes.d/toml/flexoki.toml".text = ''
      # based on https//stephango.com/flexoki and https//github.com/kepano/flexoki/tree/main/alacritty

      # Default colors
      [colors.primary]
      background = '#282726'
      foreground = '#FFFCF0'
      dim_foreground = '#FFFCF0'
      bright_foreground = '#FFFCF0'

      # Cursor colors
      [colors.cursor]
      text = '#FFFCF0'
      cursor = '#FFFCF0'

      # Normal colors
      [colors.normal]
      black = '#100F0F'
      red = '#AF3029'
      green = '#66800B'
      yellow = '#AD8301'
      blue = '#205EA6'
      magenta = '#A02F6F'
      cyan = '#24837B'
      white = '#FFFCF0'

      # Bright colors
      [colors.bright]
      black = '#100F0F'
      red = '#D14D41'
      green = '#879A39'
      yellow = '#D0A215'
      blue = '#4385BE'
      magenta = '#CE5D97'
      cyan = '#3AA99F'
      white = '#FFFCF0'

      # Dim colors
      [colors.dim]
      black = '#100F0F'
      red = '#AF3029'
      green = '#66800B'
      yellow = '#AD8301'
      blue = '#205EA6'
      magenta = '#A02F6F'
      cyan = '#24837B'
      white = '#FFFCF0'
    '';
    ".config/alacritty/colorschemes.d/toml/github-dark-colorblind.toml".text = ''
      # github Alacritty Colors

      # Default colors
      [colors.primary]
      background = '#0d1117'
      foreground = '#b3b1ad'

      # Normal colors
      [colors.normal]
      black   = '#484f58'
      red     = '#ff7b72'
      green   = '#3fb950'
      yellow  = '#d29922'
      blue    = '#58a6ff'
      magenta = '#bc8cff'
      cyan    = '#39c5cf'
      white   = '#b1bac4'

      # Bright colors
      [colors.bright]
      black   = '#6e7681'
      red     = '#ffa198'
      green   = '#56d364'
      yellow  = '#e3b341'
      blue    = '#79c0ff'
      magenta = '#d2a8ff'
      cyan    = '#56d4dd'
      white   = '#f0f6fc'

      [[colors.indexed_colors]]
      index = 16
      color = '#d18616'

      [[colors.indexed_colors]]
      index = 17
      color = '#ffa198'
    '';
    ".config/alacritty/colorschemes.d/toml/github-dark-default.toml".text = ''
      # github Alacritty Colors

      # Default colors
      [colors.primary]
      background = '#0d1117'
      foreground = '#b3b1ad'

      # Normal colors
      [colors.normal]
      black   = '#484f58'
      red     = '#ff7b72'
      green   = '#3fb950'
      yellow  = '#d29922'
      blue    = '#58a6ff'
      magenta = '#bc8cff'
      cyan    = '#39c5cf'
      white   = '#b1bac4'

      # Bright colors
      [colors.bright]
      black   = '#6e7681'
      red     = '#ffa198'
      green   = '#56d364'
      yellow  = '#e3b341'
      blue    = '#79c0ff'
      magenta = '#d2a8ff'
      cyan    = '#56d4dd'
      white   = '#f0f6fc'

      [[colors.indexed_colors]]
      index = 16
      color = '#d18616'

      [[colors.indexed_colors]]
      index = 17
      color = '#ffa198'
    '';
    ".config/alacritty/colorschemes.d/toml/github-dark-dimmed.toml".text = ''
      # github Alacritty Colors

      # Default colors
      [colors.primary]
      background = '#22272e'
      foreground = '#768390'

      # Normal colors
      [colors.normal]
      black   = '#545d68'
      red     = '#f47067'
      green   = '#57ab5a'
      yellow  = '#c69026'
      blue    = '#539bf5'
      magenta = '#b083f0'
      cyan    = '#39c5cf'
      white   = '#909dab'

      # Bright colors
      [colors.bright]
      black   = '#636e7b'
      red     = '#ff938a'
      green   = '#6bc46d'
      yellow  = '#daaa3f'
      blue    = '#6cb6ff'
      magenta = '#dcbdfb'
      cyan    = '#56d4dd'
      white   = '#cdd9e5'

      [[colors.indexed_colors]]
      index = 16
      color = '#d18616'

      [[colors.indexed_colors]]
      index = 17
      color = '#ff938a'
    '';
    ".config/alacritty/colorschemes.d/toml/github-dark-high-contrast.toml".text = ''
      # (Github Dark High Contrast) Colors for Alacritty

      # Default colors
      [colors.primary]
      background = '#0a0c10'
      foreground = '#f0f3f6'

      # Cursor colors
      [colors.cursor]
      text = '#0a0c10'
      cursor = '#f0f3f6'

      # Normal colors
      [colors.normal]
      black = '#7a828e'
      red = '#ff9492'
      green = '#26cd4d'
      yellow = '#f0b72f'
      blue = '#71b7ff'
      magenta = '#cb9eff'
      cyan = '#39c5cf'
      white = '#d9dee3'

      # Bright colors
      [colors.bright]
      black = '#9ea7b3'
      red = '#ffb1af'
      green = '#4ae168'
      yellow = '#f7c843'
      blue = '#91cbff'
      magenta = '#cb9eff'
      cyan = '#39c5cf'
      white = '#d9dee3'
    '';
    ".config/alacritty/colorschemes.d/toml/github-dark.toml".text = ''
      # github Alacritty Colors

      # Default colors
      [colors.primary]
      background = '#24292e'
      foreground = '#d1d5da'

      # Normal colors
      [colors.normal]
      black   = '#586069'
      red     = '#ea4a5a'
      green   = '#34d058'
      yellow  = '#ffea7f'
      blue    = '#2188ff'
      magenta = '#b392f0'
      cyan    = '#39c5cf'
      white   = '#d1d5da'

      # Bright colors
      [colors.bright]
      black   = '#959da5'
      red     = '#f97583'
      green   = '#85e89d'
      yellow  = '#ffea7f'
      blue    = '#79b8ff'
      magenta = '#b392f0'
      cyan    = '#56d4dd'
      white   = '#fafbfc'

      [[colors.indexed_colors]]
      index = 16
      color = '#d18616'

      [[colors.indexed_colors]]
      index = 17
      color = '#f97583'
    '';
    ".config/alacritty/colorschemes.d/toml/github-dark-tritanopia.toml".text = ''
      # (Github Dark Tritanopia) Colors for Alacritty

      # Default colors
      [colors.primary]
      background = '#0d1117'
      foreground = '#c9d1d9'

      # Cursor colors
      [colors.cursor]
      text = '#0d1117'
      cursor = '#c9d1d9'

      # Normal colors
      [colors.normal]
      black = '#484f58'
      red = '#ff7b72'
      green = '#58a6ff'
      yellow = '#d29922'
      blue = '#58a6ff'
      magenta = '#bc8cff'
      cyan = '#39c5cf'
      white = '#b1bac4'

      # Bright colors
      [colors.bright]
      black = '#6e7681'
      red = '#ffa198'
      green = '#79c0ff'
      yellow = '#e3b341'
      blue = '#79c0ff'
      magenta = '#bc8cff'
      cyan = '#39c5cf'
      white = '#b1bac4'
    '';
    ".config/alacritty/colorschemes.d/toml/github-light-colorblind.toml".text = ''
      # github Alacritty Colors

      # Default colors
      [colors.primary]
      background = '#ffffff'
      foreground = '#0E1116'

      # Normal colors
      [colors.normal]
      black   = '#24292f'
      red     = '#cf222e'
      green   = '#116329'
      yellow  = '#4d2d00'
      blue    = '#0969da'
      magenta = '#8250df'
      cyan    = '#1b7c83'
      white   = '#6e7781'

      # Bright colors
      [colors.bright]
      black   = '#57606a'
      red     = '#a40e26'
      green   = '#1a7f37'
      yellow  = '#633c01'
      blue    = '#218bff'
      magenta = '#a475f9'
      cyan    = '#3192aa'
      white   = '#8c959f'

      [[colors.indexed_colors]]
      index = 16
      color = '#d18616'

      [[colors.indexed_colors]]
      index = 17
      color = '#a40e26'
    '';
    ".config/alacritty/colorschemes.d/toml/github-light-default.toml".text = ''
      # github Alacritty Colors

      # Default colors
      [colors.primary]
      background = '#ffffff'
      foreground = '#0E1116'

      # Normal colors
      [colors.normal]
      black   = '#24292f'
      red     = '#cf222e'
      green   = '#116329'
      yellow  = '#4d2d00'
      blue    = '#0969da'
      magenta = '#8250df'
      cyan    = '#1b7c83'
      white   = '#6e7781'

      # Bright colors
      [colors.bright]
      black   = '#57606a'
      red     = '#a40e26'
      green   = '#1a7f37'
      yellow  = '#633c01'
      blue    = '#218bff'
      magenta = '#a475f9'
      cyan    = '#3192aa'
      white   = '#8c959f'

      [[colors.indexed_colors]]
      index = 16
      color = '#d18616'

      [[colors.indexed_colors]]
      index = 17
      color = '#a40e26'
    '';
    ".config/alacritty/colorschemes.d/toml/github-light-high-contrast.toml".text = ''
      # (Github Light High Contrast) Colors for Alacritty

      # Default colors
      [colors.primary]
      background = '#ffffff'
      foreground = '#010409'

      # Cursor colors
      [colors.cursor]
      text = '#ffffff'
      cursor = '#0e1116'

      # Normal colors
      [colors.normal]
      black = '#0e1116'
      red = '#a0111f'
      green = '#024c1a'
      yellow = '#3f2200'
      blue = '#0349b4'
      magenta = '#622cbc'
      cyan = '#1b7c83'
      white = '#66707b'

      # Bright colors
      [colors.bright]
      black = '#4b535d'
      red = '#86061d'
      green = '#055d20'
      yellow = '#4e2c00'
      blue = '#1168e3'
      magenta = '#622cbc'
      cyan = '#1b7c83'
      white = '#66707b'
    '';
    ".config/alacritty/colorschemes.d/toml/github-light.toml".text = ''
      # github Alacritty Colors

      # Default colors
      [colors.primary]
      background = '#ffffff'
      foreground = '#24292f'

      # Normal colors
      [colors.normal]
      black   = '#24292e'
      red     = '#d73a49'
      green   = '#28a745'
      yellow  = '#dbab09'
      blue    = '#0366d6'
      magenta = '#5a32a3'
      cyan    = '#0598bc'
      white   = '#6a737d'

      # Bright colors
      [colors.bright]
      black   = '#959da5'
      red     = '#cb2431'
      green   = '#22863a'
      yellow  = '#b08800'
      blue    = '#005cc5'
      magenta = '#5a32a3'
      cyan    = '#3192aa'
      white   = '#d1d5da'

      [[colors.indexed_colors]]
      index = 16
      color = '#d18616'

      [[colors.indexed_colors]]
      index = 17
      color = '#cb2431'
    '';
    ".config/alacritty/colorschemes.d/toml/github-light-tritanopia.toml".text = ''
      # (Github Light Tritanopia) Colors for Alacritty

      # Default colors
      [colors.primary]
      background = '#ffffff'
      foreground = '#1b1f24'

      # Cursor colors
      [colors.cursor]
      text = '#ffffff'
      cursor = '#24292f'

      # Normal colors
      [colors.normal]
      black = '#24292f'
      red = '#cf222e'
      green = '#0550ae'
      yellow = '#4d2d00'
      blue = '#0969da'
      magenta = '#8250df'
      cyan = '#1b7c83'
      white = '#6e7781'

      # Bright colors
      [colors.bright]
      black = '#57606a'
      red = '#a40e26'
      green = '#0969da'
      yellow = '#633c01'
      blue = '#218bff'
      magenta = '#8250df'
      cyan = '#1b7c83'
      white = '#6e7781'
    '';
    ".config/alacritty/colorschemes.d/toml/gnome-terminal.toml".text = ''
      # Gnome (Gnome Terminal Default)

      # Default colors
      [colors.primary]
      background = '#1e1e1e'
      foreground = '#ffffff'

      # Normal colors
      [colors.normal]
      black      = '#171421'
      red        = '#c01c28'
      green      = '#26a269'
      yellow     = '#a2734c'
      blue       = '#12488b'
      magenta    = '#a347ba'
      cyan       = '#2aa1b3'
      white      = '#d0cfcc'

      # Bright colors
      [colors.bright]
      black      = '#5e5c64'
      red        = '#f66151'
      green      = '#33d17a'
      yellow     = '#e9ad0c'
      blue       = '#2a7bde'
      magenta    = '#c061cb'
      cyan       = '#33c7de'
      white      = '#ffffff'
    '';
    ".config/alacritty/colorschemes.d/yml/gnome-dark.yml".text = ''
    schemes:
      gnome_dark:  &gnome_dark
        # Default colors
        primary:
          foreground: '#d0cfcc'
          background: '#171421'
          bright_foreground: '#ffffff'
        # Normal colors
        normal:
          black:   '#171421'
          red:     '#c01c28'
          green:   '#26a269'
          yellow:  '#a2734c'
          blue:    '#12488b'
          magenta: '#a347ba'
          cyan:    '#2aa1b3'
          white:   '#d0cfcc'
        # Bright colors
        bright:
          black:   '#5e5c64'
          red:     '#f66151'
          green:   '#33d17a'
          yellow:  '#e9ad0c'
          blue:    '#2a7bde'
          magenta: '#c061cb'
          cyan:    '#33c7de'
          white:   '#ffffff'
    colors:  *gnome_dark
    '';
    ".config/alacritty/colorschemes.d/yml/gnome-light.yml".text = ''
    schemes:
      gnome_light:  &gnome_light
        # Default colors
        primary:
          foreground: '#171421'
          background: '#ffffff'
          bright_foreground: '#5e5c64'
        # Normal colors
        normal:
          black:   '#171421'
          red:     '#c01c28'
          green:   '#26a269'
          yellow:  '#a2734c'
          blue:    '#12488b'
          magenta: '#a347ba'
          cyan:    '#2aa1b3'
          white:   '#d0cfcc'
        # Bright colors
        bright:
          black:   '#5e5c64'
          red:     '#f66151'
          green:   '#33d17a'
          yellow:  '#e9ad0c'
          blue:    '#2a7bde'
          magenta: '#c061cb'
          cyan:    '#33c7de'
          white:   '#ffffff'
    colors: *gnome_light
    '';
    ".config/alacritty/colorschemes.d/toml/gotham.toml".text = ''
      # Colors (Gotham)

      # Default colors
      [colors.primary]
      background = '#0a0f14'
      foreground = '#98d1ce'

      # Normal colors
      [colors.normal]
      black = '#0a0f14'
      red = '#c33027'
      green = '#26a98b'
      yellow = '#edb54b'
      blue = '#195465'
      magenta = '#4e5165'
      cyan = '#33859d'
      white = '#98d1ce'

      # Bright colors
      [colors.bright]
      black = '#10151b'
      red = '#d26939'
      green = '#081f2d'
      yellow = '#245361'
      blue = '#093748'
      magenta = '#888ba5'
      cyan = '#599caa'
      white = '#d3ebe9'
    '';
    ".config/alacritty/colorschemes.d/toml/gruvbox-dark.toml".text = ''
      # Colors (Gruvbox dark)

      # Default colors
      [colors.primary]
      # hard contrast background = = '#1d2021'
      background = '#282828'
      # soft contrast background = = '#32302f'
      foreground = '#ebdbb2'

      # Normal colors
      [colors.normal]
      black   = '#282828'
      red     = '#cc241d'
      green   = '#98971a'
      yellow  = '#d79921'
      blue    = '#458588'
      magenta = '#b16286'
      cyan    = '#689d6a'
      white   = '#a89984'

      # Bright colors
      [colors.bright]
      black   = '#928374'
      red     = '#fb4934'
      green   = '#b8bb26'
      yellow  = '#fabd2f'
      blue    = '#83a598'
      magenta = '#d3869b'
      cyan    = '#8ec07c'
      white   = '#ebdbb2'
    '';
    ".config/alacritty/colorschemes.d/yml/gruvbox-dark.yml".text = ''
    schemes:
      gruvbox_dark:  &gruvbox_dark
        primary:
          # hard contrast background - '#1d2021'
          background:        &gruvbox_dark_bg '#282828'
          # soft contrast background - '#32302f'
          foreground:        '#fbf1c7'
          bright_foreground: '#f9f5d7'
          dim_foreground:    '#f2e5bc'
        cursor:
          text:   CellBackground
          cursor: CellForeground
        vi_mode_cursor:
          text:   CellBackground
          cursor: CellForeground
        # search:
        #   matches:
        #     foreground: '#000000'
        #     background: '#ffffff'
        #   focused_match:
        #    foreground: CellBackground
        #    background: CellForeground
        #   bar:
        #     background: 
        #     foreground: 
        # line_indicator:
        #   foreground: None
        #   background: None     
        selection:
          text:       CellBackground
          background: CellForeground
        bright:
          black:   '#928374'
          red:     '#fb4934'
          green:   '#b8bb26'
          yellow:  '#fabd2f'
          blue:    '#83a598'
          magenta: '#d3869b'
          cyan:    '#8ec07c'
          white:   '#ebdbb2'
        normal:
          black:   *gruvbox_dark_bg
          red:     '#cc241d'
          green:   '#98971a'
          yellow:  '#d79921'
          blue:    '#458588'
          magenta: '#b16286'
          cyan:    '#689d6a'
          white:   '#a89984'
        dim:
          black:   '#32302f'
          red:     '#9d0006'
          green:   '#79740e'
          yellow:  '#b57614'
          blue:    '#076678'
          magenta: '#8f3f71'
          cyan:    '#427b58'
          white:   '#928374'
        # indexed_colors: []
    colors:  *gruvbox_dark
    '';
    ".config/alacritty/colorschemes.d/toml/gruvbox-light.toml".text = ''
      # Colors (Gruvbox light)

      # Default colors
      [colors.primary]
      # hard contrast background = = '#f9f5d7'
      background = '#fbf1c7'
      # soft contrast background = = '#f2e5bc'
      foreground = '#3c3836'

      # Normal colors
      [colors.normal]
      black   = '#fbf1c7'
      red     = '#cc241d'
      green   = '#98971a'
      yellow  = '#d79921'
      blue    = '#458588'
      magenta = '#b16286'
      cyan    = '#689d6a'
      white   = '#7c6f64'

      # Bright colors
      [colors.bright]
      black   = '#928374'
      red     = '#9d0006'
      green   = '#79740e'
      yellow  = '#b57614'
      blue    = '#076678'
      magenta = '#8f3f71'
      cyan    = '#427b58'
      white   = '#3c3836'
    '';
    ".config/alacritty/colorschemes.d/yml/gruvbox-light.yml".text = ''
    schemes:
      gruvbox_light:  &gruvbox_light
        # Default colors
        primary:
          # hard contrast: background = '#f9f5d7'
          background: '#fbf1c7'
          # soft contrast: background = '#f2e5bc'
          foreground: '#3c3836'
        # Normal colors
        normal:
          black:   '#fbf1c7'
          red:     '#cc241d'
          green:   '#98971a'
          yellow:  '#d79921'
          blue:    '#458588'
          magenta: '#b16286'
          cyan:    '#689d6a'
          white:   '#7c6f64'

        # Bright colors
        bright:
          black:   '#928374'
          red:     '#9d0006'
          green:   '#79740e'
          yellow:  '#b57614'
          blue:    '#076678'
          magenta: '#8f3f71'
          cyan:    '#427b58'
          white:   '#3c3836'
    colors:  *gruvbox_light
    '';
    ".config/alacritty/colorschemes.d/toml/gruvbox-material-medium-dark.toml".text = ''
      # Colors (Gruvbox Material Medium Dark)

      # Default colors
      [colors.primary]
      background = '#282828'
      foreground = '#d4be98'

      # Normal colors
      [colors.normal]
      black   = '#3c3836'
      red     = '#ea6962'
      green   = '#a9b665'
      yellow  = '#d8a657'
      blue    = '#7daea3'
      magenta = '#d3869b'
      cyan    = '#89b482'
      white   = '#d4be98'

      # Bright colors (same as normal colors)
      [colors.bright]
      black   = '#3c3836'
      red     = '#ea6962'
      green   = '#a9b665'
      yellow  = '#d8a657'
      blue    = '#7daea3'
      magenta = '#d3869b'
      cyan    = '#89b482'
      white   = '#d4be98'
    '';
    ".config/alacritty/colorschemes.d/toml/gruvbox-material-medium-light.toml".text = ''
      # Colors (Gruvbox Material Medium Light)

      # Default colors
      [colors.primary]
      background = '#fbf1c7'
      foreground = '#654735'

      # Normal colors
      [colors.normal]
      black   = '#654735'
      red     = '#c14a4a'
      green   = '#6c782e'
      yellow  = '#b47109'
      blue    = '#45707a'
      magenta = '#945e80'
      cyan    = '#4c7a5d'
      white   = '#eee0b7'

      # Bright colors (same as normal colors)
      [colors.bright]
      black   = '#654735'
      red     = '#c14a4a'
      green   = '#6c782e'
      yellow  = '#b47109'
      blue    = '#45707a'
      magenta = '#945e80'
      cyan    = '#4c7a5d'
      white   = '#eee0b7'
    '';
    ".config/alacritty/colorschemes.d/toml/gruvbox-material.toml".text = ''
      # Colors (Gruvbox Material Dark Medium)

      [colors.primary]
      background = '#282828'
      foreground = '#dfbf8e'

      [colors.normal]
      black   = '#665c54'
      red     = '#ea6962'
      green   = '#a9b665'
      yellow  = '#e78a4e'
      blue    = '#7daea3'
      magenta = '#d3869b'
      cyan    = '#89b482'
      white   = '#dfbf8e'

      [colors.bright]
      black   = '#928374'
      red     = '#ea6962'
      green   = '#a9b665'
      yellow  = '#e3a84e'
      blue    = '#7daea3'
      magenta = '#d3869b'
      cyan    = '#89b482'
      white   = '#dfbf8e'
    '';
    ".config/alacritty/colorschemes.d/toml/hardhacker.toml".text = ''
      # hardhacker colorscheme for alacritty
      # by xin wu, https//github.com/hardhackerlabs/theme-alacritty

      # Default colors
      [colors.primary]
      background = '#282433'
      foreground = '#eee9fc'

      [colors.cursor]
      text = '#eee9fc'
      cursor = '#eee9fc'

      # Normal colors
      [colors.normal]
      black   = '#282433'
      red     = '#e965a5'
      green   = '#b1f2a7'
      yellow  = '#ebde76'
      blue    = '#b1baf4'
      magenta = '#e192ef'
      cyan    = '#b3f4f3'
      white   = '#eee9fc'

      # Bright colors
      [colors.bright]
      black   = '#3f3951'
      red     = '#e965a5'
      green   = '#b1f2a7'
      yellow  = '#ebde76'
      blue    = '#b1baf4'
      magenta = '#e192ef'
      cyan    = '#b3f4f3'
      white   = '#eee9fc'
    '';
    ".config/alacritty/colorschemes.d/toml/high-contrast.toml".text = ''
      # Colors (High Contrast)

      # Default colors
      [colors.primary]
      background = '#444444'
      foreground = '#dddddd'

      # Colors the cursor will use if `custom_cursor_colors` is true
      [colors.cursor]
      text = '#aaaaaa'
      cursor = '#ffffff'

      # Normal colors
      [colors.normal]
      black   = '#000000'
      red     = '#ff0000'
      green   = '#00ff00'
      yellow  = '#ffff00'
      blue    = '#0000ff'
      magenta = '#ff00ff'
      cyan    = '#00ffff'
      white   = '#ffffff'

      # Bright colors
      [colors.bright]
      black   = '#000000'
      red     = '#ff0000'
      green   = '#00ff00'
      yellow  = '#ffff00'
      blue    = '#0000ff'
      magenta = '#ff00ff'
      cyan    = '#00ffff'
      white   = '#ffffff'
    '';
    ".config/alacritty/colorschemes.d/toml/horizon-dark.toml".text = ''
      # Colors (Horizon Dark)

      # Primary colors
      [colors.primary]
      background = '#1c1e26'
      foreground = '#e0e0e0'

      # Normal colors
      [colors.normal]
      black = '#16161c'
      red = '#e95678'
      green = '#29d398'
      yellow = '#fab795'
      blue = '#26bbd9'
      magenta = '#ee64ac'
      cyan = '#59e1e3'
      white = '#d5d8da'

      # Bright colors
      [colors.bright]
      black = '#5b5858'
      red = '#ec6a88'
      green = '#3fdaa4'
      yellow = '#fbc3a7'
      blue = '#3fc4de'
      magenta = '#f075b5'
      cyan = '#6be4e6'
      white = '#d5d8da'
    '';
    ".config/alacritty/colorschemes.d/yml/hybrid.yml".text = ''
    schemes:
      hybrid:  &hybrid
        # Default colors
        primary:
          background: '#27292c'
          foreground: '#d0d2d1'
        # Normal colors
        normal:
          black:   '#35383b'
          red:     '#b05655'
          green:   '#769972'
          yellow:  '#e1a574'
          blue:    '#7693ac'
          magenta: '#977ba0'
          cyan:    '#749e99'
          white:   '#848b92'
        # Bright colors
        bright:
          black:   '#484c52'
          red:     '#d27c7b'
          green:   '#dffebe'
          yellow:  '#f0d189'
          blue:    '#96b1c9'
          magenta: '#bfa5c7'
          cyan:    '#9fc9c3'
          white:   '#fcf7e2'
    colors:  *hybrid
    '';
    ".config/alacritty/colorschemes.d/toml/hyper.toml".text = ''
      # Colors (Hyper)

      # Default colors
      [colors.primary]
      background = '#000000'
      foreground = '#ffffff'

      [colors.cursor]
      text = '#F81CE5'
      cursor = '#ffffff'

      # Normal colors
      [colors.normal]
      black   = '#000000'
      red     = '#fe0100'
      green   = '#33ff00'
      yellow  = '#feff00'
      blue    = '#0066ff'
      magenta = '#cc00ff'
      cyan    = '#00ffff'
      white   = '#d0d0d0'

      # Bright colors
      [colors.bright]
      black   = '#808080'
      red     = '#fe0100'
      green   = '#33ff00'
      yellow  = '#feff00'
      blue    = '#0066ff'
      magenta = '#cc00ff'
      cyan    = '#00ffff'
      white   = '#FFFFFF'
    '';
    ".config/alacritty/colorschemes.d/yml/hyper.yml".text = ''
    schemes:
      hyper:  &hyper
        # Default colors
        primary:
          background: '#000000'
          foreground: '#ffffff'
        cursor:
          text: '#F81CE5'
          cursor: '#ffffff'
        # Normal colors
        normal:
          black:   '#000000'
          red:     '#fe0100'
          green:   '#33ff00'
          yellow:  '#feff00'
          blue:    '#0066ff'
          magenta: '#cc00ff'
          cyan:    '#00ffff'
          white:   '#d0d0d0'
        # Bright colors
        bright:
          black:   '#808080'
          red:     '#fe0100'
          green:   '#33ff00'
          yellow:  '#feff00'
          blue:    '#0066ff'
          magenta: '#cc00ff'
          cyan:    '#00ffff'
          white:   '#FFFFFF'
    colors:  *hyper
    '';
    ".config/alacritty/colorschemes.d/yml/iceberg-dark.yml".text = ''
    schemes:
      iceberg_dark:  &iceberg_dark
        # Default colors
        primary:
          background: '#161821'
          foreground: '#d2d4de'
        # Normal colors
        normal:
          black:   '#161821'
          red:     '#e27878'
          green:   '#b4be82'
          yellow:  '#e2a478'
          blue:    '#84a0c6'
          magenta: '#a093c7'
          cyan:    '#89b8c2'
          white:   '#c6c8d1'
        # Bright colors
        bright:
          black:   '#6b7089'
          red:     '#e98989'
          green:   '#c0ca8e'
          yellow:  '#e9b189'
          blue:    '#91acd1'
          magenta: '#ada0d3'
          cyan:    '#95c4ce'
          white:   '#d2d4de'
    colors:  *iceberg_dark
    '';
    ".config/alacritty/colorschemes.d/yml/iceberg-light.yml".text = ''
    schemes:
      iceberg_light:  &iceberg_light
        # Default colors
        primary:
          background: '#e8e9ec'
          foreground: '#33374c'
        # Normal colors
        normal:
          black:   '#dcdfe7'
          red:     '#cc517a'
          green:   '#668e3d'
          yellow:  '#c57339'
          blue:    '#2d539e'
          magenta: '#7759b4'
          cyan:    '#3f83a6'
          white:   '#33374c'
        # Bright colors
        bright:
          black:   '#8389a3'
          red:     '#cc3768'
          green:   '#598030'
          yellow:  '#b6662d'
          blue:    '#22478e'
          magenta: '#6845ad'
          cyan:    '#327698'
          white:   '#262a3f'
    colors:  *iceberg_light
    '';
    ".config/alacritty/colorschemes.d/yml/ir-black.yml".text = ''
    schemes:
      ir_black:  &ir_black
        # Default colors
        primary:
          background: '#000000'
          foreground: '#ffffff'
        cursor:
          text: '#ffffff'
          cursor: '#ffffff'
        # Normal colors
        normal:
          black:   '#4e4e4e'
          red:     '#ff6c60'
          green:   '#a8ff60'
          yellow:  '#ffffb6'
          blue:    '#96cbfe'
          magenta: '#ff73fd'
          cyan:    '#c6c5fe'
          white:   '#eeeeee'
        # Bright colors
        bright:
          black:   '#7c7c7c'
          red:     '#ffb6b0'
          green:   '#ceffab'
          yellow:  '#ffffcb'
          blue:    '#b5dcfe'
          magenta: '#ff9cfe'
          cyan:    '#dfdffe'
          white:   '#ffffff'
    colors:  *ir_black
    '';
    ".config/alacritty/colorschemes.d/toml/inferno.toml".text = ''
      # Inferno theme
      # Source https//github.com/hafiz-muhammad/inferno-alacritty-theme/blob/main/inferno.yml

      # Default colors
      [colors.primary]
      background = '#270d06'
      foreground = '#d9d9d9'

      # Normal colors
      [colors.normal]
      black   = '#330000'
      red     = '#ff3300'
      green   = '#ff6600'
      yellow  = '#ff9900'
      blue    = '#ffcc00'
      magenta = '#ff6600'
      cyan    = '#ff9900'
      white   = '#d9d9d9'

      # Bright colors
      [colors.bright]
      black   = '#663300'
      red     = '#ff6633'
      green   = '#ff9966'
      yellow  = '#ffcc99'
      blue    = '#ffcc33'
      magenta = '#ff9966'
      cyan    = '#ffcc99'
      white   = '#d9d9d9'
    '';
    ".config/alacritty/colorschemes.d/toml/iris.toml".text = ''
      # Colors (Iris)

      # Default colors
      [colors.primary]
      background = '#272537'
      foreground = '#e8e6e9'

      # Normal colors
      [colors.normal]
      black   = '#111133'
      red     = '#d61d52'
      green   = '#48a842'
      yellow  = '#e1a51c'
      blue    = '#5556d3'
      magenta = '#8650d3'
      cyan    = '#52afb7'
      white   = '#9f9aa7'

      # Bright colors
      [colors.bright]
      black   = '#484867'
      red     = '#e15877'
      green   = '#71ab3a'
      yellow  = '#c6a642'
      blue    = '#6d6dc9'
      magenta = '#956ad3'
      cyan    = '#6ab6bd'
      white   = '#e8e6e9'
    '';
    ".config/alacritty/colorschemes.d/toml/iterm.toml".text = ''
      # Colors (iTerm 2 default theme)

      # Default colors
      [colors.primary]
      background = '#101421'
      foreground = '#fffbf6'

      # Normal colors
      [colors.normal]
      black   = '#2e2e2e'
      red     = '#eb4129'
      green   = '#abe047'
      yellow  = '#f6c744'
      blue    = '#47a0f3'
      magenta = '#7b5cb0'
      cyan    = '#64dbed'
      white   = '#e5e9f0'

      # Bright colors
      [colors.bright]
      black   = '#565656'
      red     = '#ec5357'
      green   = '#c0e17d'
      yellow  = '#f9da6a'
      blue    = '#49a4f8'
      magenta = '#a47de9'
      cyan    = '#99faf2'
      white   = '#ffffff'
    '';
    ".config/alacritty/colorschemes.d/yml/iterm-default.yml".text = ''
    schemes:
      iterm_default:  &iterm_default
        # Default colors
        primary:
          background: '#101421'
          foreground: '#fffbf6'
       # Normal colors
        normal:
          black:   '#2e2e2e'
          red:     '#eb4129'
          green:   '#abe047'
          yellow:  '#f6c744'
          blue:    '#47a0f3'
          magenta: '#7b5cb0'
          cyan:    '#64dbed'
          white:   '#e5e9f0'
       # Bright colors
        bright:
          black:   '#565656'
          red:     '#ec5357'
          green:   '#c0e17d'
          yellow:  '#f9da6a'
          blue:    '#49a4f8'
          magenta: '#a47de9'
          cyan:    '#99faf2'
          white:   '#ffffff'
    colors:  *iterm_default
    '';
    ".config/alacritty/colorschemes.d/yml/jellybeans.yml".text = ''
    schemes:
      jellybeans:  &jellybeans
        # Default colors
        primary:
          background: '#161616'
          foreground: '#e4e4e4'
        # Cursor volors
        cursor:
          text: '#feffff'
          cursor: '#ffb472'
        # Normal colors
        normal:
          black:   '#a3a3a3'
          red:     '#e98885'
          green:   '#a3c38b'
          yellow:  '#ffc68d'
          blue:    '#a6cae2'
          magenta: '#e7cdfb'
          cyan:    '#00a69f'
          white:   '#e4e4e4'
        # Bright colors
        bright:
          black:   '#c8c8c8'
          red:     '#ffb2b0'
          green:   '#c8e2b9'
          yellow:  '#ffe1af'
          blue:    '#bddff7'
          magenta: '#fce2ff'
          cyan:    '#0bbdb6'
          white:   '#feffff'
        # Selection colors
        selection:
          text: '#5963a2'
          background: '#f6f6f6'
    colors:  *jellybeans
    '';
    ".config/alacritty/colorschemes.d/toml/kali.toml".text = ''
      [colors.bright]
      black = "#198388"
      blue = "#277FFF"
      cyan = "#05A1F7"
      green = "#47D4B9"
      magenta = "#962AC3"
      red = "#EC0101"
      white = "#FFFFFF"
      yellow = "#FF8A18"

      [colors.normal]
      black = "#1F2229"
      blue = "#367BF0"
      cyan = "#49AEE6"
      green = "#5EBDAB"
      magenta = "#9755B3"
      red = "#D41919"
      white = "#E6E6E6"
      yellow = "#FEA44C"

      [colors.primary]
      background = "#171421"
      foreground = "#FFFFFF"
    '';
    ".config/alacritty/colorschemes.d/yml/kali.yml".text = ''
      schemes:
        kali:  &kali
          # Default colors
          primary:
            background: '#171421'
            foreground: '#FFFFFF'
          # Normal colors
          normal:
            black:   '#1F2229'
            red:     '#D41919'
            green:   '#5EBDAB'
            yellow:  '#FEA44C'
            blue:    '#367BF0'
            magenta: '#9755B3'
            cyan:    '#49AEE6'
            white:   '#E6E6E6'
          # Bright colors
          bright:
            black:   '#198388'
            red:     '#EC0101'
            green:   '#47D4B9'
            yellow:  '#FF8A18'
            blue:    '#277FFF'
            magenta: '#962AC3'
            cyan:    '#05A1F7'
            white:   '#FFFFFF'
      colors:  *kali
    '';
    ".config/alacritty/colorschemes.d/toml/kanagawa-dragon.toml".text = ''
      # Colors (Kanagawa Dragon)
      # Source https//github.com/rebelot/kanagawa.nvim

      [colors.primary]
      background = '#181616'
      foreground = '#c5c9c5'

      [colors.normal]
      black = '#0d0c0c'
      blue = '#8ba4b0'
      cyan = '#8ea4a2'
      green = '#8a9a7b'
      magenta = '#a292a3'
      red = '#c4746e'
      white = '#C8C093'
      yellow = '#c4b28a'

      [colors.bright]
      black = '#a6a69c'
      blue = '#7FB4CA'
      cyan = '#7AA89F'
      green = '#87a987'
      magenta = '#938AA9'
      red = '#E46876'
      white = '#c5c9c5'
      yellow = '#E6C384'

      [colors.selection]
      background = '#2d4f67'
      foreground = '#c8c093'

      [[colors.indexed_colors]]
      index = 16
      color = '#ffa066'

      [[colors.indexed_colors]]
      index = 17
      color = '#ff5d62'
    '';
    ".config/alacritty/colorschemes.d/toml/kanagawa-wave.toml".text = ''
      # Colors (Kanagawa Wave)
      # Source https//github.com/rebelot/kanagawa.nvim

      [colors.primary]
      background = '#1f1f28'
      foreground = '#dcd7ba'

      [colors.normal]
      black   = '#090618'
      red     = '#c34043'
      green   = '#76946a'
      yellow  = '#c0a36e'
      blue    = '#7e9cd8'
      magenta = '#957fb8'
      cyan    = '#6a9589'
      white   = '#c8c093'

      [colors.bright]
      black   = '#727169'
      red     = '#e82424'
      green   = '#98bb6c'
      yellow  = '#e6c384'
      blue    = '#7fb4ca'
      magenta = '#938aa9'
      cyan    = '#7aa89f'
      white   = '#dcd7ba'

      [colors.selection]
      background = '#2d4f67'
      foreground = '#c8c093'

      [[colors.indexed_colors]]
      index = 16
      color = '#ffa066'

      [[colors.indexed_colors]]
      index = 17
      color = '#ff5d62'
    '';
    ".config/alacritty/colorschemes.d/yml/kitty.yml".text = ''
    schemes:
      kitty:  &kitty
        # Default colors
        primary:
          background: '#000000'
          foreground: '#dddddd'
        # Normal colors
        normal:
          black:   '#000000'
          red:     '#cc0403'
          green:   '#19cb00'
          yellow:  '#cecb00'
          blue:    '#0d73cc'
          magenta: '#cb1ed1'
          cyan:    '#0dcdcd'
          white:   '#dddddd'
        # Bright colors
        bright:
          black:   '#767676'
          red:     '#f2201f'
          green:   '#23fd00'
          yellow:  '#fffd00'
          blue:    '#1a8fff'
          magenta: '#fd28ff'
          cyan:    '#14ffff'
          white:   '#ffffff'
    colors:  *kitty
    '';
    ".config/alacritty/colorschemes.d/toml/konsole-linux.toml".text = ''
      # Color theme ported from Konsole Linux colors

      [colors.primary]
      foreground = '#e3e3e3'
      bright_foreground = '#ffffff'
      background = '#1f1f1f'

      [colors.cursor]
      text = '#191622'
      cursor = '#f8f8f2'

      [colors.search]
      matches = { foreground = '#b2b2b2', background = '#b26818' }
      focused_match = { foreground = "CellBackground", background = "CellForeground" }

      [colors.normal]
      black   = '#000000'
      red     = '#b21818'
      green   = '#18b218'
      yellow  = '#b26818'
      blue    = '#1818b2'
      magenta = '#b218b2'
      cyan    = '#18b2b2'
      white   = '#b2b2b2'

      [colors.bright]
      black   = '#686868'
      red     = '#ff5454'
      green   = '#54ff54'
      yellow  = '#ffff54'
      blue    = '#5454ff'
      magenta = '#ff54ff'
      cyan    = '#54ffff'
      white   = '#ffffff'

      [colors.dim]
      black   = '#000000'
      red     = '#b21818'
      green   = '#18b218'
      yellow  = '#b26818'
      blue    = '#1818b2'
      magenta = '#b218b2'
      cyan    = '#18b2b2'
      white   = '#b2b2b2'
    '';
    ".config/alacritty/colorschemes.d/toml/low-contrast.toml".text = ''
      # Colors (Dim)

      # Default colors
      [colors.primary]
      background = '#333333'
      foreground = '#dddddd'

      [colors.cursor]
      text = '#aaaaaa'
      cursor = '#ffffff'

      # Normal colors
      [colors.normal]
      black   = '#000000'
      red     = '#bb0000'
      green   = '#00bb00'
      yellow  = '#bbbb00'
      blue    = '#0000bb'
      magenta = '#bb00bb'
      cyan    = '#00bbbb'
      white   = '#bbbbbb'

      # Bright colors
      [colors.bright]
      black   = '#000000'
      red     = '#bb0000'
      green   = '#00bb00'
      yellow  = '#bbbb00'
      blue    = '#0000bb'
      magenta = '#bb00bb'
      cyan    = '#00bbbb'
      white   = '#bbbbbb'
    '';
    ".config/alacritty/colorschemes.d/toml/Mariana.toml".text = ''
      # Mariana (ported from Sublime Text 4)
      # Source https//github.com/mbadolato/iTerm2-Color-Schemes/blob/master/alacritty/Mariana.yml

      # Default colors
      [colors.primary]
      background = '#343d46'
      foreground = '#d8dee9'

      # Cursor colors
      [colors.cursor]
      cursor = '#fcbb6a'
      text = '#ffffff'

      # Normal colors
      [colors.normal]
      black = '#000000'
      blue = '#6699cc'
      cyan = '#5fb4b4'
      green = '#99c794'
      magenta = '#c695c6'
      red = '#ec5f66'
      white = '#f7f7f7'
      yellow = '#f9ae58'

      # Bright colors
      [colors.bright]
      black = '#333333'
      blue = '#85add6'
      cyan = '#82c4c4'
      green = '#acd1a8'
      magenta = '#d8b6d8'
      red = '#f97b58'
      white = '#ffffff'
      yellow = '#fac761'

      # Selection colors
      [colors.selection]
      background = '#4e5a65'
      text = '#d8dee9'
    '';
    ".config/alacritty/colorschemes.d/toml/marine-dark.toml".text = ''
      # Marine Dark Theme
      # Source https//github.com/ProDeSquare/alacritty-colorschemes/blob/master/themes/marine_dark.yaml

      # Default colors
      [colors.primary]
      background = '#002221'
      foreground = '#e6f8f8'

      # Normal colors
      [colors.normal]
      black   = '#002221'
      red     = '#ea3431'
      green   = '#00b6b6'
      yellow  = '#f8b017'
      blue    = '#4894fd'
      magenta = '#e01dca'
      cyan    = '#1ab2ad'
      white   = '#99dddb'

      # Bright colors
      [colors.bright]
      black   = '#006562'
      red     = '#ea3431'
      green   = '#00b6b6'
      yellow  = '#f8b017'
      blue    = '#4894fd'
      magenta = '#e01dca'
      cyan    = '#1ab2ad'
      white   = '#e6f6f6'
    '';
    ".config/alacritty/colorschemes.d/toml/material-theme-mod.toml".text = ''
      # Colors (Material Theme)

      # Default colors
      [colors.primary]
      background = '#1e282d'
      foreground = '#c4c7d1'

      # Normal colors
      [colors.normal]
      black   = '#666666'
      red     = '#eb606b'
      green   = '#c3e88d'
      yellow  = '#f7eb95'
      blue    = '#80cbc4'
      magenta = '#ff2f90'
      cyan    = '#aeddff'
      white   = '#ffffff'

      # Bright colors
      [colors.bright]
      black   = '#a1a1a1'
      red     = '#eb606b'
      green   = '#c3e88d'
      yellow  = '#f7eb95'
      blue    = '#7dc6bf'
      magenta = '#6c71c4'
      cyan    = '#35434d'
      white   = '#ffffff'
    '';
    ".config/alacritty/colorschemes.d/toml/material-theme.toml".text = ''
      # Colors (Material Theme)

      # Default colors
      [colors.primary]
      background = '#1e282d'
      foreground = '#c4c7d1'

      # Normal colors
      [colors.normal]
      black   = '#666666'
      red     = '#eb606b'
      green   = '#c3e88d'
      yellow  = '#f7eb95'
      blue    = '#80cbc4'
      magenta = '#ff2f90'
      cyan    = '#aeddff'
      white   = '#ffffff'

      # Bright colors
      [colors.bright]
      black   = '#ff262b'
      red     = '#eb606b'
      green   = '#c3e88d'
      yellow  = '#f7eb95'
      blue    = '#7dc6bf'
      magenta = '#6c71c4'
      cyan    = '#35434d'
      white   = '#ffffff'
    '';
    ".config/alacritty/colorschemes.d/yml/material.yml".text = ''
    schemes:
      material:  &material
        # Default colors
        primary:
          background: '#263238'
          foreground: '#eeffff'
        # Normal colors
        normal:
          black:   '#000000'  # Arbitrary
          red:     '#e53935'
          green:   '#91b859'
          yellow:  '#ffb62c'
          blue:    '#6182b8'
          magenta: '#ff5370'  # Dark pink of the original material theme
          cyan:    '#39adb5'
          white:   '#a0a0a0'  # Arbitrary
        # Bright colors
        bright:
          black:   '#4e4e4e'  # Arbitrary
          red:     '#ff5370'
          green:   '#c3e88d'
          yellow:  '#ffcb6b'
          blue:    '#82aaff'
          magenta: '#f07178'  # Pink of the original material theme
          cyan:    '#89ddff'
          white:   '#ffffff'  # Arbitrary
    colors:  *material
    '';
    ".config/alacritty/colorschemes.d/toml/meliora.toml".text = ''
      [colors.primary]
      background = '#1c1917'
      foreground = '#d6d0cd'
      # Bright and dim foreground colors
      dim_foreground = '#d6d0cd'
      bright_foreground = '#d6d0cd'

      # Cursor colors
      [colors.cursor]
      text = '#1c1917'
      cursor = '#d6d0cd'

      [colors.vi_mode_cursor]
      text = '#1c1917'
      cursor = '#d6d0cd'

      # Search colors
      [colors.search]
      matches = { foreground = '#1c1917', background = '#24201e' }
      focused_match = { foreground = '#1c1917', background = '#2a2522' }

      [colors.footer_bar]
      foreground = '#1c1917'
      background = '#b8aea8'

      # Keyboard regex hints
      [colors.hints]
      start = { foreground = '#1c1917', background = '#c4b392' }
      end = { foreground = '#1c1917', background = '#24201e' }

      # Selection colors
      [colors.selection]
      text = '#d6d0cd'
      background = '#2a2522'

      # Normal colors
      [colors.normal]
      black = '#2a2421'
      red = '#d49191'
      green = '#b6b696'
      yellow = '#c4b392'
      blue = '#9e96b6'
      magenta = '#b696b1'
      cyan = '#98acc8'
      white = '#ddd9d6'

      # Bright colors
      [colors.bright]
      black = '#2e2622'
      red = '#d89393'
      green = '#b9b99b'
      yellow = '#c8b692'
      blue = '#a299b9'
      magenta = '#b997b4'
      cyan = '#9bb0ca'
      white = '#e1dbd9'

      # Dim colors
      [colors.dim]
      black = '#2a2421'
      red = '#d18989'
      green = '#727246'
      yellow = '#c1b090'
      blue = '#9b92b3'
      magenta = '#b393ad'
      cyan = '#95a9c5'
      white = '#e3d5ce'

      [[colors.indexed_colors]]
      index = 16
      color = '#c4b392'

      [[colors.indexed_colors]]
      index = 17
      color = '#ddd9d6'
    '';
    ".config/alacritty/colorschemes.d/yml/molokai.yml".text = ''
    schemes:
      molokai:  &molokai
        # Default colors
        primary:
          background: '#1B1D1E'
          foreground: '#F8F8F2'
        # Normal colors
        normal:
          black:   '#333333'
          red:     '#C4265E'
          green:   '#86B42B'
          yellow:  '#B3B42B'
          blue:    '#6A7EC8'
          magenta: '#8C6BC8'
          cyan:    '#56ADBC'
          white:   '#E3E3DD'
        # Bright colors
        bright:
          black:   '#666666'
          red:     '#F92672'
          green:   '#A6E22E'
          yellow:  '#E2E22E'
          blue:    '#819AFF'
          magenta: '#AE81FF'
          cyan:    '#66D9EF'
          white:   '#F8F8F2'
    colors:  *molokai
    '';
    ".config/alacritty/colorschemes.d/toml/midnight-haze.toml".text = ''
      # Midnight Haze theme
      # Source https//github.com/hafiz-muhammad/midnight-haze-alacritty-theme/blob/main/midnight-haze.yml

      # Default colors
      [colors.primary]
      background = '#0c0c16'
      foreground = '#d8dee9'

      # Normal colors
      [colors.normal]
      black   = '#2c2c3d'
      red     = '#ff6e6e'
      green   = '#9ec875'
      yellow  = '#ffa759'
      blue    = '#70a7d4'
      magenta = '#d291e0'
      cyan    = '#96e0e0'
      white   = '#d8dee9'

      # Bright colors
      [colors.bright]
      black   = '#414166'
      red     = '#ff8d8d'
      green   = '#b3d987'
      yellow  = '#ffc57f'
      blue    = '#9bb3d3'
      magenta = '#ffa1ff'
      cyan    = '#9cd8d8'
      white   = '#ffffff'
    '';
    ".config/alacritty/colorschemes.d/toml/monokai-charcoal.toml".text = ''
      # Colours (Monokai Charcoal)

      # Default Colours
      [colors.primary]
      background = '#000000'
      foreground = '#FFFFFF'

      # Normal Colours
      [colors.normal]
      black   = '#1a1a1a'
      red     = '#f4005f'
      green   = '#98e024'
      yellow  = '#fa8419'
      blue    = '#9d65ff'
      magenta = '#f4005f'
      cyan    = '#58d1eb'
      white   = '#c4c5b5'

      # Bright Colours
      [colors.bright]
      black   = '#625e4c'
      red     = '#f4005f'
      green   = '#98e024'
      yellow  = '#e0d561'
      blue    = '#9d65ff'
      magenta = '#f4005f'
      cyan    = '#58d1eb'
      white   = '#f6f6ef'
    '';
    ".config/alacritty/colorschemes.d/toml/monokai-pro.toml".text = ''
      # Default colors
      [colors.primary]
      background = '#2D2A2E'
      foreground = '#fff1f3'

      # Normal colors
      [colors.normal]
      black   = '#2c2525'
      red     = '#fd6883'
      green   = '#adda78'
      yellow  = '#f9cc6c'
      blue    = '#f38d70'
      magenta = '#a8a9eb'
      cyan    = '#85dacc'
      white   = '#fff1f3'

      # Bright colors
      [colors.bright]
      black   = '#72696a'
      red     = '#fd6883'
      green   = '#adda78'
      yellow  = '#f9cc6c'
      blue    = '#f38d70'
      magenta = '#a8a9eb'
      cyan    = '#85dacc'
      white   = '#fff1f3'
    '';
    ".config/alacritty/colorschemes.d/yml/monokai-pro.yml".text = ''
    schemes:
      monokai_pro:  &monokai_pro
        # Default colors
        primary:
          background: '#2D2A2E'
          foreground: '#FCFCFA'
        # Normal colors
        normal:
          black:   '#403E41'
          red:     '#FF6188'
          green:   '#A9DC76'
          yellow:  '#FFD866'
          blue:    '#FC9867'
          magenta: '#AB9DF2'
          cyan:    '#78DCE8'
          white:   '#FCFCFA'
        # Bright colors
        bright:
          black:   '#727072'
          red:     '#FF6188'
          green:   '#A9DC76'
          yellow:  '#FFD866'
          blue:    '#FC9867'
          magenta: '#AB9DF2'
          cyan:    '#78DCE8'
          white:   '#FCFCFA'
    colors:  *monokai_pro
    '';
    ".config/alacritty/colorschemes.d/yml/monokai-soda.yml".text = ''
    schemes:
      monokai_soda:  &monokai_soda
        # Default colors
        primary:
          background: '#1a1a1a'
          foreground: '#c4c5b5'
        # Normal colors
        normal:
          black:   '#1a1a1a'
          red:     '#f4005f'
          green:   '#98e024'
          yellow:  '#fa8419'
          blue:    '#9d65ff'
          magenta: '#f4005f'
          cyan:    '#58d1eb'
          white:   '#c4c5b5'
        # Bright colors
        bright:
          black:   '#625e4c'
          red:     '#f4005f'
          green:   '#98e024'
          yellow:  '#e0d561'
          blue:    '#9d65ff'
          magenta: '#f4005f'
          cyan:    '#58d1eb'
          white:   '#f6f6ef'
    colors:  *monokai_soda
    '';
    ".config/alacritty/colorschemes.d/yml/monokai.yml".text = ''
    schemes:
      monokai:  &monokai
        # Default colors
        primary:
          background: '#272822'
          foreground: '#F8F8F2'
        # Normal colors
        normal:
         black:   '#272822'
         red:     '#F92672'
         green:   '#A6E22E'
         yellow:  '#F4BF75'
         blue:    '#66D9EF'
         magenta: '#AE81FF'
         cyan:    '#A1EFE4'
         white:   '#F8F8F2'
        # Bright colors
        bright:
         black:   '#75715E'
         red:     '#F92672'
         green:   '#A6E22E'
         yellow:  '#F4BF75'
         blue:    '#66D9EF'
         magenta: '#AE81FF'
         cyan:    '#A1EFE4'
         white:   '#F9F8F5'
    colors:  *monokai
    '';
    ".config/alacritty/colorschemes.d/toml/moonlight-ii-vscode.toml".text = ''
      [colors.primary]
      background = '#1e2030'
      foreground = '#7f85a3'

      [colors.cursor]
      text   = '#7f85a3'
      cursor = '#808080'

      [colors.normal]
      black   = '#444a73'
      red     = '#ff5370'
      green   = '#4fd6be'
      yellow  = '#ffc777'
      blue    = '#3e68d7'
      magenta = '#fc7b7b'
      cyan    = '#86e1fc'
      white   = '#d0d0d0'

      [colors.bright]
      black   = '#828bb8'
      red     = '#ff98a4'
      green   = '#c3e88d'
      yellow  = '#ffc777'
      blue    = '#82aaff'
      magenta = '#ff966c'
      cyan    = '#b4f9f8'
      white   = '#5f8787'
    '';
    ".config/alacritty/colorschemes.d/toml/msx.toml".text = ''
      # Colors (MSX-like)
      # Notice that MSX used blue as background so [bright] blue and [bright] black
      # are reversed in this theme. Also MSX had only 15 colors (color 0 was
      # transparent) so 'gray' (#CCCCCC) is used two times both as white and
      # bright black.

      # Default colors
      [colors.primary]
      background = '#5955E0'
      foreground = '#FFFFFF'

      # Normal colors
      [colors.normal]
      # It is 'dark blue' not black
      black = '#5955E0'
      red = '#B95E51'
      green = '#3AA241'
      yellow = '#CCC35E'
      # It is 'black' not blue
      blue = '#000000'
      # It is 'medium red' not magenta
      magenta = '#DB6559'
      # It is 'medium green' not cyan
      cyan = '#3EB849'
      # It is 'gray' not white
      white = '#CCCCCC'

      # Bright colors
      [colors.bright]
      # It is 'light blue' not bright black
      black = '#8076F1'
      red = '#FF897D'
      green = '#74D07D'
      yellow = '#DED087'
      # It is 'gray' not bright blue
      blue = '#CCCCCC'
      # It is 'magenta' not bright magenta
      magenta = '#B766B5'
      # It is 'cyan' not bright cyan
      cyan = '#65DBEF'
      white = '#FFFFFF'
    '';
    ".config/alacritty/colorschemes.d/yml/new-moon.yml".text = ''
    schemes:
      new_moon:  &new_moon
        # Default colors
        primary:
          background: '#2D2D2D'
          foreground: '#B3B9C5'
        # Normal colors
        normal:
          black: '#2D2D2D'
          red: '#F2777A'
          green: '#92D192'
          yellow: '#FFD479'
          blue: '#6AB0F3'
          magenta: '#E1A6F2'
          cyan: '#76D4D6'
          white: '#B3B9C5'
        # Bright colors
        bright:
          black: '#777C85'
          red: '#F2777A'
          green: '#76D4D6'
          yellow: '#FFEEA6'
          blue: '#6AB0F3'
          magenta: '#E1A6F2'
          cyan: '#76D4D6'
          white: '#FFFFFF'
    colors:  *new_moon
    '';
    ".config/alacritty/colorschemes.d/yml/nightfly.yml".text = ''
    schemes:
      nightfly:  &nightfly
         # Default colors
        primary:
           background: '#011627'
           foreground: '#acb4c2'
        cursor:
          text: '#fafafa'
          cursor: '#9ca1aa'
        selection:
          text: '#080808'
          background: '#b2ceee'
         # Normal colors
        normal:
          black:   '#1d3b53'
          red:     '#fc514e'
          green:   '#a1cd5e'
          yellow:  '#e3d18a'
          blue:    '#82aaff'
          magenta: '#c792ea'
          cyan:    '#7fdbca'
          white:   '#a1aab8'
         # Bright colors
        bright:
          black:   '#7c8f8f'
          red:     '#ff5874'
          green:   '#21c7a8'
          yellow:  '#ecc48d'
          blue:    '#82aaff'
          magenta: '#ae81ff'
          cyan:    '#7fdbca'
          white:   '#d6deeb'
    colors:  *nightfly
    '';
    ".config/alacritty/colorschemes.d/toml/nightfox.toml".text = ''
      # Colors (NightFox)

      # Default colors
      [colors.primary]
      background = '#192330'
      foreground = '#cdcecf'

      # Normal colors
      [colors.normal]
      black   = '#393b44'
      red     = '#c94f6d'
      green   = '#81b29a'
      yellow  = '#dbc074'
      blue    = '#719cd6'
      magenta = '#9d79d6'
      cyan    = '#63cdcf'
      white   = '#dfdfe0'

      # Bright colors
      [colors.bright]
      black   = '#575860'
      red     = '#d16983'
      green   = '#8ebaa4'
      yellow  = '#e0c989'
      blue    = '#86abdc'
      magenta = '#baa1e2'
      cyan    = '#7ad5d6'
      white   = '#e4e4e5'
    '';
    ".config/alacritty/colorschemes.d/toml/night-owlish-light.toml".text = ''
      # Colors (Night Owlish Light)

      [colors.primary]
      background = '#ffffff'
      foreground = '#403f53'

      [colors.normal]
      black = '#011627'
      red = '#d3423e'
      green = '#2aa298'
      yellow = '#daaa01'
      blue = '#4876d6'
      magenta = '#403f53'
      cyan = '#08916a'
      white = '#7a8181'

      [colors.bright]
      black = '#7a8181'
      red = '#f76e6e'
      green = '#49d0c5'
      yellow = '#dac26b'
      blue = '#5ca7e4'
      magenta = '#697098'
      cyan = '#00c990'
      white = '#989fb1'

      [colors.cursor]
      cursor = '#403f53'
      text = '#fbfbfb'

      [colors.selection]
      background = '#f2f2f2'
      text = '#403f53'
    '';
    ".config/alacritty/colorschemes.d/yml/night-owl.yml".text = ''
    schemes:
      night_owl:  &night_owl
         # Default colors
        primary:
          background: '#011627'
          foreground: '#d6deeb'
        cursor:
          text: '#011627'
          cursor: '#d6deeb'
        selection:
          background: '#1b90dd'
         # Normal colors
        normal:
          black:   '#011627'
          red:     '#ef5350'
          green:   '#22da6e'
          yellow:  '#c5e478'
          blue:    '#82aaff'
          magenta: '#c792ea'
          cyan:    '#21c7a8'
          white:   '#ffffff'
         # Bright colors
        bright:
          black:   '#575656'
          red:     '#ef5350'
          green:   '#22da6e'
          yellow:  '#ffeb95'
          blue:    '#82aaff'
          magenta: '#c792ea'
          cyan:    '#7fdbca'
          white:   '#ffffff'
    colors:  *night_owl
    '';
    ".config/alacritty/colorschemes.d/toml/noctis-lux.toml".text = ''
      # Colors (NoctixLux)

      # Default colors
      [colors.primary]
      background = '#fef8ec'
      foreground = '#005661'

      # Normal colors
      [colors.normal]
      black = '#003b42'
      red = '#e34e1c'
      green = '#00b368'
      yellow = '#f49725'
      blue = '#0094f0'
      magenta = '#ff5792'
      cyan = '#00bdd6'
      white = '#8ca6a6'

      # Bright colors
      [colors.bright]
      black = '#004d57'
      red = '#ff4000'
      green = '#00d17a'
      yellow = '#ff8c00'
      blue = '#0fa3ff'
      magenta = '#ff6b9f'
      cyan = '#00cbe6'
      white = '#bbc3c4'
    '';
    ".config/alacritty/colorschemes.d/toml/nordic.toml".text = ''
      # Colors (Nordic)

      [colors.primary]
      background = '#242933'
      foreground = '#BBBDAF'

      [colors.normal]
      black = '#191C1D'
      red = '#BD6062'
      green = '#A3D6A9'
      yellow = '#F0DFAF'
      blue = '#8FB4D8'
      magenta = '#C7A9D9'
      cyan = '#B6D7A8'
      white = '#BDC5BD'

      [colors.bright]
      black = '#727C7C'
      red = '#D18FAF'
      green = '#B7CEB0'
      yellow = '#BCBCBC'
      blue = '#E0CF9F'
      magenta = '#C7A9D9'
      cyan = '#BBDA97'
      white = '#BDC5BD'

      [colors.selection]
      text = '#000000'
      background = '#F0DFAF'
    '';
    ".config/alacritty/colorschemes.d/toml/nord-light.toml".text = ''
      # Colors (Nord light) theme based on https//github.com/nordtheme/alacritty/issues/28#issuecomment-1422225211

      # Default colors
      [colors.primary]
      background = '#ECEFF4'
      foreground = '#81A1C1'

      # Normal colors
      [colors.normal]
      black   = '#D8DEE9'
      red     = '#bf616a'
      green   = '#a3be8c'
      yellow  = '#D08770'
      blue    = '#81A1C1'
      magenta = '#B48EAD'
      cyan    = '#88C0D0'
      white   = '#4C566A'

      # Bright colors
      [colors.bright]
      black   = '#D8DEE9'
      red     = '#bf616a'
      green   = '#a3be8c'
      yellow  = '#D08770'
      blue    = '#D8DEE9'
      magenta = '#B48EAD'
      cyan    = '#8FBCBB'
      white   = '#D8DEE9'
    '';
    ".config/alacritty/colorschemes.d/toml/nord.toml".text = ''
      # Colors (Nord)

      # Default colors
      [colors.primary]
      background = '#2E3440'
      foreground = '#D8DEE9'

      # Normal colors
      [colors.normal]
      black   = '#3B4252'
      red     = '#BF616A'
      green   = '#A3BE8C'
      yellow  = '#EBCB8B'
      blue    = '#81A1C1'
      magenta = '#B48EAD'
      cyan    = '#88C0D0'
      white   = '#E5E9F0'

      # Bright colors
      [colors.bright]
      black   = '#4C566A'
      red     = '#BF616A'
      green   = '#A3BE8C'
      yellow  = '#EBCB8B'
      blue    = '#81A1C1'
      magenta = '#B48EAD'
      cyan    = '#8FBCBB'
      white   = '#ECEFF4'
    '';
    ".config/alacritty/colorschemes.d/yml/nord.yml".text = ''
    schemes:
      nord:  &nord
         # Default colors
         primary:
           background: '#2E3440'
           foreground: '#D8DEE9'
         # Normal colors
         normal:
           black:   '#3B4252'
           red:     '#BF616A'
           green:   '#A3BE8C'
           yellow:  '#EBCB8B'
           blue:    '#81A1C1'
           magenta: '#B48EAD'
           cyan:    '#88C0D0'
           white:   '#E5E9F0'
         # Bright colors
         bright:
           black:   '#4C566A'
           red:     '#BF616A'
           green:   '#A3BE8C'
           yellow:  '#EBCB8B'
           blue:    '#81A1C1'
           magenta: '#B48EAD'
           cyan:    '#8FBCBB'
           white:   '#ECEFF4'
    colors:  *nord
    '';
    ".config/alacritty/colorschemes.d/yml/nova.yml".text = ''
    schemes:
      nova:  &nova
        # Default colors
        primary:
          background: '#3C4C55'
          foreground: '#C5D4DD'
        cursor:
          text: '#212121'
          cursor: '#C0C5CE'
        # Normal colors
        normal:
          black:   '#3C4C55'
          red:     '#DF8C8C'
          green:   '#A8CE93'
          yellow:  '#DADA93'
          blue:    '#83AFE5'
          magenta: '#9A93E1'
          cyan:    '#7FC1CA'
          white:   '#C5D4DD'
        # Bright colors
        bright:
          black:   '#899BA6'
          red:     '#F2C38F'
          green:   '#A8CE93'
          yellow:  '#DADA93'
          blue:    '#83AFE5'
          magenta: '#D18EC2'
          cyan:    '#7FC1CA'
          white:   '#E6EEF3'
    colors:  *nova
    '';
    ".config/alacritty/colorschemes.d/toml/oceanic-next.toml".text = ''
      # Colors (Oceanic Next)

      # Default colors
      [colors.primary]
      background = '#1b2b34'
      foreground = '#d8dee9'

      # Normal colors
      [colors.normal]
      black   = '#29414f'
      red     = '#ec5f67'
      green   = '#99c794'
      yellow  = '#fac863'
      blue    = '#6699cc'
      magenta = '#c594c5'
      cyan    = '#5fb3b3'
      white   = '#65737e'

      # Bright colors
      [colors.bright]
      black   = '#405860'
      red     = '#ec5f67'
      green   = '#99c794'
      yellow  = '#fac863'
      blue    = '#6699cc'
      magenta = '#c594c5'
      cyan    = '#5fb3b3'
      white   = '#adb5c0'
    '';
    ".config/alacritty/colorschemes.d/yml/oceanic-next.yml".text = ''
    schemes:
      oceanic_next:  &oceanic_next
        # Default colors
        primary:
          background: '#1b2b34'
          foreground: '#d8dee9'
        # Colors the cursor will use if `custom_cursor_colors` is true
        cursor:
          text: '#1b2b34'
          cursor: '#ffffff'
        # Normal colors
        normal:
          black:   '#343d46'
          red:     '#EC5f67'
          green:   '#99C794'
          yellow:  '#FAC863'
          blue:    '#6699cc'
          magenta: '#c594c5'
          cyan:    '#5fb3b3'
          white:   '#d8dee9'
        # Bright colors
        bright:
          black:   '#343d46'
          red:     '#EC5f67'
          green:   '#99C794'
          yellow:  '#FAC863'
          blue:    '#6699cc'
          magenta: '#c594c5'
          cyan:    '#5fb3b3'
          white:   '#d8dee9'
    colors:  *oceanic_next
    '';
    ".config/alacritty/colorschemes.d/toml/omni.toml".text = ''
      [colors.primary]
      background = '#191622'
      foreground = '#e1e1e6'

      [colors.cursor]
      text = '#191622'
      cursor = '#f8f8f2'

      [colors.normal]
      black = '#000000'
      red = '#ff5555'
      green = '#50fa7b'
      yellow = '#effa78'
      blue = '#bd93f9'
      magenta = '#ff79c6'
      cyan = '#8d79ba'
      white = '#bfbfbf'

      [colors.bright]
      black = '#4d4d4d'
      red = '#ff6e67'
      green = '#5af78e'
      yellow = '#eaf08d'
      blue = '#caa9fa'
      magenta = '#ff92d0'
      cyan = '#aa91e3'
      white = '#e6e6e6'

      [colors.dim]
      black = '#000000'
      red = '#a90000'
      green = '#049f2b'
      yellow = '#a3b106'
      blue = '#530aba'
      magenta = '#bb006b'
      cyan = '#433364'
      white = '#5f5f5f'
    '';
    ".config/alacritty/colorschemes.d/toml/onedark.toml".text = ''
      # Colors (One Dark)

      # Default colors
      [colors.primary]
      background = '#282c34'
      foreground = '#abb2bf'

      # Normal colors
      [colors.normal]
      black   = '#1e2127'
      red     = '#e06c75'
      green   = '#98c379'
      yellow  = '#d19a66'
      blue    = '#61afef'
      magenta = '#c678dd'
      cyan    = '#56b6c2'
      white   = '#abb2bf'

      # Bright colors
      [colors.bright]
      black   = '#5c6370'
      red     = '#e06c75'
      green   = '#98c379'
      yellow  = '#d19a66'
      blue    = '#61afef'
      magenta = '#c678dd'
      cyan    = '#56b6c2'
      white   = '#ffffff'
    '';
    ".config/alacritty/colorschemes.d/yml/one-dark.yml".text = ''
    schemes:
      one_dark:  &one_dark
        # Default colors
        primary:
          background: '#1b2b34'
          foreground: '#d8dee9'
        # Colors the cursor will use if `custom_cursor_colors` is true
        cursor:
          text: '#1b2b34'
          cursor: '#ffffff'
        # Normal colors
        normal:
          black:   '#343d46'
          red:     '#EC5f67'
          green:   '#99C794'
          yellow:  '#FAC863'
          blue:    '#6699cc'
          magenta: '#c594c5'
          cyan:    '#5fb3b3'
          white:   '#d8dee9'
        # Bright colors
        bright:
          black:   '#343d46'
          red:     '#EC5f67'
          green:   '#99C794'
          yellow:  '#FAC863'
          blue:    '#6699cc'
          magenta: '#c594c5'
          cyan:    '#5fb3b3'
          white:   '#d8dee9'
    colors:  *one_dark
    '';
    ".config/alacritty/colorschemes.d/yml/one-light.yml".text = ''
    schemes:
      one_light:  &one_light
        primary:
          background: '#fafafa'
          foreground: '#383a42'
        cursor:
          text:       CellBackground
          cursor:     '#526eff' # syntax-cursor-color
        selection:
          text:       CellForeground
          background: '#e5e5e6' # syntax-selection-color
        normal:
          black:      '#696c77' # mono-2
          red:        '#e45649' # red 1
          green:      '#50a14f'
          yellow:     '#c18401' # orange 2
          blue:       '#4078f2'
          magenta:    '#a626a4'
          cyan:       '#0184bc'
          white:      '#a0a1a7' # mono-3
    colors:  *one_light
    '';
    ".config/alacritty/colorschemes.d/yml/oxide.yml".text = ''
    schemes:
      oxide:  &oxide
        # Default colors
        primary:
          background: '#212121'
          foreground: '#c0c5ce'
          bright_foreground: '#f3f4f5'
        cursor:
          text: '#212121'
          cursor: '#c0c5ce'
        # Normal colors
        normal:
          black:   '#212121'
          red:     '#e57373'
          green:   '#a6bc69'
          yellow:  '#fac863'
          blue:    '#6699cc'
          magenta: '#c594c5'
          cyan:    '#5fb3b3'
          white:   '#c0c5ce'
        # Bright colors
        bright:
          black:   '#5c5c5c'
          red:     '#e57373'
          green:   '#a6bc69'
          yellow:  '#fac863'
          blue:    '#6699cc'
          magenta: '#c594c5'
          cyan:    '#5fb3b3'
          white:   '#f3f4f5'
    colors:  *oxide
    '';
    ".config/alacritty/colorschemes.d/yml/panda.yml".text = ''
    schemes:
      panda:  &panda
        primary:
          background: '#292A2B'
          foreground: '#E6E6E6'
        normal:
          black:   '#292A2B'
          red:     '#FF2C6D'
          green:   '#19f9d8'
          yellow:  '#FFB86C'
          blue:    '#45A9F9'
          magenta: '#FF75B5'
          cyan:    '#67d3c2'
          orange:  '#B084EB'
          white:   '#E6E6E6'
        bright:
          black:   '#292A2B'
          red:     '#FF2C6D'
          green:   '#19f9d8'
          yellow:  '#ffcc95'
          blue:    '#6FC1FF'
          magenta: '#FF9AC1'
          cyan:    '#67d3c2'
          white:   '#ffffff'
    colors:  *panda
    '';
    ".config/alacritty/colorschemes.d/toml/palenight.toml".text = ''
      # iTerm2 Material Design - Palenight theme for Alacritty
      # Source  https//github.com/JonathanSpeek/palenight-iterm2

      # Default colors
      [colors.primary]
      background = '#292d3e'
      foreground = '#d0d0d0'

      # Normal colors
      [colors.normal]
      black   = '#292d3e'
      red     = '#f07178'
      green   = '#c3e88d'
      yellow  = '#ffcb6b'
      blue    = '#82aaff'
      magenta = '#c792ea'
      cyan    = '#89ddff'
      white   = '#d0d0d0'

      # Bright colors
      [colors.bright]
      black   = '#434758'
      red     = '#ff8b92'
      green   = '#ddffa7'
      yellow  = '#ffe585'
      blue    = '#9cc4ff'
      magenta = '#e1acff'
      cyan    = '#a3f7ff'
      white   = '#ffffff'
    '';
    ".config/alacritty/colorschemes.d/toml/papercolor-dark.toml".text = ''
      # Colors (PaperColor - Dark)

      # Default colors
      [colors.primary]
      background = '#1c1c1c'
      foreground = '#808080'

      [colors.cursor]
      text = '#1c1c1c'
      cursor = '#808080'

      # Normal colors
      [colors.normal]
      black   = '#1c1c1c'
      red     = '#af005f'
      green   = '#5faf00'
      yellow  = '#d7af5f'
      blue    = '#5fafd7'
      magenta = '#808080'
      cyan    = '#d7875f'
      white   = '#d0d0d0'

      # Bright colors
      [colors.bright]
      black   = '#585858'
      red     = '#5faf5f'
      green   = '#afd700'
      yellow  = '#af87d7'
      blue    = '#ffaf00'
      magenta = '#ffaf00'
      cyan    = '#00afaf'
      white   = '#5f8787'
    '';
    ".config/alacritty/colorschemes.d/toml/papercolor-light.toml".text = ''
      # Colors (PaperColor - Light)

      # Default colors
      [colors.primary]
      background = '#eeeeee'
      foreground = '#444444'

      [colors.cursor]
      text = '#eeeeee'
      cursor = '#444444'

      # Normal colors
      [colors.normal]
      black   = '#eeeeee'
      red     = '#af0000'
      green   = '#008700'
      yellow  = '#5f8700'
      blue    = '#0087af'
      magenta = '#878787'
      cyan    = '#005f87'
      white   = '#444444'

      # Bright colors
      [colors.bright]
      black   = '#bcbcbc'
      red     = '#d70000'
      green   = '#d70087'
      yellow  = '#8700af'
      blue    = '#d75f00'
      magenta = '#d75f00'
      cyan    = '#005faf'
      white   = '#005f87'
    '';
    ".config/alacritty/colorschemes.d/toml/papertheme.toml".text = ''
      # Colors (Paper Theme)

      # Default colors
      [colors.primary]
      background = '#F2EEDE'
      foreground = '#000000'

      # Normal colors
      [colors.normal]
      black   = '#000000'
      red     = '#CC3E28'
      green   = '#216609'
      yellow  = '#B58900'
      blue    = '#1E6FCC'
      magenta = '#5C21A5'
      cyan    = '#158C86'
      white   = '#AAAAAA'

      # Bright colors
      [colors.bright]
      black   = '#555555'
      red     = '#CC3E28'
      green   = '#216609'
      yellow  = '#B58900'
      blue    = '#1E6FCC'
      magenta = '#5C21A5'
      cyan    = '#158C86'
      white   = '#AAAAAA'
    '';
    ".config/alacritty/colorschemes.d/yml/pear-dark-blue.yml".text = ''
    schemes:
      pear_dark_blue:  &pear_dark_blue
        # Default colors
        primary:
          background: '#222226'
          foreground: '#ffffff'
        # Normal colors
        normal:
          black: '#222226'
          red: '#f841a0' # Uses magenta instead.
          green: '#25c141'
          yellow: '#fdf454'
          blue: '#2f9ded'
          magenta: '#f97137' # Uses orange instead.
          cyan: '#19cde6'
          white: '#ffffff'
        # Bright colors
        bright:
          black: '#969696'
          red: '#f6188f' # Uses magenta instead.
          green: '#1ebb2b'
          yellow: '#fdf834'
          blue: '#2186ec'
          magenta: '#f85a21' # Uses orange instead.
          cyan: '#12c3e2'
          white: '#ffffff'
    colors:  *pear_dark_blue
    '';
    ".config/alacritty/colorschemes.d/toml/pencil-dark.toml".text = ''
      # Colors (Pencil Dark)

      # Default Colors
      [colors.primary]
      background = '#212121'
      foreground = '#f1f1f1'

      # Normal colors
      [colors.normal]
      black   = '#212121'
      red     = '#c30771'
      green   = '#10a778'
      yellow  = '#a89c14'
      blue    = '#008ec4'
      magenta = '#523c79'
      cyan    = '#20a5ba'
      white   = '#e0e0e0'

      # Bright colors
      [colors.bright]
      black   = '#818181'
      red     = '#fb007a'
      green   = '#5fd7af'
      yellow  = '#f3e430'
      blue    = '#20bbfc'
      magenta = '#6855de'
      cyan    = '#4fb8cc'
      white   = '#f1f1f1'
    '';
    ".config/alacritty/colorschemes.d/yml/pencil-dark.yml".text = ''
    schemes:
      pencil_dark:  &pencil_dark
        # Default Colors
        primary:
          background: '#212121'
          foreground: '#f1f1f1'
        # Normal colors
        normal:
          black:   '#212121'
          red:     '#c30771'
          green:   '#10a778'
          yellow:  '#a89c14'
          blue:    '#008ec4'
          magenta: '#523c79'
          cyan:    '#20a5ba'
          white:   '#e0e0e0'
        # Bright colors
        bright:
          black:   '#212121'
          red:     '#fb007a'
          green:   '#5fd7af'
          yellow:  '#f3e430'
          blue:    '#20bbfc'
          magenta: '#6855de'
          cyan:    '#4fb8cc'
          white:   '#f1f1f1'
    colors:  *pencil_dark
    '';
    ".config/alacritty/colorschemes.d/toml/pencil-light.toml".text = ''
      # Colors (Pencil Light)

      # Default Colors
      [colors.primary]
      background = '#f1f1f1'
      foreground = '#424242'

      # Normal colors
      [colors.normal]
      black   = '#212121'
      red     = '#c30771'
      green   = '#10a778'
      yellow  = '#a89c14'
      blue    = '#008ec4'
      magenta = '#523c79'
      cyan    = '#20a5ba'
      white   = '#e0e0e0'

      # Bright colors
      [colors.bright]
      black   = '#212121'
      red     = '#fb007a'
      green   = '#5fd7af'
      yellow  = '#f3e430'
      blue    = '#20bbfc'
      magenta = '#6855de'
      cyan    = '#4fb8cc'
      white   = '#f1f1f1'
    '';
    ".config/alacritty/colorschemes.d/yml/pencil-light.yml".text = ''
    schemes:
      pencil_light:  &pencil_light
        # Default Colors
        primary:
          background: '#f1f1f1'
          foreground: '#424242'
        # Normal colors
        normal:
          black:   '#212121'
          red:     '#c30771'
          green:   '#10a778'
          yellow:  '#a89c14'
          blue:    '#008ec4'
          magenta: '#523c79'
          cyan:    '#20a5ba'
          white:   '#e0e0e0'
        # Bright colors
        bright:
          black:   '#212121'
          red:     '#fb007a'
          green:   '#5fd7af'
          yellow:  '#f3e430'
          blue:    '#20bbfc'
          magenta: '#6855de'
          cyan:    '#4fb8cc'
          white:   '#f1f1f1'
    colors:  *pencil_light
    '';
    ".config/alacritty/colorschemes.d/toml/pop-os.toml".text = ''
      [colors.bright]
      black = "#88807C"
      blue = "#48B9C7"
      cyan = "#34E2E2"
      green = "#73C48F"
      magenta = "#AD7FA8"
      red = "#F15D22"
      white = "#EEEEEC"
      yellow = "#FFCE51"

      [colors.normal]
      black = "#333333"
      blue = "#3465A4"
      cyan = "#06989A"
      green = "#4E9A06"
      magenta = "#75507B"
      red = "#CC0000"
      white = "#D3D7CF"
      yellow = "#C4A000"

      [colors.primary]
      background = "#333333"
      foreground = "#F2F2F2"

      [schemes.pop_os.bright]
      black = "#88807C"
      blue = "#48B9C7"
      cyan = "#34E2E2"
      green = "#73C48F"
      magenta = "#AD7FA8"
      red = "#F15D22"
      white = "#EEEEEC"
      yellow = "#FFCE51"

      [schemes.pop_os.normal]
      black = "#333333"
      blue = "#3465A4"
      cyan = "#06989A"
      green = "#4E9A06"
      magenta = "#75507B"
      red = "#CC0000"
      white = "#D3D7CF"
      yellow = "#C4A000"

      [schemes.pop_os.primary]
      background = "#333333"
      foreground = "#F2F2F2"
    '';
    ".config/alacritty/colorschemes.d/yml/pop-os.yml".text = ''
      schemes:
        pop_os:  &pop_os
          # Default colors
          primary:
            background: '#333333'
            foreground: '#F2F2F2'
          # Normal colors
          normal:
            black:   '#333333'
            red:     '#CC0000'
            green:   '#4E9A06'
            yellow:  '#C4A000'
            blue:    '#3465A4'
            magenta: '#75507B'
            cyan:    '#06989A'
            white:   '#D3D7CF'
          # Bright colors
          bright:
            black:   '#88807C'
            red:     '#F15D22'
            green:   '#73C48F'
            yellow:  '#FFCE51'
            blue:    '#48B9C7'
            magenta: '#AD7FA8'
            cyan:    '#34E2E2'
            white:   '#EEEEEC'
      colors:  *pop_os
    '';
    ".config/alacritty/colorschemes.d/toml/rainbow.toml".text = ''
      # Default colors
      [colors.primary]
      background = '#192835'
      foreground = '#AADA4F'

      # Normal colors
      [colors.normal]
      black   = '#5B4375'
      red     = '#426bb6'
      green   = '#2286b5'
      yellow  = '#5ab782'
      blue    = '#93ca5b'
      magenta = '#c6c842'
      cyan    = '#8a5135'
      white   = '#c54646'

      # Bright colors
      [colors.bright]
      black   = '#5B4375'
      red     = '#426bb6'
      green   = '#2286b5'
      yellow  = '#5ab782'
      blue    = '#93ca5b'
      magenta = '#c6c842'
      cyan    = '#8a5135'
      white   = '#c54646'
    '';
    ".config/alacritty/colorschemes.d/toml/remedy-dark.toml".text = ''
      # Default colors
      [colors.primary]
      background = '#2c2b2a'
      foreground = '#f9e7c4'

      dim_foreground    = '#685E4A'
      bright_foreground = '#1C1508'

      # Normal colors
      [colors.normal]
      black   = '#282a2e'
      red     = '#a54242'
      green   = '#8c9440'
      yellow  = '#de935f'
      blue    = '#5f819d'
      magenta = '#85678f'
      cyan    = '#5e8d87'
      white   = '#707880'

      # Bright colors
      [colors.bright]
      black   = '#373b41'
      red     = '#cc6666'
      green   = '#b5bd68'
      yellow  = '#f0c674'
      blue    = '#81a2be'
      magenta = '#b294bb'
      cyan    = '#8abeb7'
      white   = '#c5c8c6'
    '';
    ".config/alacritty/colorschemes.d/toml/rose-pine-dawn.toml".text = ''
      [colors.primary]
      background = '#faf4ed'
      foreground = '#575279'

      [colors.cursor]
      text = '#575279'
      cursor = '#cecacd'

      [colors.vi_mode_cursor]
      text = '#575279'
      cursor = '#cecacd'

      [colors.selection]
      text = '#575279'
      background = '#dfdad9'

      [colors.normal]
      black = '#f2e9e1'
      red = '#b4637a'
      green = '#286983'
      yellow = '#ea9d34'
      blue = '#56949f'
      magenta = '#907aa9'
      cyan = '#d7827e'
      white = '#575279'

      [colors.bright]
      black = '#9893a5'
      red = '#b4637a'
      green = '#286983'
      yellow = '#ea9d34'
      blue = '#56949f'
      magenta = '#907aa9'
      cyan = '#d7827e'
      white = '#575279'

      [colors.hints]
      start = { foreground = '#797593', background = '#fffaf3' }
      end = { foreground = '#9893a5', background = '#fffaf3' }
    '';
    ".config/alacritty/colorschemes.d/toml/rose-pine-moon.toml".text = ''
      [colors.primary]
      background = '#232136'
      foreground = '#e0def4'

      [colors.cursor]
      text = '#e0def4'
      cursor = '#56526e'

      [colors.vi_mode_cursor]
      text = '#e0def4'
      cursor = '#56526e'

      [colors.selection]
      text = '#e0def4'
      background = '#44415a'
      [colors.normal]
      black = '#393552'
      red = '#eb6f92'
      green = '#3e8fb0'
      yellow = '#f6c177'
      blue = '#9ccfd8'
      magenta = '#c4a7e7'
      cyan = '#ea9a97'
      white = '#e0def4'

      [colors.bright]
      black = '#6e6a86'
      red = '#eb6f92'
      green = '#3e8fb0'
      yellow = '#f6c177'
      blue = '#9ccfd8'
      magenta = '#c4a7e7'
      cyan = '#ea9a97'
      white = '#e0def4'

      [colors.hints]
      start = { foreground = '#908caa', background = '#2a273f' }
      end = { foreground = '#6e6a86', background = '#2a273f' }
    '';
    ".config/alacritty/colorschemes.d/toml/rose-pine.toml".text = ''
      [colors.primary]
      background = '#191724'
      foreground = '#e0def4'

      [colors.cursor]
      text = '#e0def4'
      cursor = '#524f67'

      [colors.vi_mode_cursor]
      text = '#e0def4'
      cursor = '#524f67'

      [colors.selection]
      text = '#e0def4'
      background = '#403d52'

      [colors.normal]
      black = '#26233a'
      red = '#eb6f92'
      green = '#31748f'
      yellow = '#f6c177'
      blue = '#9ccfd8'
      magenta = '#c4a7e7'
      cyan = '#ebbcba'
      white = '#e0def4'

      [colors.bright]
      black = '#6e6a86'
      red = '#eb6f92'
      green = '#31748f'
      yellow = '#f6c177'
      blue = '#9ccfd8'
      magenta = '#c4a7e7'
      cyan = '#ebbcba'
      white = '#e0def4'

      [colors.hints]
      start = {foreground = '#908caa', background = '#1f1d2e' }
      end = { foreground = '#6e6a86', background = '#1f1d2e' }
    '';
    ".config/alacritty/colorschemes.d/yml/seabird.yml".text = ''
    schemes:
      seabird:  &seabird
        # Default colors
        primary:
          background: '#ffffff'
          foreground: '#61707a'
        # Default colors
        normal:
          black:   '#0b141a'
          red:     '#ff4053'
          green:   '#11ab00'
          yellow:  '#bf8c00'
          blue:    '#0099ff'
          magenta: '#9854ff'
          cyan:    '#00a5ab'
          white:   '#ffffff'
        # Bright colors
        bright:
          black:   '#0b141a'
          red:     '#ff4053'
          green:   '#11ab00'
          yellow:  '#bf8c00'
          blue:    '#0099ff'
          magenta: '#9854ff'
          cyan:    '#00a5ab'
          white:   '#ffffff'
    colors:  *seabird
    '';
    ".config/alacritty/colorschemes.d/yml/seoul256.yml".text = ''
    schemes:
      seoul256:  &seoul256
        # Default colors
        primary:
          background: '#3a3a3a'
          foreground: '#d0d0d0'
        # Normal colors
        normal:
          black:   '#4e4e4e'
          red:     '#d68787'
          green:   '#5f865f'
          yellow:  '#d8af5f'
          blue:    '#85add4'
          magenta: '#d7afaf'
          cyan:    '#87afaf'
          white:   '#d0d0d0'
        # Bright colors
        bright:
          black:   '#626262'
          red:     '#d75f87'
          green:   '#87af87'
          yellow:  '#ffd787'
          blue:    '#add4fb'
          magenta: '#ffafaf'
          cyan:    '#87d7d7'
          white:   '#e4e4e4'
    colors:  *seoul256
    '';
    ".config/alacritty/colorschemes.d/toml/seashells.toml".text = ''
      # Colors (SeaShells)
      # Source  https//raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/SeaShells.itermcolors

      # Default colors
      [colors.primary]
      background = '#061923'
      foreground = '#e5c49e'

      [colors.cursor]
      text = '#061822'
      cursor = '#feaf3c'

      [colors.selection]
      text = '#ffe9d7'
      background = '#265b75'

      # Normal colors
      [colors.normal]
      black = '#1d485f'
      red = '#db662d'
      green = '#008eab'
      yellow = '#feaf3c'
      blue = '#255a62'
      magenta = '#77dbf4'
      cyan = '#5fb1c2'
      white = '#e5c49e'

      # Bright colors
      [colors.bright]
      black = '#545d65'
      red = '#dd998a'
      green = '#739da8'
      yellow = '#fedaae'
      blue = '#0bc7e3'
      magenta = '#c6e8f1'
      cyan = '#97b9c0'
      white = '#ffe9d7'
    '';
    ".config/alacritty/colorschemes.d/toml/snazzy.toml".text = ''
      # Colors (Snazzy)

      # Default colors
      [colors.primary]
      background = '#282a36'
      foreground = '#eff0eb'

      # Normal colors
      [colors.normal]
      black   = '#282a36'
      red     = '#ff5c57'
      green   = '#5af78e'
      yellow  = '#f3f99d'
      blue    = '#57c7ff'
      magenta = '#ff6ac1'
      cyan    = '#9aedfe'
      white   = '#f1f1f0'

      # Bright colors
      [colors.bright]
      black   = '#686868'
      red     = '#ff5c57'
      green   = '#5af78e'
      yellow  = '#f3f99d'
      blue    = '#57c7ff'
      magenta = '#ff6ac1'
      cyan    = '#9aedfe'
      white   = '#f1f1f0'
    '';
    ".config/alacritty/colorschemes.d/yml/snazzy.yml".text = ''
    schemes:
      snazzy:  &snazzy
        # Default colors
        primary:
          background: '#282a36'
          foreground: '#eff0eb'
        # Normal colors
        normal:
          black:   '#282a36'
          red:     '#ff5c57'
          green:   '#5af78e'
          yellow:  '#f3f99d'
          blue:    '#57c7ff'
          magenta: '#ff6ac1'
          cyan:    '#9aedfe'
          white:   '#f1f1f0'
        # Bright colors
        bright:
          black:   '#686868'
          red:     '#ff5c57'
          green:   '#5af78e'
          yellow:  '#f3f99d'
          blue:    '#57c7ff'
          magenta: '#ff6ac1'
          cyan:    '#9aedfe'
          white:   '#f1f1f0'
    colors:  *snazzy
    '';
    ".config/alacritty/colorschemes.d/toml/solarized-dark.toml".text = ''
      # Colors (Solarized Dark)

      # Default colors
      [colors.primary]
      background = '#002b36'
      foreground = '#839496'

      # Normal colors
      [colors.normal]
      black   = '#073642'
      red     = '#dc322f'
      green   = '#859900'
      yellow  = '#b58900'
      blue    = '#268bd2'
      magenta = '#d33682'
      cyan    = '#2aa198'
      white   = '#eee8d5'

      # Bright colors
      [colors.bright]
      black   = '#002b36'
      red     = '#cb4b16'
      green   = '#586e75'
      yellow  = '#657b83'
      blue    = '#839496'
      magenta = '#6c71c4'
      cyan    = '#93a1a1'
      white   = '#fdf6e3'
    '';
    ".config/alacritty/colorschemes.d/yml/solarized-dark.yml".text = ''
      schemes:
        # Solarized Dark
        solarized_dark:  &solarized_dark
          primary:
            background: '#002b36' # base03
            foreground: '#839496' # base0
          # Cursor colors
          cursor:
            text:   '#002b36' # base03
            cursor: '#839496' # base0
          # Normal colors
          normal:
            black:   '#073642' # base02
            red:     '#dc322f' # red
            green:   '#859900' # green
            yellow:  '#b58900' # yellow
            blue:    '#268bd2' # blue
            magenta: '#d33682' # magenta
            cyan:    '#2aa198' # cyan
            white:   '#eee8d5' # base2
          # Bright colors
          bright:
            black:   '#002b36' # base03
            red:     '#cb4b16' # orange
            green:   '#586e75' # base01
            yellow:  '#657b83' # base00
            blue:    '#839496' # base0
            magenta: '#6c71c4' # violet
            cyan:    '#93a1a1' # base1
            white:   '#fdf6e3' # base3
      colors:  *solarized_dark
    '';
    ".config/alacritty/colorschemes.d/toml/solarized-light.toml".text = ''
      # Colors (Solarized Light)

      # Default colors
      [colors.primary]
      background = '#fdf6e3'
      foreground = '#586e75'

      # Normal colors
      [colors.normal]
      black   = '#073642'
      red     = '#dc322f'
      green   = '#859900'
      yellow  = '#b58900'
      blue    = '#268bd2'
      magenta = '#d33682'
      cyan    = '#2aa198'
      white   = '#eee8d5'

      # Bright colors
      [colors.bright]
      black   = '#002b36'
      red     = '#cb4b16'
      green   = '#586e75'
      yellow  = '#657b83'
      blue    = '#839496'
      magenta = '#6c71c4'
      cyan    = '#93a1a1'
      white   = '#fdf6e3'
    '';
    ".config/alacritty/colorschemes.d/yml/solarized-light.yml".text = ''
    schemes:
      # Solarized Light
      solarized_light:  &solarized_light
        primary:
          background: '#fdf6e3' # base3
          foreground: '#657b83' # base00
        # Cursor colors
        cursor:
          text:   '#fdf6e3' # base3
          cursor: '#657b83' # base00
        # Normal colors
        normal:
          black:   '#073642' # base02
          red:     '#dc322f' # red
          green:   '#859900' # green
          yellow:  '#b58900' # yellow
          blue:    '#268bd2' # blue
          magenta: '#d33682' # magenta
          cyan:    '#2aa198' # cyan
          white:   '#eee8d5' # base2
        # Bright colors
        bright:
          black:   '#002b36' # base03
          red:     '#cb4b16' # orange
          green:   '#586e75' # base01
          yellow:  '#657b83' # base00
          blue:    '#839496' # base0
          magenta: '#6c71c4' # violet
          cyan:    '#93a1a1' # base1
          white:   '#fdf6e3' # base3
    colors:  *solarized_light
    '';
    ".config/alacritty/colorschemes.d/toml/smoooooth.toml".text = ''
      # Color theme ported from iTerm 2 Smoooooth

      [colors.primary]
      foreground = '#dbdbdb'
      background = '#14191e'

      [colors.cursor]
      text = '#000000'
      cursor = '#fefffe'

      [colors.selection]
      text = '#000000'
      background = '#b3d7ff'

      [colors.normal]
      black   = '#14191e'
      red     = '#b43c29'
      green   = '#00c200'
      yellow  = '#c7c400'
      blue    = '#2743c7'
      magenta = '#bf3fbd'
      cyan    = '#00c5c7'
      white   = '#c7c7c7'

      [colors.bright]
      black   = '#676767'
      red     = '#dc7974'
      green   = '#57e690'
      yellow  = '#ece100'
      blue    = '#a6aaf1'
      magenta = '#e07de0'
      cyan    = '#5ffdff'
      white   = '#feffff'
    '';
    ".config/alacritty/colorschemes.d/yml/sourcerer.yml".text = ''
    schemes:
      sourcerer:  &sourcerer
        primary:
          background: '#222222'
          foreground: '#c2c2b0'
        cursor:
          text:   '#c2c2b0'
          cursor: '#c2c2b0'
        normal:
          black:   '#111111'
          red:     '#aa4450'
          green:   '#719611'
          yellow:  '#cc8800'
          blue:    '#6688aa'
          magenta: '#8f6f8f'
          cyan:    '#528b8b'
          white:   '#d3d3d3'
        bright:
          black:   '#181818'
          red:     '#ff6a6a'
          green:   '#b1d631'
          yellow:  '#ff9800'
          blue:    '#90b0d1'
          magenta: '#8181a6'
          cyan:    '#87ceeb'
          white:   '#c1cdc1'
    colors:  *sourcerer
    '';
    ".config/alacritty/colorschemes.d/yml/spacemacs-light.yml".text = ''
    schemes:
      spacemacs_light:  &spacemacs_light
        primary:
          foreground: '#64526F'
          background: '#FAF7EE'
        cursor:
          cursor:     '#64526F'
          text:       '#FAF7EE'
        normal:
          black:      '#FAF7EE'
          red:        '#DF201C'
          green:      '#29A0AD'
          yellow:     '#DB742E'
          blue:       '#3980C2'
          magenta:    '#2C9473'
          cyan:       '#6B3062'
          white:      '#64526F'
        bright:
          black:      '#9F93A1'
          red:        '#DF201C'
          green:      '#29A0AD'
          yellow:     '#DB742E'
          blue:       '#3980C2'
          magenta:    '#2C9473'
          cyan:       '#6B3062'
          white:      '#64526F'
    colors:  *spacemacs_light
    '';
    ".config/alacritty/colorschemes.d/yml/substrata.yml".text = ''
    schemes:
      substrata:  &substrata
        primary:
          background: '#191c25'
          foreground: '#b5b4c9'
        normal:
          black:   '#2e313d'
          red:     '#cf8164'
          green:   '#76a065'
          yellow:  '#ab924c'
          blue:    '#8296b0'
          magenta: '#a18daf'
          cyan:    '#659ea2'
          white:   '#b5b4c9'
        bright:
          black:   '#5b5f71'
          red:     '#fe9f7c'
          green:   '#92c47e'
          yellow:  '#d2b45f'
          blue:    '#a0b9d8'
          magenta: '#c6aed7'
          cyan:    '#7dc2c7'
          white:   '#f0ecfe'
    colors:  *substrata
    '';
    ".config/alacritty/colorschemes.d/toml/taerminal.toml".text = ''
      # Colors (Taerminal)

      # Default colors
      [colors.primary]
      background = '#26282a'
      foreground = '#f0f0f0'

      [colors.cursor]
      background = '#f0f0f0'
      foreground = '#26282a'

      # Normal colors
      [colors.normal]
      black   = '#26282a'
      red     = '#ff8878'
      green   = '#b4fb73'
      yellow  = '#fffcb7'
      blue    = '#8bbce5'
      magenta = '#ffb2fe'
      cyan    = '#a2e1f8'
      white   = '#f1f1f1'

      # Bright colors
      [colors.bright]
      black   = '#6f6f6f'
      red     = '#fe978b'
      green   = '#d6fcba'
      yellow  = '#fffed5'
      blue    = '#c2e3ff'
      magenta = '#ffc6ff'
      cyan    = '#c0e9f8'
      white   = '#ffffff'
    '';
    ".config/alacritty/colorschemes.d/yml/taerminal.yml".text = ''
    schemes:
      taerminal:  &taerminal
        # Default colors
        primary:
          background: '#26282a'
          foreground: '#f0f0f0'
        cursor:
          background: '#f0f0f0'
          foreground: '#26282a'
        # Normal colors
        normal:
          black:   '#26282a'
          red:     '#ff8878'
          green:   '#b4fb73'
          yellow:  '#fffcb7'
          blue:    '#8bbce5'
          magenta: '#ffb2fe'
          cyan:    '#a2e1f8'
          white:   '#f1f1f1'
        # Bright colors
        bright:
          black:   '#6f6f6f'
          red:     '#fe978b'
          green:   '#d6fcba'
          yellow:  '#fffed5'
          blue:    '#c2e3ff'
          magenta: '#ffc6ff'
          cyan:    '#c0e9f8'
          white:   '#ffffff'
    colors:  *taerminal
    '';
    ".config/alacritty/colorschemes.d/yml/tangoish.yml".text = ''
    schemes:
      tangoish:  &tangoish
        primary:
          background: '#2e3436'
          foreground: '#eeeeec'
        # Normal colors
        normal:
           black:   '#2e3436'
           red:     '#cc0000'
           green:   '#73d216'
           yellow:  '#edd400'
           blue:    '#3465a4'
           magenta: '#75507b'
           cyan:    '#f57900'
           white:   '#d3d7cf'
        # Bright colors
        bright:
           black:   '#2e3436'
           red:     '#ef2929'
           green:   '#8ae234'
           yellow:  '#fce94f'
           blue:    '#729fcf'
           magenta: '#ad7fa8'
           cyan:    '#fcaf3e'
           white:   '#eeeeec'
    colors:  *tangoish
    '';
    ".config/alacritty/colorschemes.d/yml/tango.yml".text = ''
    schemes:
      tango:  &tango
        primary:
          background: '#000000'
          foreground: '#00ff00'
        # Normal colors
        normal:
        black:   '#2e3436'
        red:     '#cc0000'
        green:   '#73d216'
        yellow:  '#edd400'
        blue:    '#3465a4'
        magenta: '#75507b'
        cyan:    '#06989a'
        white:   '#d3d7cf'
        # Bright colors
        bright:
        black:   '#2e3436'
        red:     '#ef2929'
        green:   '#8ae234'
        yellow:  '#fce94f'
        blue:    '#729fcf'
        magenta: '#ad7fa8'
        cyan:    '#34e2e2'
        white:   '#eeeeec'
    colors:  *tango
    '';
    ".config/alacritty/colorschemes.d/toml/tango-dark.toml".text = ''
      # GNOME Terminal Tango Dark

      [colors.primary]
      background = '#2e3436'
      foreground = '#d3d7cf'

      [colors.normal]
      black = '#2e3436'
      red = '#cc0000'
      green = '#4e9a06'
      yellow = '#c4a000'
      blue = '#3465a4'
      magenta = '#75507b'
      cyan = '#06989a'
      white = '#d3d7cf'

      [colors.bright]
      black = '#555753'
      red = '#ef2929'
      green = '#8ae234'
      yellow = '#fce94f'
      blue = '#729fcf'
      magenta = '#ad7fa8'
      cyan = '#34e2e2'
      white = '#eeeeec'
    '';
    ".config/alacritty/colorschemes.d/toml/tender.toml".text = ''
      # Default colors
      [colors.primary]
      background = '#282828'
      foreground = '#eeeeee'

      # Normal colors
      [colors.normal]
      black   = '#282828'
      red     = '#f43753'
      green   = '#c9d05c'
      yellow  = '#ffc24b'
      blue    = '#b3deef'
      magenta = '#d3b987'
      cyan    = '#73cef4'
      white   = '#eeeeee'

      # Bright colors
      [colors.bright]
      black   = '#4c4c4c'
      red     = '#f43753'
      green   = '#c9d05c'
      yellow  = '#ffc24b'
      blue    = '#b3deef'
      magenta = '#d3b987'
      cyan    = '#73cef4'
      white   = '#feffff'
    '';
    ".config/alacritty/colorschemes.d/yml/tender.yml".text = ''
    schemes:
      tender:  &tender
        # Default colors
        primary:
          background: '#282828'
          foreground: '#eeeeee'
        # Normal colors
        normal:
          black:   '#282828'
          red:     '#f43753'
          green:   '#c9d05c'
          yellow:  '#ffc24b'
          blue:    '#b3deef'
          magenta: '#d3b987'
          cyan:    '#73cef4'
          white:   '#eeeeee'
        # Bright colors
        bright:
          black:   '#4c4c4c'
          red:     '#f43753'
          green:   '#c9d05c'
          yellow:  '#ffc24b'
          blue:    '#b3deef'
          magenta: '#d3b987'
          cyan:    '#73cef4'
          white:   '#feffff'
    colors:  *tender
    '';
    ".config/alacritty/colorschemes.d/yml/terminal-app-basic.yml".text = ''
    schemes:
      terminal_app_basic:  &terminal_app_basic
        primary:
          background: '#FFFFFF'
          foreground: '#000000'
        normal:
          black:      '#000000'
          red:        '#990000'
          green:      '#00A600'
          yellow:     '#999900'
          blue:       '#0000B2'
          magenta:    '#B200B2'
          cyan:       '#00A6B2'
          white:      '#BFBFBF'
        bright:
          black:      '#666666'
          red:        '#E50000'
          green:      '#00D900'
          yellow:     '#E5E500'
          blue:       '#0000FF'
          magenta:    '#E500E5'
          cyan:       '#00E5E5'
          white:      '#E5E5E5'
    colors:  *terminal_app_basic
    '';
    ".config/alacritty/colorschemes.d/toml/terminal-app.toml".text = ''
      # Colors (Terminal.app)

      # Default colors
      [colors.primary]
      background = '#000000'
      foreground = '#b6b6b6'

      # Normal colors
      [colors.normal]
      black   = '#000000'
      red     = '#990000'
      green   = '#00a600'
      yellow  = '#999900'
      blue    = '#0000b2'
      magenta = '#b200b2'
      cyan    = '#00a6b2'
      white   = '#bfbfbf'

      # Bright colors
      [colors.bright]
      black   = '#666666'
      red     = '#e50000'
      green   = '#00d900'
      yellow  = '#e5e500'
      blue    = '#0000ff'
      magenta = '#e500e5'
      cyan    = '#00e5e5'
      white   = '#e5e5e5'
    '';
    ".config/alacritty/colorschemes.d/yml/terminal-app.yml".text = ''
    schemes:
      terminal_app:  &terminal_app
        # Default colors
        primary:
          background: '#000000'
          foreground: '#b6b6b6'
        # Normal colors
        normal:
          black:   '#000000'
          red:     '#990000'
          green:   '#00a600'
          yellow:  '#999900'
          blue:    '#0000b2'
          magenta: '#b200b2'
          cyan:    '#00a6b2'
          white:   '#bfbfbf'
        # Bright colors
        bright:
          black:   '#666666'
          red:     '#e50000'
          green:   '#00d900'
          yellow:  '#e5e500'
          blue:    '#0000ff'
          magenta: '#e500e5'
          cyan:    '#00e5e5'
          white:   '#e5e5e5'
    colors:  *terminal_app
    '';
    ".config/alacritty/colorschemes.d/toml/thelovelace.toml".text = ''
      # Default colors
      [colors.primary]
      background = '#1D1F28'
      foreground = '#FDFDFD'

      # Normal colors
      [colors.normal]
      black   = '#282A36'
      red     = '#F37F97'
      green   = '#5ADECD'
      yellow  = '#F2A272'
      blue    = '#8897F4'
      magenta = '#C574DD'
      cyan    = '#79E6F3'
      white   = '#FDFDFD'

      # Bright colors
      [colors.bright]
      black   = '#414458'
      red     = '#FF4971'
      green   = '#18E3C8'
      yellow  = '#EBCB8B'
      blue    = '#FF8037'
      magenta = '#556FFF'
      cyan    = '#3FDCEE'
      white   = '#BEBEC1'
    '';
    ".config/alacritty/colorschemes.d/toml/tokyo-night.toml".text = ''
      # Colors (Tokyo Night)
      # Source https//github.com/zatchheems/tokyo-night-alacritty-theme

      # Default colors
      [colors.primary]
      background = '#1a1b26'
      foreground = '#a9b1d6'

      # Normal colors
      [colors.normal]
      black   = '#32344a'
      red     = '#f7768e'
      green   = '#9ece6a'
      yellow  = '#e0af68'
      blue    = '#7aa2f7'
      magenta = '#ad8ee6'
      cyan    = '#449dab'
      white   = '#787c99'

      # Bright colors
      [colors.bright]
      black   = '#444b6a'
      red     = '#ff7a93'
      green   = '#b9f27c'
      yellow  = '#ff9e64'
      blue    = '#7da6ff'
      magenta = '#bb9af7'
      cyan    = '#0db9d7'
      white   = '#acb0d0'
    '';
    ".config/alacritty/colorschemes.d/toml/tokyo-night-storm.toml".text = ''
      # Colors (Tokyo Night Storm variant)
      # Source https//github.com/zatchheems/tokyo-night-alacritty-theme

      # Default colors
      [colors.primary]
      background = '#24283b'
      foreground = '#a9b1d6'

      # Normal colors
      [colors.normal]
      black   = '#32344a'
      red     = '#f7768e'
      green   = '#9ece6a'
      yellow  = '#e0af68'
      blue    = '#7aa2f7'
      magenta = '#ad8ee6'
      cyan    = '#449dab'
      white   = '#9699a8'

      # Bright colors
      [colors.bright]
      black   = '#444b6a'
      red     = '#ff7a93'
      green   = '#b9f27c'
      yellow  = '#ff9e64'
      blue    = '#7da6ff'
      magenta = '#bb9af7'
      cyan    = '#0db9d7'
      white   = '#acb0d0'
    '';
    ".config/alacritty/colorschemes.d/toml/tomorrow-night-bright.toml".text = ''
      # Colors (Tomorrow Night Bright)

      # Default colors
      [colors.primary]
      background = '#000000'
      foreground = '#eaeaea'

      # Normal colors
      [colors.normal]
      black   = '#000000'
      red     = '#d54e53'
      green   = '#b9ca4a'
      yellow  = '#e6c547'
      blue    = '#7aa6da'
      magenta = '#c397d8'
      cyan    = '#70c0ba'
      white   = '#424242'

      # Bright colors
      [colors.bright]
      black   = '#666666'
      red     = '#ff3334'
      green   = '#9ec400'
      yellow  = '#e7c547'
      blue    = '#7aa6da'
      magenta = '#b77ee0'
      cyan    = '#54ced6'
      white   = '#2a2a2a'
    '';
    ".config/alacritty/colorschemes.d/yml/tomorrow-night-bright.yml".text = ''
    schemes:
      tomorrow_night_bright:  &tomorrow_night_bright
        # Default colors
        primary:
          background: '#000000'
          foreground: '#eaeaea'
        # Normal colors
        normal:
          black:   '#000000'
          red:     '#d54e53'
          green:   '#b9ca4a'
          yellow:  '#e6c547'
          blue:    '#7aa6da'
          magenta: '#c397d8'
          cyan:    '#70c0ba'
          white:   '#424242'
        # Bright colors
        bright:
          black:   '#666666'
          red:     '#ff3334'
          green:   '#9ec400'
          yellow:  '#e7c547'
          blue:    '#7aa6da'
          magenta: '#b77ee0'
          cyan:    '#54ced6'
          white:   '#2a2a2a'
    colors:  *tomorrow_night_bright
    '';
    ".config/alacritty/colorschemes.d/toml/tomorrow-night.toml".text = ''
      # Colors (Tomorrow Night)

      # Default colors
      [colors.primary]
      background = '#1d1f21'
      foreground = '#c5c8c6'

      [colors.cursor]
      text = '#1d1f21'
      cursor = '#ffffff'

      # Normal colors
      [colors.normal]
      black   = '#1d1f21'
      red     = '#cc6666'
      green   = '#b5bd68'
      yellow  = '#e6c547'
      blue    = '#81a2be'
      magenta = '#b294bb'
      cyan    = '#70c0ba'
      white   = '#373b41'

      # Bright colors
      [colors.bright]
      black   = '#666666'
      red     = '#ff3334'
      green   = '#9ec400'
      yellow  = '#f0c674'
      blue    = '#81a2be'
      magenta = '#b77ee0'
      cyan    = '#54ced6'
      white   = '#282a2e'
    '';
    ".config/alacritty/colorschemes.d/yml/tomorrow-night.yml".text = ''
    schemes:
      tomorrow_night:  &tomorrow_night
        # Default colors
        primary:
          background: '#1d1f21'
          foreground: '#c5c8c6'
        # Colors the cursor will use if `custom_cursor_colors` is true
        cursor:
          text: '#1d1f21'
          cursor: '#ffffff'
        # Normal colors
        normal:
          black:   '#1d1f21'
          red:     '#cc6666'
          green:   '#b5bd68'
          yellow:  '#e6c547'
          blue:    '#81a2be'
          magenta: '#b294bb'
          cyan:    '#70c0ba'
          white:   '#373b41'
        # Bright colors
        bright:
          black:   '#666666'
          red:     '#ff3334'
          green:   '#9ec400'
          yellow:  '#f0c674'
          blue:    '#81a2be'
          magenta: '#b77ee0'
          cyan:    '#54ced6'
          white:   '#282a2e'
    colors:  *tomorrow_night
    '';
    ".config/alacritty/colorschemes.d/toml/ubuntu.toml".text = ''
      # 0x From the Ubuntu terminal color palette

      # 0x Default colors
      [colors.primary]
      background = '#300a24'
      foreground = '#eeeeec'

      # 0x Colors the cursor will use if `custom_cursor_colors` is true
      [colors.cursor]
      text = '#bbbbbb'
      cursor = '#b4d5ff'

      # 0x Normal colors
      [colors.normal]
      black   = '#2e3436'
      red     = '#cc0000'
      green   = '#4e9a06'
      yellow  = '#c4a000'
      blue    = '#3465a4'
      magenta = '#75507b'
      cyan    = '#06989a'
      white   = '#d3d7cf'

      # 0x Bright colors
      [colors.bright]
      black   = '#555753'
      red     = '#ef2929'
      green   = '#8ae234'
      yellow  = '#fce94f'
      blue    = '#729fcf'
      magenta = '#ad7fa8'
      cyan    = '#34e2e2'
      white   = '#eeeeec'
    '';
    ".config/alacritty/colorschemes.d/yml/ubuntu.yml".text = ''
    schemes:
      ubuntu:  &ubuntu
        # Default colors
        primary:
          background: '#300a24'
          foreground: '#eeeeec'
        # Normal colors
        normal:
          black:   '#2e3436'
          red:     '#cc0000'
          green:   '#4e9a06'
          yellow:  '#c4a000'
          blue:    '#3465a4'
          magenta: '#75507b'
          cyan:    '#06989a'
          white:   '#d3d7cf'
        # Bright colors
        bright:
          black:   '#555753'
          red:     '#ef2929'
          green:   '#8ae234'
          yellow:  '#fce94f'
          blue:    '#729fcf'
          magenta: '#ad7fa8'
          cyan:    '#34e2e2'
          white:   '#eeeeec'
    colors:  *ubuntu
    '';
    ".config/alacritty/colorschemes.d/yml/vscode-terminal.yml".text = ''
    schemes:
      vscode_terminal:  &vscode_terminal
        # Default colors
        primary:
          background: '#1e1e1e' #Background from Dark Theme
        # Normal colors
        normal:
          black:   '#000000'
          red:     '#cd3131'
          green:   '#0dbc79'
          yellow:  '#e5e510'
          blue:    '#2472c8'
          magenta: '#bc3fbc'
          cyan:    '#11a8cd'
          white:   '#e5e5e5'
        # Bright colors
        bright:
          black:   '#666666'
          red:     '#f14c4c'
          green:   '#23d18b'
          yellow:  '#f5f543'
          blue:    '#3b8eea'
          magenta: '#d670d6'
          cyan:    '#29b8db'
          white:   '#e5e5e5'
    colors:  *vscode_terminal
    '';
    ".config/alacritty/colorschemes.d/toml/wombat.toml".text = ''
      # Colors (Wombat)

      # Default colors
      [colors.primary]
      background = '#1f1f1f'
      foreground = '#e5e1d8'

      # Normal colors
      [colors.normal]
      black   = '#000000'
      red     = '#f7786d'
      green   = '#bde97c'
      yellow  = '#efdfac'
      blue    = '#6ebaf8'
      magenta = '#ef88ff'
      cyan    = '#90fdf8'
      white   = '#e5e1d8'

      # Bright colors
      [colors.bright]
      black   = '#b4b4b4'
      red     = '#f99f92'
      green   = '#e3f7a1'
      yellow  = '#f2e9bf'
      blue    = '#b3d2ff'
      magenta = '#e5bdff'
      cyan    = '#c2fefa'
      white   = '#ffffff'
    '';
    ".config/alacritty/colorschemes.d/yml/wombat.yml".text = ''
    schemes:
      wombat:  &wombat
        # Default colors
        primary:
          background: '#1f1f1f'
          foreground: '#e5e1d8'
        # Normal colors
        normal:
          black:   '#000000'
          red:     '#f7786d'
          green:   '#bde97c'
          yellow:  '#efdfac'
          blue:    '#6ebaf8'
          magenta: '#ef88ff'
          cyan:    '#90fdf8'
          white:   '#e5e1d8'
        # Bright colors
        bright:
          black:   '#b4b4b4'
          red:     '#f99f92'
          green:   '#e3f7a1'
          yellow:  '#f2e9bf'
          blue:    '#b3d2ff'
          magenta: '#e5bdff'
          cyan:    '#c2fefa'
          white:   '#ffffff'
    colors:  *wombat
    '';
    ".config/alacritty/colorschemes.d/toml/xterm.toml".text = ''
      # XTerm's default colors

      # Default colors
      [colors.primary]
      background = '#000000'
      foreground = '#ffffff'

      # Normal colors
      [colors.normal]
      black   = '#000000'
      red     = '#cd0000'
      green   = '#00cd00'
      yellow  = '#cdcd00'
      blue    = '#0000ee'
      magenta = '#cd00cd'
      cyan    = '#00cdcd'
      white   = '#e5e5e5'

      # Bright colors
      [colors.bright]
      black   = '#7f7f7f'
      red     = '#ff0000'
      green   = '#00ff00'
      yellow  = '#ffff00'
      blue    = '#5c5cff'
      magenta = '#ff00ff'
      cyan    = '#00ffff'
      white   = '#ffffff'
    '';
    ".config/alacritty/colorschemes.d/yml/xterm.yml".text = ''
    schemes:
      xterm:  &xterm
         # Default colors
         primary:
           background: '#000000'
           foreground: '#ffffff'
         # Normal colors
         normal:
           black:   '#000000'
           red:     '#cd0000'
           green:   '#00cd00'
           yellow:  '#cdcd00'
           blue:    '#0000ee'
           magenta: '#cd00cd'
           cyan:    '#00cdcd'
           white:   '#e5e5e5'
         # Bright colors
         bright:
           black:   '#7f7f7f'
           red:     '#ff0000'
           green:   '#00ff00'
           yellow:  '#ffff00'
           blue:    '#5c5cff'
           magenta: '#ff00ff'
           cyan:    '#00ffff'
           white:   '#ffffff'
    colors:  *xterm
    '';
    ".config/alacritty/colorschemes.d/toml/zenburn.toml".text = ''
      # Colors (Zenburn)
      # Orginally designed by jnurmine for vim.

      # Default colors
      [colors.primary]
      background = '#3A3A3A'
      foreground = '#DCDCCC'

      # Normal colors
      [colors.normal]
      black   = '#1E2320'
      red     = '#D78787'
      green   = '#60B48A'
      yellow  = '#DFAF8F'
      blue    = '#506070'
      magenta = '#DC8CC3'
      cyan    = '#8CD0D3'
      white   = '#DCDCCC'

      # Bright colors
      [colors.bright]
      black   = '#709080'
      red     = '#DCA3A3'
      green   = '#C3BF9F'
      yellow  = '#F0DFAF'
      blue    = '#94BFF3'
      magenta = '#EC93D3'
      cyan    = '#93E0E3'
      white   = '#FFFFFF'
    '';
    ".config/alacritty/colorschemes.d/yml/zenburn.yml".text = ''
    schemes:
      zenburn:  &zenburn
        primary:
          background: '#333333'
          foreground: '#ffffff'
          bright_foreground: '#ffffff'
          bright_background: '#555555'
        cursor:
          text:    '#000000'
          cursor:  '#00ff00'
        normal:
          black:   '#4d4d4d'
          red:     '#bb0000'
          green:   '#98f898'
          yellow:  '#f0e68c'
          blue:    '#96853f'
          magenta: '#ffdead'
          cyan:    '#ffa0a0'
          white:   '#f5deb3'
        bright:
          black:   '#555555'
          red:     '#ff5555'
          green:   '#55ff55'
          yellow:  '#ffff55'
          blue:    '#87ceeb'
          magenta: '#ff55ff'
          cyan:    '#ffd700'
          white:   '#ffffff'
    colors:  *zenburn
    '';
  };
}
