{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/rofi/config.rasi".text = ''
      configuration {
          font: "IBM Plex Mono Text 11";
          modi: "combi,window,ssh,drun,run";
          combi-modi: "window,ssh,drun,run";
          show-icons: true;
          icon-theme: "Adwaita";
          combi {
            display-name: "combi: ";
          }
          run {
            display-name: "run: ";
          }
          drun {
            display-name: "drun: ";
          }
          ssh {
            display-name: "ssh: ";
          }
          window {
            display-name: "window: ";
          }
        timeout {
            action: "kb-cancel";
            delay:  0;
        }
        filebrowser {
            directories-first: true;
            sorting-method:    "name";
        }
      }
      @theme "~/.config/rofi/theme.rasi"
    '';
    ".config/rofi/themes/pop-dark.rasi".text = ''
      /******************************************************************************
       * ROFI Color theme
       * User: Rasi
       * Copyright: Rasmus Steinke
       ******************************************************************************/
      * {
          transparent-background:      rgba ( 0, 0, 0, 0 % );
          foreground:                  rgba ( 204, 204, 204, 100 % );
          background:                  rgba ( 48, 48, 48, 100 % );

          normal-foreground:           @foreground;
          normal-background:           rgba ( 34, 34, 34, 100 % );
          active-foreground:           rgba ( 0, 142, 212, 100 % );
          active-background:           rgba ( 0, 43, 55, 100 % );
          urgent-foreground:           rgba ( 218, 66, 129, 100 % );
          urgent-background:           rgba ( 0, 43, 55, 100 % );

          selected-normal-foreground:  rgba ( 34, 34, 34, 100 % );
          selected-normal-background:  rgba ( 144, 207, 176, 100 % );
          selected-active-foreground:  rgba ( 102, 198, 255, 100 % );
          selected-active-background:  rgba ( 0, 142, 212, 100 % );
          selected-urgent-foreground:  rgba ( 137, 6, 97, 100 % );
          selected-urgent-background:  rgba ( 0, 142, 212, 100 % );

          alternate-normal-foreground: @foreground;
          alternate-normal-background: rgba ( 48, 48, 48, 100 % );
          alternate-active-foreground: @active-foreground;
          alternate-active-background: rgba ( 0, 54, 67, 100 % );
          alternate-urgent-foreground: @urgent-foreground;
          alternate-urgent-background: rgba ( 0, 54, 67, 100 % );

          separatorcolor:              rgba ( 255, 215, 161, 100 % );

          border-color:                @foreground;
          spacing:                     2;
          background-color:            rgba ( 0, 0, 0, 0 % );
      }
      window {
          background-color: @background;
          border:           1;
          padding:          5;
      }
      mainbox {
          border:  0;
          padding: 0;
      }
      message {
          border:       1px dash 0px 0px ;
          border-color: @separatorcolor;
          padding:      1px ;
      }
      textbox {
          text-color: @foreground;
      }
      listview {
          fixed-height: 0;
          border:       2px dash 0px 0px ;
          border-color: @separatorcolor;
          spacing:      2px ;
          scrollbar:    true;
          padding:      2px 0px 0px ;
      }
      element {
          border:  0;
          padding: 1px ;
      }
      element-text {
          background-color: inherit;
          text-color:       inherit;
      }
      element.normal.normal {
          background-color: @normal-background;
          text-color:       @normal-foreground;
      }
      element.normal.urgent {
          background-color: @urgent-background;
          text-color:       @urgent-foreground;
      }
      element.normal.active {
          background-color: @active-background;
          text-color:       @active-foreground;
      }
      element.selected.normal {
          background-color: @selected-normal-background;
          text-color:       @selected-normal-foreground;
      }
      element.selected.urgent {
          background-color: @selected-urgent-background;
          text-color:       @selected-urgent-foreground;
      }
      element.selected.active {
          background-color: @selected-active-background;
          text-color:       @selected-active-foreground;
      }
      element.alternate.normal {
          background-color: @alternate-normal-background;
          text-color:       @alternate-normal-foreground;
      }
      element.alternate.urgent {
          background-color: @alternate-urgent-background;
          text-color:       @alternate-urgent-foreground;
      }
      element.alternate.active {
          background-color: @alternate-active-background;
          text-color:       @alternate-active-foreground;
      }
      scrollbar {
          width:        4px ;
          border:       0;
          handle-width: 8px ;
          padding:      0;
      }
      mode-switcher {
          border:       2px dash 0px 0px ;
          border-color: @separatorcolor;
      }
      button.selected {
          background-color: @selected-normal-background;
          text-color:       @selected-normal-foreground;
      }
      inputbar {
          spacing:    0;
          text-color: @normal-foreground;
          padding:    1px ;
      }
      case-indicator {
          spacing:    0;
          text-color: @normal-foreground;
      }
      entry {
          spacing:    0;
          text-color: @normal-foreground;
      }
      prompt {
          spacing:    0;
          text-color: @normal-foreground;
      }
      inputbar {
          children:   [ prompt,textbox-prompt-colon,entry,case-indicator ];
      }
      textbox-prompt-colon {
          expand:     false;
          str:        ":";
          margin:     0px 0.3em 0em 0em ;
          text-color: @normal-foreground;
      }
    '';
    ".config/rofi/themes/arc-red-dark.rasi".text = ''
      /*
       * ROFI Color theme
       * A red variation of Arc-Dark theme by leofa, based on arc-theme-Red (https://github.com/mclmza/arc-theme-Red)
       * User: wikwg9
       */
      * {
          selected-normal-foreground:  rgba ( 249, 249, 249, 100 % );
          foreground:                  rgba ( 196, 203, 212, 100 % );
          normal-foreground:           @foreground;
          alternate-normal-background: rgba ( 64, 69, 82, 59 % );
          red:                         rgba ( 220, 50, 47, 100 % );
          selected-urgent-foreground:  rgba ( 249, 249, 249, 100 % );
          blue:                        rgba ( 38, 139, 210, 100 % );
          urgent-foreground:           rgba ( 204, 102, 102, 100 % );
          alternate-urgent-background: rgba ( 75, 81, 96, 90 % );
          active-foreground:           rgba ( 220, 140, 160, 100 % );
          lightbg:                     rgba ( 238, 232, 213, 100 % );
          selected-active-foreground:  rgba ( 249, 249, 249, 100 % );
          alternate-active-background: rgba ( 75, 81, 96, 89 % );
          background:                  rgba ( 45, 48, 59, 95 % );
          alternate-normal-foreground: @foreground;
          normal-background:           @background;
          lightfg:                     rgba ( 88, 104, 117, 100 % );
          selected-normal-background:  rgba ( 204, 87, 93, 100 % );
          border-color:                rgba ( 137, 131, 124, 100 % );
          spacing:                     2;
          separatorcolor:              rgba ( 29, 31, 33, 100 % );
          urgent-background:           rgba ( 29, 31, 33, 17 % );
          selected-urgent-background:  rgba ( 165, 66, 66, 100 % );
          alternate-urgent-foreground: @urgent-foreground;
          background-color:            rgba ( 0, 0, 0, 0 % );
          alternate-active-foreground: @active-foreground;
          active-background:           rgba ( 29, 31, 33, 17 % );
          selected-active-background:  rgba ( 204, 87, 93, 100 % );
      }
      #window {
          background-color: @background;
          padding:          5;
      }
      #mainbox {
          border:  0;
          padding: 0;
      }
      #message {
          border:       2px 0px 0px ;
          border-color: @separatorcolor;
          padding:      1px ;
      }
      #textbox {
          text-color: @foreground;
      }
      #listview {
          fixed-height: 0;
          border:       2px 0px 0px ;
          border-color: @separatorcolor;
          spacing:      2px ;
          scrollbar:    false;
          padding:      2px 0px 0px ;
      }
      #element {
          border:  0;
          padding: 1px ;
      }
      #element.normal.normal {
          background-color: @normal-background;
          text-color:       @normal-foreground;
      }
      #element.normal.urgent {
          background-color: @urgent-background;
          text-color:       @urgent-foreground;
      }
      #element.normal.active {
          background-color: @active-background;
          text-color:       @active-foreground;
      }
      #element.selected.normal {
          background-color: @selected-normal-background;
          text-color:       @selected-normal-foreground;
      }
      #element.selected.urgent {
          background-color: @selected-urgent-background;
          text-color:       @selected-urgent-foreground;
      }
      #element.selected.active {
          background-color: @selected-active-background;
          text-color:       @selected-active-foreground;
      }
      #element.alternate.normal {
          background-color: @alternate-normal-background;
          text-color:       @alternate-normal-foreground;
      }
      #element.alternate.urgent {
          background-color: @alternate-urgent-background;
          text-color:       @alternate-urgent-foreground;
      }
      #element.alternate.active {
          background-color: @alternate-active-background;
          text-color:       @alternate-active-foreground;
      }
      #mode-switcher {
          border:       2px 0px 0px ;
          border-color: @separatorcolor;
      }
      #button {
          spacing:    0;
          text-color: @normal-foreground;
      }
      #button.selected {
          background-color: @selected-normal-background;
          text-color:       @selected-normal-foreground;
      }
      #inputbar {
          spacing:    0;
          text-color: @normal-foreground;
          padding:    1px ;
      }
      #case-indicator {
          spacing:    0;
          text-color: @normal-foreground;
      }
      #entry {
          spacing:    0;
          text-color: @normal-foreground;
      }
      #prompt {
          spacing:    0;
          text-color: @normal-foreground;
      }
      #inputbar {
          children:   [ prompt,textbox-prompt-colon,entry,case-indicator ];
      }
      #textbox-prompt-colon {
          expand:     false;
          str:        ":";
          margin:     0px 0.3em 0em 0em ;
          text-color: @normal-foreground;
      }
    '';
    ".config/rofi/themes/cloud.rasi".text = ''
      /**Customized by Rapteon; Date: 2019-01-04**/

      /**
          Hint:
          Change the values in the first block of variables(below) before...
          ...individually changing values in the components.
          
          'lightfg' changes the border color and the text color.
          'background-color' changes the background color of the floating box.
          'selected-normal-background' changes the text-color of the focused item.
          'lightbg' changes the highlight color of the list items.
      **/
      * {
          red:                         rgba ( 220, 50, 47, 100 % );
          selected-active-foreground:  var(blackText);
          lightfg:                     rgba ( 45, 49, 66, 100 % );
          separatorcolor:              var(foreground);
          urgent-foreground:           var(red);
          alternate-urgent-background: var(lightbg);
          lightbg:                     rgba ( 176, 215, 255, 100 % );
          spacing:                     2;
          border-color:                var(lightfg);
          normal-background:           var(background);
          background-color:            rgba ( 255, 255, 255, 100 % );
          alternate-active-background: var(darkerBlue);
          active-foreground:           var(lightfg);
          blue:                        rgba ( 173, 172, 181, 100 % );
          urgent-background:           var(background);
          alternate-normal-foreground: var(foreground);
          selected-active-background:  var(darkerBlue);
          background:                  rgba ( 0, 0, 0, 0% );
          selected-normal-foreground:  var(lightfg);
          active-background:           var(background);
          alternate-active-foreground: var(blackText);
          alternate-normal-background: var(background);
          foreground:                  rgba ( 45, 49, 66, 100 % );
          selected-urgent-background:  var(red);
          selected-urgent-foreground:  var(background);
          normal-foreground:           var(foreground);
          alternate-urgent-foreground: var(red);
          selected-normal-background:  var(lightbg);
          /*font:                        "DejaVu Sans 12";*/
          blackText:			 rgba(0, 0, 0, 100 %);
      }
      window {
          padding:          5;
          background-color: var(background);
          border:           2;
          border-radius:    12px;
          fullscreen:	      false;
          transparency:     "screenshot";
          width:            30%;
      }
      mainbox {
          padding: 10;
          border:  0;
          border-radius: 10px;
      }
      message {
          padding:      2px 0px 0px ;
          border-color: var(separatorcolor);
          border:       2px dash 0px 0px ;
          width:        30%;
          /*font:         "monospace bold 10";*/
      }
      textbox {
          text-color: var(foreground);
          border-radius:10px;
          padding: 10px 10px 10px;
      }
      listview {
          padding:      2px 0px 0px ;
          scrollbar:    false;
          border-color: var(separatorcolor);
          spacing:      2px ;
          fixed-height: 0;
          border:       2px dash 0px 0px ;
          lines:        5;
      }
      element {
          padding: 1px ;
          border:  0;
      }
      element normal.normal {
          background-color: var(normal-background);
          text-color:       var(normal-foreground);
      }
      element normal.urgent {
          background-color: var(urgent-background);
          text-color:       var(urgent-foreground);
      }
      element normal.active {
          background-color: var(active-background);
          text-color:       var(active-foreground);
      }
      element selected.normal {
          background-color: var(selected-normal-background);
          text-color:       var(selected-normal-foreground);
      }
      element selected.urgent {
          background-color: var(selected-urgent-background);
          text-color:       var(selected-urgent-foreground);
      }
      element selected.active {
          background-color: var(selected-active-background);
          text-color:       var(selected-active-foreground);
      }
      element alternate.normal {
          background-color: var(alternate-normal-background);
          text-color:       var(alternate-normal-foreground);
      }
      element alternate.urgent {
          background-color: var(alternate-urgent-background);
          text-color:       var(alternate-urgent-foreground);
      }
      element alternate.active {
          background-color: var(alternate-active-background);
          text-color:       var(alternate-active-foreground);
      }
      scrollbar {
          width:        4px ;
          padding:      0;
          handle-width: 8px ;
          border:       0;
          handle-color: var(normal-foreground);
      }
      mode-switcher {
          border-color: var(separatorcolor);
          border:       2px dash 0px 0px ;
      }
      button {
          spacing:    0;
          text-color: var(normal-foreground);
      }
      button selected {
          background-color: var(selected-normal-background);
          text-color:       var(selected-normal-foreground);
      }
      inputbar {
          padding:    1px ;
          spacing:    0px ;
          text-color: var(normal-foreground);
          children:   [ prompt,textbox-prompt-colon,entry,overlay,case-indicator ];
      }
      case-indicator {
          spacing:    0;
          text-color: var(normal-foreground);
      }
      entry {
          spacing:    0;
          text-color: var(normal-foreground);
      }
      prompt {
          spacing:    0;
          text-color: var(normal-foreground);
      }
      textbox-prompt-colon {
          margin:     0px 0.3000em 0.0000em 0.0000em ;
          expand:     false;
          str:        " > ";
          text-color: inherit;
      }
      error-message {
          background-color: rgba ( 0, 0, 0, 0 % );
          text-color:       var(normal-foreground);
      }
    '';
    ".config/rofi/themes/fancy.rasi".text = ''
      /**
       * User: Rasi
       * Copyright: Rasmus Steinke
       */

      /* global settings and color variables */
      * {
          blue:        #A7c6E2;
          blue-trans:  #A7c6e2aa;
          darkblue:    #005F87;
          white:       #FFFFFF;
          green:       #00330088;
          black:       #000000;
          grey:        #444444;
          orange:      #FFD391;
          dark-orange: #FFA664;
          light-grey:  #F5F5F5;
          medium-grey: #D0D0D0;
          dark-grey:   #002B36;
          urgent:      #D75F00;
          active:      #005F87;
          transparent: #000000aa;
          spacing: 0em;
          /*font: "Iosevka Term Regular 14";*/
          padding: 0px;
          background-color: @white;
          line-style: "none";
      }

      prompt-box {
          background-color: transparent;
      }

      prompt {
          background-color: transparent;
          text-color: @white;
      }

      window {
          border-radius: 10px;
          background-color: @transparent;
          border: 2;
          color: @grey;
      }
      mainbox {
          padding: 0px;
          background-color: @blue-trans;
          color: @grey;
          border: 2px;
          spacing: 0%;
      }

      listview {
          // Looks.
          border-radius: 10px;
          border: 5px 5px 5px 5px;
          padding: 20px 20px 20px 20px;
          margin: 20px 30px 30px 30px;
          background-color: @orange;
          // Enable scrollbar
          scrollbar: false;
          scrollbar-width: 5px;
          fixed-height: true;
          reverse: false;
          color: #000000;
          spacing: 0.3em;
      }
      scrollbar {
          color: @black;
          background-color: @blue;
          padding: 1px;
      }
      element {
          border: 0px;
          padding: 0px;
          margin: 0px;
          color: @black;
          background-color: @blue;
      }
      element normal.normal {
          color: @black;
          background-color: @orange;
      }
      element normal.urgent {
          color: @urgent;
          background-color: @light-grey;
      }
      element normal.active {
          color: @active;
          background-color: @light-grey;
      }
      element selected.normal {
          border-radius: 0px;
          color: @black;
          background-color: @dark-orange;
      }
      element selected.urgent {
          color: @light-grey;
          background-color: @urgent;
      }
      element selected.active {
          color: @light-grey;
          background-color: @active;
      }
      element alternate.normal {
          color: @black;
          background-color: @orange;
      }
      element alternate.urgent {
          color: @urgent;
          background-color: @medium-grey;
      }
      element alternate.active {
          color: @active;
          background-color: @medium-grey;
      }
      inputbar {
          spacing: 0;
          background-color: #88003300;
          border: 0px 0px 2px 0px;
          border-radius: 0px;
          padding: 5px 10px 5px 35px;
          background-color: #00330088;
          color: @black;
          end: false;
      }

      separator {
          background-color: @blue;
          color: #00000000;
      }
      prompt normal.normal {
          background-color: #00000000;
          color: #ffffff;
          padding: 0px;
      }
      entry normal.normal {
          background-color: #00000000;
          color: #ffffff;
          padding: 0px;
      }
      case-indicator normal.normal {
          background-color: #00000000;
          color: #ffffff;
          padding: 0px;
      }

      message {
          margin: 30px 30px 30px 30px;
          padding: 20px 30px 20px 20px;
          padding:      1px ;
          border-radius: 10px;
          border: 5px 5px 5px 5px;
      }

      prompt-colon {
          spacing:    0;
          enabled: false;
      }
    '';
    ".config/rofi/themes/flamingo.rasi".text = ''
      /**
       * User: keystroke3
       * Copyright: keystroke3
       *
       */

      configuration {
          display-drun: "";
          display-run: "";
          display-window: "";
          display-ssh: "~#";
          show-icons: true;
          sidebar-mode: false;
          /*font: "Source Code Pro 15";*/
      }

      * {
          text-color: @foreground;
          active-background: rgb(170, 70, 104);
          active-foreground: @foreground;
          normal-background: @background;
          normal-foreground: @foreground;
          urgent-background: #9E2A5E;
          urgent-foreground: @foreground;
          alternate-active-background: @background;
          alternate-active-foreground: @foreground;
          alternate-normal-background: @background;
          alternate-normal-foreground: @foreground;
          alternate-urgent-background: @background;
          alternate-urgent-foreground: @foreground;
          selected-active-background: #9E2A5E;
          selected-active-foreground: @foreground;
          selected-normal-background: rgb(170, 70, 104);
          selected-normal-foreground: #0c0816;
          selected-urgent-background: #9D596B;
          selected-urgent-foreground: @foreground;
          background-color: #0c0816;
          background: #D03C6E30;
          foreground: #8fc5c6;
          spacing: 0;
      }

      window {
          location: west;
          anchor: west;
          height: 70%;
          width: 25%;
          orientation: vertical;
          children: [mainbox];
          border: 2px 2px 2px 0px;
          border-color: @active-background;
          hide-scrollbar: true;
      }

      mainbox {
          spacing: 0.2em;
          children: [inputbar, listview];
      }



      listview {
          spacing: 0.6em;
          dynamic: false;
          cycle: true;
          padding: 0px 5px 0px 5px;
      }

      inputbar {
          border-radius: 50%;
          padding: 5px;
          border-spacing: 5px 0 0 0;
          border: 1px;
          spacing: 10px;
          margin: 5px 0 10px;
          border-color: @foreground;

      }

      entry{
          padding: 2px;
      }


      prompt{
          padding: 5px;
          background-color: @foreground;
          text-color: @background-color;
          border: 1px;
          border-radius: 50%;

      }


      element {
          padding: 10px;
          border-radius: 50%;
      }

      element normal.normal {
          background-color: @normal-background;
          text-color: @normal-foreground;
      }

      element normal.urgent {
          background-color: @urgent-background;
          text-color: @urgent-foreground;
      }

      element normal.active {
          background-color: @active-background;
          text-color: @active-foreground;
      }

      element selected.normal {
          background-color: @selected-normal-background;
          text-color: @selected-normal-foreground;
          border-color: @active-background;
      }

      element selected.urgent {
          background-color: @selected-urgent-background;
          text-color: @selected-urgent-foreground;
      }

      element selected.active {
          background-color: @selected-active-background;
          text-color: @selected-active-foreground;
      }

      element alternate.normal {
          background-color: @normal-background;
          text-color: @normal-foreground;
      }

      element alternate.urgent {
          background-color: @urgent-background;
          text-color: @urgent-foreground;
      }

      element alternate.active {
          background-color: @active-background;
          text-color: @active-foreground;
      }
    '';
    ".config/rofi/themes/flat-orange.rasi".text = ''
      /**
       * ROFI Color theme
       * User: mbfraga
       * Copyright: Martin B. Fraga
       */

      /* global settings and color variables */
      * {
         maincolor:        #ed8712;
         highlight:        bold #ed8712;
         urgentcolor:      #e53714;

         fgwhite:          #cfcfcf;
         blackdarkest:     #1d1d1d;
         blackwidget:      #262626;
         blackentry:       #292929;
         blackselect:      #303030;
         darkgray:         #848484;
         scrollbarcolor:   #505050;
         /*font: "DejaVu Sans Mono Regular 14";*/
         background-color: @blackdarkest;
      }

      window {
         background-color: @blackdarkest;
         anchor: north;
         location: north;
         y-offset: 20%;
      }

      mainbox {
         background-color: @blackdarkest;
         spacing:0px;
         children: [inputbar, message, mode-switcher, listview];
      }

      message {
         padding: 6px 10px;
         background-color:@blackwidget;
      }

      textbox {
         text-color:@darkgray;
         background-color:@blackwidget;
      }

      listview {
         fixed-height: false;
         dynamic: true;
         scrollbar: true;
         spacing: 0px;
         padding: 1px 0px 0px 0px;
         margin: 0px 0px 1px 0px;
         background: @blackdarkest;
      }

      element {
         padding: 2px 15px;
      }

      element normal.normal {
         padding: 0px 15px;
         background-color: @blackentry;
         text-color: @fgwhite;
      }

      element normal.urgent {
         background-color: @blackentry;
         text-color: @urgentcolor;
      }

      element normal.active {
         background-color: @blackentry;
         text-color: @maincolor;
      }

      element selected.normal {
          background-color: @blackselect;
          text-color:       @fgwhite;
      }

      element selected.urgent {
          background-color: @urgentcolor;
          text-color:       @blackdarkest;
      }

      element selected.active {
          background-color: @maincolor;
          text-color:       @blackdarkest;
      }

      element alternate.normal {
          background-color: @blackentry;
          text-color:       @fgwhite;
      }

      element alternate.urgent {
          background-color: @blackentry;
          text-color:       @urgentcolor;
      }

      element alternate.active {
          background-color: @blackentry;
          text-color:       @maincolor;
      }

      scrollbar {
         background-color: @blackwidget;
         handle-color: @darkgray;
         handle-width: 15px;
      }

      mode-switcher {
         background-color: @blackwidget;
      }

      button {
         background-color: @blackwidget;
         text-color:       @darkgray;
      }

      button selected {
          text-color:       @maincolor;
      }

      inputbar {
         background-color: @blackdarkest;
         spacing: 0px;
      }

      prompt {
         padding:6px 9px;
         background-color: @maincolor;
         text-color:@blackwidget;
      }

      entry {
         padding:6px 10px;
         background-color:@blackwidget;
         text-color:@fgwhite;
      }

      case-indicator {
         padding:6px 10px;
         text-color:@maincolor;
         background-color:@blackwidget;
      }
    '';
    ".config/rofi/themes/gruvbox-dark.rasi".text = ''
      /******************************************************************************
       * ROFI Color theme
       * User: gdegough
       ******************************************************************************/

      * {
          /**** gruvbox-dark colors ****
          * NOTE: I am including all of them even though I am using a sub-set. I keep
          * tweaking my theme and having access to all of the colors here is handy. */

          dark0: #282828;
          neutral-red: #cc241d;
          neutral-green: #98971a;
          neutral-yellow: #d79921;
          neutral-blue: #458588;
          neutral-purple: #b16286;
          neutral-aqua: #689d6a;
          light4: #a89984;
          gray245: #928374;
          bright-red: #fb4934;
          bright-green: #b8bb26;
          bright-yellow: #fabd2f;
          bright-blue: #83a598;
          bright-purple: #d3869b;
          bright-aqua: #8ec07c;
          light1: #ebdbb2;

          /* gruvbox-dark Theme */
          transparent-background: rgba ( 0, 0, 0, 0 % );
          foreground:                  @light1;
          background:                  rgba ( 40, 40, 40, 90 % );

          normal-foreground:           @foreground;
          normal-background:           @transparent-background;
          active-foreground:           @neutral-green;
          active-background:           @transparent-background;
          urgent-foreground:           @neutral-red;
          urgent-background:           @transparent-background;

          selected-normal-foreground:  @neutral-purple;
          selected-normal-background:  @neutral-green;
          selected-active-foreground:  @bright-green;
          selected-active-background:  @neutral-green;
          selected-urgent-foreground:  @neutral-red;
          selected-urgent-background:  @neutral-green;

          alternate-normal-foreground: @foreground;
          alternate-normal-background: @transparent-background;
          alternate-active-foreground: @active-foreground;
          alternate-active-background: @transparent-background;
          alternate-urgent-foreground: @urgent-foreground;
          alternate-urgent-background: @transparent-background;

          separatorcolor:              @neutral-blue;

          /* Main element styles */
          border-color:                @neutral-blue;
          spacing:                     2;
          background-color:            @transparent-background;
      }
      window {
          background-color: @background;
          border:           1;
          padding:          20;
      }
      mainbox {
          border:  0;
          padding: 0;
      }
      message {
          border:       1px dash 0px 0px ;
          border-color: @separatorcolor;
          padding:      1px ;
      }
      textbox {
          text-color: @foreground;
      }
      listview {
          fixed-height: 0;
          border:       1px dash 0px 0px ;
          border-color: @separatorcolor;
          spacing:      2px ;
          scrollbar:    false;
          padding:      8px 0px 0px 0px;
      }
      element {
          border:  0;
          padding: 1px 0px 1px 1px;
      }
      element-text {
          background-color: inherit;
          text-color:       inherit;
      }
      element normal.normal {
          background-color: @normal-background;
          text-color:       @normal-foreground;
      }
      element normal.urgent {
          background-color: @urgent-background;
          text-color:       @urgent-foreground;
      }
      element normal.active {
          background-color: @active-background;
          text-color:       @active-foreground;
      }
      element selected.normal {
          background-color: @selected-normal-background;
          text-color:       @selected-normal-foreground;
      }
      element selected.urgent {
          background-color: @selected-urgent-background;
          text-color:       @selected-urgent-foreground;
      }
      element selected.active {
          background-color: @selected-active-background;
          text-color:       @selected-active-foreground;
      }
      element alternate.normal {
          background-color: @alternate-normal-background;
          text-color:       @alternate-normal-foreground;
      }
      element alternate.urgent {
          background-color: @alternate-urgent-background;
          text-color:       @alternate-urgent-foreground;
      }
      element alternate.active {
          background-color: @alternate-active-background;
          text-color:       @alternate-active-foreground;
      }
      scrollbar {
          width:        4px ;
          border:       0;
          handle-width: 8px ;
          padding:      0;
      }
      mode-switcher {
          border:       2px dash 0px 0px ;
          border-color: @separatorcolor;
      }
      button selected {
          background-color: @selected-normal-background;
          text-color:       @selected-normal-foreground;
      }
      inputbar {
          spacing:    0;
          text-color: @normal-foreground;
          padding:    1px ;
      }
      case-indicator {
          spacing:    0;
          text-color: @normal-foreground;
      }
      entry {
          spacing:    0;
          text-color: @normal-foreground;
      }
      prompt {
          spacing:    0;
          text-color: @normal-foreground;
      }
    '';
    ".config/rofi/themes/material.rasi".text = ''
      /*
       * ROFI color theme
       *
       * Based on Base16 Material Color Scheme (https://github.com/ntpeters/base16-materialtheme-scheme)
       *
       * User: Tomaszal
       * Copyright: Tomas Zaluckij
       */

      * {
          base00: #263238;
          base01: #2E3C43;
          base02: #314549;
          base03: #546E7A;
          base04: #B2CCD6;
          base05: #EEFFFF;
          base06: #EEFFFF;
          base07: #FFFFFF;
          base08: #F07178;
          base09: #F78C6C;
          base0A: #FFCB6B;
          base0B: #C3E88D;
          base0C: #89DDFF;
          base0D: #82AAFF;
          base0E: #C792EA;
          base0F: #FF5370;

          /*base0D: #00BCD4;*/

          spacing: 0;
          background-color: transparent;

          /*font: "Roboto Mono 13";*/
      }

      window {
          transparency: "real";
          /*fullscreen: true;*/
          background-color: #263238CC; /*base00 + CC (80% opacity)*/
      }

      mainbox {
          children: [inputbar, message, mode-switcher, listview];
          spacing: 30px;
          /*margin: 20%;*/
          padding: 30px 0;
          border: 1px;
          border-color: @base0D;
      }

      inputbar {
          padding: 0 30px;
          children: [prompt, textbox-prompt-colon, entry, case-indicator];
      }

      prompt {
          text-color: @base0D;
      }

      textbox-prompt-colon {
          expand: false;
          str: ":";
          margin: 0 1ch 0 0;
          text-color: @base0D;
      }

      entry {
          text-color: @base07;
      }

      case-indicator {
          text-color: @base0F;
      }

      mode-switcher, message {
          border: 1px 0;
          border-color: @base0D;
      }

      button, textbox {
          background-color: @base03;
          text-color: @base07;
          padding: 5px;
      }

      button selected {
          background-color: @base0D;
      }

      listview {
          scrollbar: true;
          margin: 0 10px 0 30px;
      }

      scrollbar {
          background-color: @base03;
          handle-color: @base0D;
          handle-width: 10px;
          border: 0 1px;
          border-color: @base0D;
          margin: 0 0 0 20px;
      }

      element {
          padding: 5px;
          highlight: bold underline;
      }

      element normal {
          background-color: transparent;
      }

      element selected {
          background-color: @base0D;
      }

      element alternate {
          /*background-color: @base03;*/
      }

      element normal normal, element selected normal, element alternate normal {
          text-color: @base07;
      }

      element normal urgent, element selected urgent, element alternate urgent {
          text-color: @base0F;
      }

      element normal active, element selected active, element alternate active {
          text-color: @base0B;
      }
    '';
    ".config/rofi/themes/merah.rasi".text = ''
      /* ================================================
      // theme name : merah
      // by : ipang-dwi - www.firstplato.com
      // based on the Purple official rofi theme
      // ================================================ */

      * {
          /*font: "Ubuntu Mono Reguler 11";*/
          foreground: #f8f8f2;
          background-color: #282a36;
          active-background: #b00000;
          urgent-background: #ff5555;
          selected-background: @active-background;
          selected-urgent-background: @urgent-background;
          selected-active-background: @active-background;
          separatorcolor: @active-background;
          bordercolor: @active-background;
      }

      #window {
          background-color: @background;
          border:           1;
          border-radius: 6;
          border-color: @bordercolor;
          padding:          5;
      }
      #mainbox {
          border:  0;
          padding: 0;
      }
      #message {
          border:       1px dash 0px 0px ;
          border-color: @separatorcolor;
          padding:      1px ;
      }
      #textbox {
          text-color: @foreground;
      }
      #listview {
          fixed-height: 0;
          border:       2px dash 0px 0px ;
          border-color: @bordercolor;
          spacing:      2px ;
          scrollbar:    false;
          padding:      2px 0px 0px ;
      }
      #element {
          border:  0;
          padding: 1px ;
      }
      #element.normal.normal {
          background-color: @background;
          text-color:       @foreground;
      }
      #element.normal.urgent {
          background-color: @urgent-background;
          text-color:       @urgent-foreground;
      }
      #element.normal.active {
          background-color: @active-background;
          text-color:       @foreground;
      }
      #element.selected.normal {
          background-color: @selected-background;
          text-color:       @foreground;
      }
      #element.selected.urgent {
          background-color: @selected-urgent-background;
          text-color:       @foreground;
      }
      #element.selected.active {
          background-color: @selected-active-background;
          text-color:       @foreground;
      }
      #element.alternate.normal {
          background-color: @background;
          text-color:       @foreground;
      }
      #element.alternate.urgent {
          background-color: @urgent-background;
          text-color:       @foreground;
      }
      #element.alternate.active {
          background-color: @active-background;
          text-color:       @foreground;
      }
      #scrollbar {
          width:        2px ;
          border:       0;
          handle-width: 8px ;
          padding:      0;
      }
      #sidebar {
          border:       2px dash 0px 0px ;
          border-color: @separatorcolor;
      }
      #button.selected {
          background-color: @selected-background;
          text-color:       @foreground;
      }
      #inputbar {
          spacing:    0;
          text-color: @foreground;
          padding:    1px ;
      }
      #case-indicator {
          spacing:    0;
          text-color: @foreground;
      }
      #entry {
          spacing:    0;
          text-color: @foreground;
      }
      #prompt {
          spacing:    0;
          text-color: @foreground;
      }
      #inputbar {
          children:   [ prompt,textbox-prompt-colon,entry,case-indicator ];
      }
      #textbox-prompt-colon {
          expand:     false;
          str:        ":";
          margin:     0px 0.3em 0em 0em ;
          text-color: @foreground;
      }
    '';
    ".config/rofi/themes/onedark.rasi".text = ''
      /*
       * ROFI One Dark
       *
       * Based on OneDark.vim (https://github.com/joshdick/onedark.vim)
       *
       * Author: Benjamin Stauss
       * User: me-benni
       *
       */


      * {
        black:      #000000;
        red:        #eb6e67;
        green:      #95ee8f;
        yellow:     #f8c456;
        blue:       #6eaafb;
        mangenta:   #d886f3;
        cyan:       #6cdcf7;
        emphasis:   #50536b;
        text:       #dfdfdf;
        text-alt:   #b2b2b2;
        fg:         #abb2bf;
        bg:         #282c34;

        spacing: 0;
        background-color: transparent;

        /*font: "Knack Nerd Font 14";*/
        text-color: @text;
      }

      window {
        transparency: "real";
        fullscreen: true;
        background-color: #282c34dd;
      }

      mainbox {
        padding: 30% 30%;
      }

      inputbar {
        margin: 0px 0px 20px 0px;
        children: [prompt, textbox-prompt-colon, entry, case-indicator];
      }

      prompt {
        text-color: @blue;
      }

      textbox-prompt-colon {
        expand: false;
        str: ":";
        text-color: @text-alt;
      }

      entry {
        margin: 0px 10px;
      }

      listview {
        spacing: 5px;
        dynamic: true;
        scrollbar: false;
      }

      element {
        padding: 5px;
        text-color: @text-alt;
        highlight: bold #95ee8f; /* green */
        border-radius: 3px;
      }

      element selected {
        background-color: @emphasis;
        text-color: @text;
      }

      element urgent, element selected urgent {
        text-color: @red;
      }

      element active, element selected active {
        text-color: @purple;
      }

      message {
        padding: 5px;
        border-radius: 3px;
        background-color: @emphasis;
        border: 1px;
        border-color: @cyan;
      }

      button selected {
        padding: 5px;
        border-radius: 3px;
        background-color: @emphasis;
      }
    '';
    ".config/rofi/themes/oxide.rasi".text = ''
      /**
       * Oxide Color theme
       * User: dikiaap
       * Copyright: Diki Ananta
       **/
      * {
          selected-normal-foreground:  @lightfg;
          foreground:                  rgba ( 196, 202, 212, 100 % );
          normal-foreground:           @foreground;
          alternate-normal-background: rgba ( 42, 42, 42, 100 % );
          red:                         rgba ( 194, 65, 65, 100 % );
          selected-urgent-foreground:  @lightfg;
          blue:                        rgba ( 43, 131, 166, 100 % );
          urgent-foreground:           @lightfg;
          alternate-urgent-background: @red;
          active-foreground:           @lightfg;
          lightbg:                     @foreground;
          selected-active-foreground:  @lightfg;
          alternate-active-background: @blue;
          background:                  rgba ( 33, 33, 33, 100 % );
          alternate-normal-foreground: @foreground;
          normal-background:           @background;
          lightfg:                     rgba ( 249, 249, 249, 100 % );
          selected-normal-background:  rgba ( 90, 90, 90, 100 % );
          border-color:                @foreground;
          spacing:                     2;
          separatorcolor:              rgba ( 183, 183, 183, 100 % );
          urgent-background:           @red;
          selected-urgent-background:  rgba ( 214, 78, 78, 100 % );
          alternate-urgent-foreground: @urgent-foreground;
          background-color:            rgba ( 0, 0, 0, 0 % );
          alternate-active-foreground: @active-foreground;
          active-background:           @blue;
          selected-active-background:  rgba ( 39, 141, 182, 100 % );
      }
      window {
          background-color: @background;
          border:           0;
          padding:          8;
      }
      mainbox {
          border:  0;
          padding: 0;
      }
      message {
          border:       2px dash 0px 0px;
          border-color: @separatorcolor;
          padding:      1px;
      }
      textbox {
          text-color: @foreground;
      }
      listview {
          fixed-height: 0;
          border:       0;
          border-color: @separatorcolor;
          spacing:      2px;
          scrollbar:    true;
          padding:      2px 0px 0px;
      }
      element {
          border:  0;
          padding: 1px;
      }
      element normal.normal {
          background-color: @normal-background;
          text-color:       @normal-foreground;
      }
      element normal.urgent {
          background-color: @urgent-background;
          text-color:       @urgent-foreground;
      }
      element normal.active {
          background-color: @active-background;
          text-color:       @active-foreground;
      }
      element selected.normal {
          background-color: @selected-normal-background;
          text-color:       @selected-normal-foreground;
      }
      element selected.urgent {
          background-color: @selected-urgent-background;
          text-color:       @selected-urgent-foreground;
      }
      element selected.active {
          background-color: @selected-active-background;
          text-color:       @selected-active-foreground;
      }
      element alternate.normal {
          background-color: @alternate-normal-background;
          text-color:       @alternate-normal-foreground;
      }
      element alternate.urgent {
          background-color: @alternate-urgent-background;
          text-color:       @alternate-urgent-foreground;
      }
      element alternate.active {
          background-color: @alternate-active-background;
          text-color:       @alternate-active-foreground;
      }
      scrollbar {
          width:        4px;
          border:       0;
          handle-color: rgba ( 85, 85, 85, 100 % );
          handle-width: 8px;
          padding:      0;
      }
      mode-switcher {
          border:       2px dash 0px 0px;
          border-color: @separatorcolor;
      }
      button {
          spacing:    0;
          text-color: @normal-foreground;
      }
      button selected {
          background-color: @selected-normal-background;
          text-color:       @selected-normal-foreground;
      }
      inputbar {
          spacing:    0px;
          text-color: @normal-foreground;
          padding:    1px;
          children:   [ prompt,textbox-prompt-colon,entry,case-indicator ];
      }
      case-indicator {
          spacing:    0;
          text-color: @normal-foreground;
      }
      entry {
          spacing:    0;
          text-color: @normal-foreground;
      }
      prompt {
          spacing:    0;
          text-color: @normal-foreground;
      }
      textbox-prompt-colon {
          expand:     false;
          str:        ":";
          margin:     0px 0.3000em 0.0000em 0.0000em;
          text-color: inherit;
      }
    '';
    ".config/rofi/themes/rezlooks.rasi".text = ''
      /**
       * ROFI Color theme
       * User: thorsten
       * Inspired by the rezlooks gtk theme
       */
      * {
          selected-normal-foreground:  rgba ( 245, 245, 245, 100 % );
          foreground:                  #3d3d3d;
          normal-foreground:           @foreground;
          textbox-background:          rgba( 255, 255, 255, 95% );
          alternate-normal-background: rgba ( 150, 150, 150, 20%) ;
          red:                         rgba ( 220, 50, 47, 100 % );
          selected-urgent-foreground:  rgba ( 245, 245, 245, 100 % );
          blue:                        rgba ( 38, 139, 210, 100 % );
          urgent-foreground:           rgba ( 215, 95, 0, 100 % );
          alternate-urgent-background: rgba ( 208, 208, 208, 100 % );
          active-foreground:           #2D661A ;
          lightbg:                     rgba ( 238, 232, 213, 100 % );
          selected-active-foreground:  rgba ( 245, 245, 245, 100 % );
          alternate-active-background: rgba ( 208, 208, 208, 100 % );
          /*background:                  rgba ( 245, 245, 245, 100 % ); */
          background:                  #F2F2F2;
          alternate-normal-foreground: @foreground;
          dark-border-color:           #8C836E;
          normal-background:           transparent;
          lightfg:                     rgba ( 88, 104, 117, 100 % );
          selected-normal-background:  rgba ( 152, 177, 127, 100 % );
          border-color:                rgba ( 80, 80,80, 100%) ;
          spacing:                     2;
          separatorcolor:               #D3C8AE;
          urgent-background:           rgba ( 245, 245, 245, 100 % );
          selected-urgent-background:  rgba ( 215, 95, 0, 100 % );
          alternate-urgent-foreground: @urgent-foreground;
          background-color:            transparent;
          alternate-active-foreground: @active-foreground;
          active-background:           rgba ( 245, 245, 245, 100 % );
          selected-active-background:  #2B591C;
          /*font: "Bitstream Vera Sans 8";*/
          monospace: "Bitstream Vera Sans Mono 8";
      }

      #window {
          background-color: transparent;
          border:           1;
          padding:          0px;
          spacing: 0;
          children: [ windowinnerborder ];
      }

      #windowinnerborder {
          border: 3px;
          border-color: #789C54;
          children: [ tabcontent ];
      }

      #tabcontent {
          children: [ topborder, mode-switcher, mainbox ];
          background-color: transparent;
          spacing: 0;
          border: 8px;
          border-color: @background;
          padding: 0px;
      }

      #topborder {
          border-color: @dark-border-color;
          expand: false;
          border: 1px 0px 0px 0px;
          height: 0px;
      }

      #mainbox {
          background-color: transparent;
          border:  0;
          padding: 0px 8px 8px 8px;
          spacing: 0px;
          children:   [ inputbarBorder, message, listviewBorder ];
          margin: 0px;
          padding: 0px;
          border: 0px 1px 1px 1px;
          border-color: @dark-border-color;
      }

      #inputbarBorder {
          border: 8px;
          border-color: @background;
          children: [ inputbar ];
          expand: false;
      }

      #listviewBorder {
          border: 0px 8px 8px 8px;
          border-color: @background;
          children: [ listview ];
          expand: false;
      }

      #message {
          padding:      3px ;
          border: 0px 8px 8px 8px;
          border-color: @background;
          background-color: @background;
      }

      #textbox {
          text-color: @foreground;
          /*font: @monospace;*/
      }
      #listview {
          fixed-height: 0;
          border:       1px;
          border-color: @separatorcolor;
          spacing:      2px ;
          scrollbar:    true;
          padding:      2px ;
          background-color: @textbox-background;
      }
      #element {
          border:  0;
          padding: 3px ;
          /*font: @monospace;*/
      }
      #element.normal.normal {
          background-color: @normal-background;
          text-color:       @normal-foreground;
      }
      #element.normal.urgent {
          background-color: @urgent-background;
          text-color:       @urgent-foreground;
      }
      #element.normal.active {
          background-color: @active-background;
          text-color:       @active-foreground;
      }
      #element.selected.normal {
          background-color: @selected-normal-background;
          text-color:       @selected-normal-foreground;
      }
      #element.selected.urgent {
          background-color: @selected-urgent-background;
          text-color:       @selected-urgent-foreground;
      }
      #element.selected.active {
          background-color: @selected-active-background;
          text-color:       @selected-active-foreground;
      }
      #element.alternate.normal {
          background-color: @alternate-normal-background;
          text-color:       @alternate-normal-foreground;
      }
      #element.alternate.urgent {
          background-color: @alternate-urgent-background;
          text-color:       @alternate-urgent-foreground;
      }
      #element.alternate.active {
          background-color: @alternate-active-background;
          text-color:       @alternate-active-foreground;
      }
      #scrollbar {
          width:        4px ;
          border:       0;
          handle-width: 8px ;
          padding:      0;
      }
      #mode-switcher {
          border:       0px 0px 0px 1px;
          border-color: @dark-border-color;
          spacing: 0px;
          padding: 0px 0px 0px 0px;
      }
      #button {
          margin: 0px 0px 0px 0px;
          background-color: #DBDBDB;
          border: 0px 1px 1px 0px;
          border-color: @dark-border-color;
          padding: 8px 0px 8px 0px;
      }

      #button.selected {
          margin: 0px 0px 0px 0px;
          border: 3px 1px 0px 0px;
          background-color: @background;
          text-color:       #212121;
          border-color: @dark-border-color;
      }
      #inputbar {
          spacing:    0px;
          text-color: @normal-foreground;
          padding:    0px ;
          border-color: @separatorcolor;
          border: 1px;
          background-color: transparent;
      }

      #case-indicator { padding: 2px; }
      #prompt { padding: 2px 6px; }
      #entry { padding: 2px 6px; }

      #case-indicator {
          spacing:    0;
          text-color: @normal-foreground;
          background-color: @textbox-background;
      }
      #entry {
          spacing:    0;
          text-color: @normal-foreground;
          background-color: @textbox-background;
      }
      #prompt {
          spacing:    0;
          background-color: @background ;
          text-color: @normal-foreground;
          border: 0px 1px 0px 0px;
          border-color: @separatorcolor;
          text: @monospace;
          highlight: bold red;
      }
      #inputbar {
          children:   [ prompt,entry,case-indicator ];
      }

      // vim: ft=css
    '';
    ".config/rofi/themes/ribbon.rasi".text = ''
      /**
       * ROFI Color theme
       * User: Rokit
      */

      * {
        base-bg: #d9d6b7ee;
        selected-bg: #f7f0ac;
        base-color: #222222aa;
        selected-color: #222;
        border-color: #00000066;
        transparent: #00000000;
        text-color: @base-color;
        /*font: "Times New Roman 20";*/
      }
      #window {
        anchor: south;
        location: south;
        width: 100%;
        background-color: @base-bg;
        margin: 0px 0px 10% 0px;
        children: [ horibox ];
      }
      #horibox {
        background-color: @transparent;
        orientation: horizontal;
        children: [ prompt, textbox-prompt-colon, entry, listview ];
      }
      #prompt {
        text-color: @selected-color;
        padding: 0.7em 0px 0.7em 10px;
        background-color: @transparent;
      }
      #textbox-prompt-colon  {
        expand: false;
        str: ":";
        padding: 0.7em 10px 0.7em 0px;
        text-color: @selected-color;
        background-color: @transparent;
      }
      #entry {
        padding: 0.7em;
        text-color: @selected-color;
        background-color: #eee;
        expand: false;
        width: 10em;
      }
      #listview {
        background-color: @transparent;
        layout: horizontal;
        spacing: 5px;
        lines: 100;
      }
      #element {
        background-color: @transparent;
        padding: 0.7em;
      }
      #element selected {
        border: 0px 1px;
        text-color: @selected-color;
        background-color: @selected-bg;
      }
    '';
    ".config/rofi/themes/sidetab-adapta.rasi".text = ''
      /*
       * sidetab-adapta theme,
       * based on sidetab theme by deadguy.
       *
       * This theme has been dedicated to the public domain.
       *
       */

      configuration {
              show-icons:   true;
              sidebar-mode: true;
      }

      * {
              background-color:           #222d32;
              text-color:                 #ffffff;

              accent-color:               #00bcd4;
              accent2-color:              #4db6ac;
              hover-color:                #39454b;
              urgent-color:               #ff5252;
              window-color:               #ffffff;

              selected-normal-foreground: @window-color;
              normal-foreground:          @text-color;
              selected-normal-background: @hover-color;
              normal-background:          @background-color;

              selected-urgent-foreground: @background-color;
              urgent-foreground:          @text-color;
              selected-urgent-background: @urgent-color;
              urgent-background:          @background-color;

              selected-active-foreground: @window-color;
              active-foreground:          @text-color;
              selected-active-background: @hover-color;
              active-background:          @accent-color;
      }

      #window {
              anchor:   west;
              location: west;
              width:    384px;
              height:   100%;
      }

      #mainbox {
              children: [ entry, listview, mode-switcher ];
      }

      entry {
              expand: false;
              margin: 8px;
      }

      element {
              padding: 8px;
      }

      element normal.normal {
              background-color: @normal-background;
              text-color:       @normal-foreground;
      }

      element normal.urgent {
              background-color: @urgent-background;
              text-color:       @urgent-foreground;
      }

      element normal.active {
              background-color: @active-background;
              text-color:       @active-foreground;
      }

      element selected.normal {
              background-color: @selected-normal-background;
              text-color:       @selected-normal-foreground;
              border:           0 4px solid 0 0;
              border-color:     @accent2-color;
      }

      element selected.urgent {
              background-color: @selected-urgent-background;
              text-color:       @selected-urgent-foreground;
      }

      element selected.active {
              background-color: @selected-active-background;
              text-color:       @selected-active-foreground;
      }

      element alternate.normal {
              background-color: @normal-background;
              text-color:       @normal-foreground;
      }

      element alternate.urgent {
              background-color: @urgent-background;
              text-color:       @urgent-foreground;
      }

      element alternate.active {
              background-color: @active-background;
              text-color:       @active-foreground;
      }

      button {
              padding: 8px;
      }

      button selected {
              background-color: @active-background;
              text-color:       @background-color;
      }

      /* vim: ft=css
    '';
    ".config/rofi/themes/sidetab.rasi".text = ''
      /**
       * User: deadguy
       * Copyright: deadguy
       */

      configuration {
          display-drun:    "Activate";
          display-run:     "Execute";
          display-window:  "Window";
          show-icons:      true;
          sidebar-mode:    true;
      }

      * {
          background-color:            #080808;
          text-color:                  #d3d7cf;
          selbg:                       #215d9c;
          actbg:                       #262626;
          urgbg:                       #e53935;
          winbg:			     #26c6da;

          selected-normal-foreground:  @winbg;
          normal-foreground:           @text-color;
          selected-normal-background:  @actbg;
          normal-background:           @background-color;

          selected-urgent-foreground:  @background-color;
          urgent-foreground:           @text-color;
          selected-urgent-background:  @urgbg;
          urgent-background:           @background-color;

          selected-active-foreground:  @winbg;
          active-foreground:           @text-color;
          selected-active-background:  @actbg;
          active-background:           @selbg;

          line-margin:                 2;
          line-padding:                2;
          separator-style:             "none";
          hide-scrollbar:              "true";
          margin:                      0;
          padding:                     0;
      }

      window {
          location:	 west;
          anchor:		 west;
          height:		 100%;
          width:		 22%;
          orientation: horizontal;
          children:	 [mainbox];
      }

      mainbox {
          spacing:  0.8em;
          children: [ entry,listview,mode-switcher ];
      }

      button { padding: 5px 2px; }

      button selected {
          background-color: @active-background;
          text-color:       @background-color;
      }

      inputbar {
          padding: 5px;
          spacing: 5px;
      }

      listview {
          spacing: 0.5em;
          dynamic: false;
          cycle:   true;
      }

      element { padding: 10px; }

      entry {
          expand:         false;
          text-color:     @normal-foreground;
          vertical-align: 1;
          padding:        5px;
      }

      element normal.normal {
          background-color: @normal-background;
          text-color:       @normal-foreground;
      }

      element normal.urgent {
          background-color: @urgent-background;
          text-color:       @urgent-foreground;
      }

      element normal.active {
          background-color: @active-background;
          text-color:       @active-foreground;
      }

      element selected.normal {
          background-color: @selected-normal-background;
          text-color:       @selected-normal-foreground;
          border:           0 5px solid 0 0;
          border-color:	    @active-background;
      }

      element selected.urgent {
          background-color: @selected-urgent-background;
          text-color:       @selected-urgent-foreground;
      }

      element selected.active {
          background-color: @selected-active-background;
          text-color:       @selected-active-foreground;
      }

      element alternate.normal {
          background-color: @normal-background;
          text-color:       @normal-foreground;
      }

      element alternate.urgent {
          background-color: @urgent-background;
          text-color:       @urgent-foreground;
      }

      element alternate.active {
          background-color: @active-background;
          text-color:       @active-foreground;
      }
    '';
    ".config/rofi/themes/slate.rasi".text = ''
      * {
        background-color: #282C33;
        border-color: #2e343f;
        text-color: #8ca0aa;
        spacing: 0;
        width: 512px;
      }

      inputbar {
        border: 0 0 1px 0;
        children: [prompt,entry];
      }

      prompt {
        padding: 16px;
        border: 0 1px 0 0;
      }

      textbox {
        background-color: #2e343f;
        border: 0 0 1px 0;
        border-color: #282C33;
        padding: 8px 16px;
      }

      entry {
        padding: 16px;
      }

      listview {
        cycle: false;
        margin: 0 0 -1px 0;
        scrollbar: false;
      }

      element {
        border: 0 0 1px 0;
        padding: 16px;
      }

      element selected {
        background-color: #2e343f;
      }
    '';
    ".config/rofi/themes/solarized-darker.rasi".text = ''
      /******************************************************************************
       * ROFI Color theme
       * User: DeanPdx
       * Copyright: Dean Davidson
       ******************************************************************************/

      * {
          /**** Solarized colors ****
          * NOTE: I am including all of them even though I am using a sub-set. I keep
          * tweaking my theme and having access to all of the colors here is handy. */

          base03: #002b36;
          base02: #073642;
          base01: #586e75;
          base00: #657b83;
          base0: #839496;
          base1: #93a1a1;
          base2: #eee8d5;
          base3: #fdf6e3;
          yellow: #b58900;
          orange: #cb4b16;
          red: #dc322f;
          magenta: #d33682;
          violet: #6c71c4;
          blue: #268bd2;
          cyan: #2aa198;
          green: #859900;

          /* Solarized Darker Theme */
          transparent-background: rgba ( 0, 0, 0, 0 % );
          foreground:                  @base0;
          background:                  rgba ( 0, 0, 0, 90 % );

          normal-foreground:           @foreground;
          normal-background:           @transparent-background;
          active-foreground:           @green;
          active-background:           @transparent-background;
          urgent-foreground:           @red;
          urgent-background:           @transparent-background;

          selected-normal-foreground:  @magenta;
          selected-normal-background:  @base02;
          selected-active-foreground:  @green;
          selected-active-background:  @base02;
          selected-urgent-foreground:  @red;
          selected-urgent-background:  @base02;

          alternate-normal-foreground: @foreground;
          alternate-normal-background: @transparent-background;
          alternate-active-foreground: @active-foreground;
          alternate-active-background: @transparent-background;
          alternate-urgent-foreground: @urgent-foreground;
          alternate-urgent-background: @transparent-background;

          separatorcolor:              @blue;

          /* Main element styles */
          border-color:                @blue;
          spacing:                     2;
          background-color:            @transparent-background;
      }
      window {
          background-color: @background;
          border:           1;
          padding:          20;
      }
      mainbox {
          border:  0;
          padding: 0;
      }
      message {
          border:       1px dash 0px 0px ;
          border-color: @separatorcolor;
          padding:      1px ;
      }
      textbox {
          text-color: @foreground;
      }
      listview {
          fixed-height: 0;
          border:       1px dash 0px 0px ;
          border-color: @separatorcolor;
          spacing:      2px ;
          scrollbar:    false;
          padding:      8px 0px 0px 0px;
      }
      element {
          border:  0;
          padding: 1px 0px 1px 1px;
      }
      element-text {
          background-color: inherit;
          text-color:       inherit;
      }
      element normal.normal {
          background-color: @normal-background;
          text-color:       @normal-foreground;
      }
      element normal.urgent {
          background-color: @urgent-background;
          text-color:       @urgent-foreground;
      }
      element normal.active {
          background-color: @active-background;
          text-color:       @active-foreground;
      }
      element selected.normal {
          background-color: @selected-normal-background;
          text-color:       @selected-normal-foreground;
      }
      element selected.urgent {
          background-color: @selected-urgent-background;
          text-color:       @selected-urgent-foreground;
      }
      element selected.active {
          background-color: @selected-active-background;
          text-color:       @selected-active-foreground;
      }
      element alternate.normal {
          background-color: @alternate-normal-background;
          text-color:       @alternate-normal-foreground;
      }
      element alternate.urgent {
          background-color: @alternate-urgent-background;
          text-color:       @alternate-urgent-foreground;
      }
      element alternate.active {
          background-color: @alternate-active-background;
          text-color:       @alternate-active-foreground;
      }
      scrollbar {
          width:        4px ;
          border:       0;
          handle-width: 8px ;
          padding:      0;
      }
      mode-switcher {
          border:       2px dash 0px 0px ;
          border-color: @separatorcolor;
      }
      button selected {
          background-color: @selected-normal-background;
          text-color:       @selected-normal-foreground;
      }
      inputbar {
          spacing:    0;
          text-color: @normal-foreground;
          padding:    1px ;
      }
      case-indicator {
          spacing:    0;
          text-color: @normal-foreground;
      }
      entry {
          spacing:    0;
          text-color: @normal-foreground;
      }
      prompt {
          spacing:    0;
          text-color: @normal-foreground;
      }
    '';
    ".config/rofi/themes/README.md".text = ''
      #### fancy
      ![fancy](https://53280.de/rofi/fancy.png)

      #### flat-orange
      ![flat_orange](https://53280.de/rofi/flat_orange.png)

      #### oxide
      ![oxide](https://53280.de/rofi/oxide.png)

      #### solarized-darker
      ![solarized_darker](https://53280.de/rofi/solarized_darker.png)

      #### sidetab
      ![sidetab](https://53280.de/rofi/sidetab.png)

      #### material
      ![material](https://53280.de/rofi/material.png)

      #### arc-red-dark
      ![arc-red-dark](https://53280.de/rofi/arc-red.png)

      #### onedark
      ![onedark](https://53280.de/rofi/onedark.png)

      #### ribbon
      ![ribbon](https://53280.de/rofi/ribbon.png)

      #### rezlooks
      ![rezlooks](https://53280.de/rofi/rezlooks.png)

      #### slate
      ![slate](https://53280.de/rofi/slate.png)

      #### flamingo
      ![flamingo](https://53280.de/rofi/flamingo.png)

      #### cloud
      ![cloud](https://53280.de/rofi/cloud.png)

      #### merah
      ![merah](https://raw.githubusercontent.com/ipang-dwi/merah/master/img2.jpg)
    '';
  };
}
