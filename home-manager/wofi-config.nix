{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/wofi/config".text = ''
      width=800
      height=400
      insensitive=true
      mode=drun,run
    '';
    ".config/wofi/kali.css".text = ''
      /* https://cloudninja.pw/docs/wofi.html */
      window {
          border: 2px solid #367bf0;
          color: #000000;
          background-color: #1f2229; 
      }

      #input {
          color: #000000; 
          border: 2px solid black;
          background-color: #e6e6e6;
          font-size: 18px;
      }


      #outer-box {
          margin: 10px;
      }

      #scroll {
          margin: 5px 0px;
          font-size: 16px;
          color: #ffffff;
      }

      #scroll label {
          margin: 2px 0px;
      }

      #entry:selected {
          color: #000000; 
          background-color: #367bf0;
      }

      #text:selected {
          color: #000000; 
      }
    '';
    ".config/wofi/pop-os.css".text = ''
      /* https://cloudninja.pw/docs/wofi.html */
      window {
          border: 2px solid black;
          color: #ffffff;
          background-color: #232121; 
      }

      #input {
          color: #000000; 
          border: 2px solid black;
          background-color: #ffd7a1;
          font-size: 18px;
      }

      #outer-box {
          margin: 10px;
      }

      #scroll {
          margin: 5px 0px;
          font-size: 16px;
          color: #ffffff;
      }

      #scroll label {
          margin: 2px 0px;
      }

      #entry:selected {
          color: #000000; 
          background-color: #93eaea;
      }

      #text:selected {
          color: #000000; 
      }
    '';
    ".config/wofi/solarized-dark.css".text = ''
      /* https://cloudninja.pw/docs/wofi.html */
      window {
          border: 2px solid black;
          background-color: #073642; 
      }

      #input {
          color: #b58900; 
          border: 2px solid black;
          background-color: #657b83;
          font-size: 18px;
      }

      #outer-box {
          margin: 10px;
      }

      #scroll {
          margin: 5px 0px;
          font-size: 16px;
          color: #93a1a1;
      }

      #scroll label {
          margin: 2px 0px;
      }

      #entry:selected {
          color: #b58900; 
          background-color: #93a1a1;
      }

      #text:selected {
          color: #000000; 
      }
    '';
  };
}
