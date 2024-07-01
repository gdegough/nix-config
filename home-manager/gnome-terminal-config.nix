{
  config,
  pkgs,
  ...
}:
{
  programs.gnome-terminal= {
    enable = true;
    showMenubar = true;
    profile = {
      "2eebedb8-353a-4f0f-ba33-67bc99753b4f" = {
        visibleName = "Profile";
	    scrollOnOutput = false;
      };
      "e70f980a-db25-4d34-b350-ecea2e81710f" = {
        visibleName = "Solarized (dark)";
	    cursorShape = "block";
	    showScrollbar = false;
	    scrollOnOutput = false;
        audibleBell = false;
        transparencyPercent = 90;
        colors = {
          foregroundColor = "rgb(131,148,150)";
          backgroundColor = "rgb(0,43,54)";
          palette = [ 
	        "rgb(7,54,66)" 
	        "rgb(220,50,47)" 
	        "rgb(133,153,0)" 
	        "rgb(181,137,0)" 
	        "rgb(38,139,210)" 
	        "rgb(211,54,130)" 
	        "rgb(42,161,152)" 
	        "rgb(238,232,213)" 
	        "rgb(0,43,54)" 
	        "rgb(203,75,22)" 
	        "rgb(88,110,117)" 
	        "rgb(101,123,131)" 
	        "rgb(131,148,150)" 
	        "rgb(108,113,196)" 
	        "rgb(147,161,161)" 
	        "rgb(253,246,227)" 
	      ];
	    };
      };
      "4d444022-d638-4336-85b2-56d7796081a0" = {
        visibleName = "Kali (dark)";
	    cursorShape = "block";
	    showScrollbar = false;
	    scrollOnOutput = false;
        audibleBell = false;
        transparencyPercent = 90;
        colors = {
          foregroundColor = "rgb(208,207,204)";
          backgroundColor = "rgb(23,20,33)";
          palette = [ 
            "rgb(23,20,33)" 
            "rgb(192,28,40)" 
            "rgb(38,162,105)" 
            "rgb(162,115,76)" 
            "rgb(18,72,139)" 
            "rgb(163,71,186)" 
            "rgb(42,161,179)" 
            "rgb(208,207,204)" 
            "rgb(94,92,100)" 
            "rgb(246,97,81)" 
            "rgb(51,209,122)" 
            "rgb(233,173,12)" 
            "rgb(42,123,222)" 
            "rgb(192,97,203)" 
            "rgb(51,199,222)" 
            "rgb(255,255,255)" 
          ];
	    };
      };
      "424d1305-da99-4b8a-973c-1dec6c44cf1e" = {
        default = true;
        visibleName = "Gruvbox (dark)";
	    cursorShape = "block";
	    showScrollbar = false;
	    scrollOnOutput = false;
        audibleBell = false;
        transparencyPercent = 90;
        colors = {
          foregroundColor = "rgb(235,219,178)";
          backgroundColor = "rgb(40,40,40)";
          palette = [ 
            "rgb(40,40,40)" 
            "rgb(204,36,29)" 
            "rgb(152,151,26)" 
            "rgb(215,153,33)" 
            "rgb(69,133,136)" 
            "rgb(177,98,134)" 
            "rgb(104,157,106)" 
            "rgb(168,153,132)" 
            "rgb(146,131,116)" 
            "rgb(251,73,52)" 
            "rgb(184,187,38)" 
            "rgb(250,189,47)" 
            "rgb(131,165,152)" 
            "rgb(211,134,155)" 
            "rgb(142,192,124)" 
            "rgb(235,219,178)" 
          ];
	    };
      };
      "16867e22-c36f-4f36-9649-e8bb978fc8b4" = {
        visibleName = "GNOME (dark)";
	    cursorShape = "block";
	    showScrollbar = false;
	    scrollOnOutput = false;
        audibleBell = false;
        transparencyPercent = 90;
      };
    };
  };  
}
