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
    pkgs.conky
  ];
  home.file = { 
    ".config/autostart/conky.desktop".text = ''
      [Desktop Entry]
      Comment[en_US]=System Monitor
      Comment=System Monitor
      Encoding=UTF-8
      TryExec=conky
      Exec=conky -p 10 -d -b -c "/home/${config.home.username}/.config/conky/conky.conf"
      GenericName[en_US]=
      GenericName=
      Hidden=false
      MimeType=
      Name[en_US]=Conky
      Name=Conky
      Path=
      Icon=conky-logomark-violet
      StartupNotify=false
      Terminal=false
      TerminalOptions=
      Type=Application
      X-DBUS-ServiceName=
      X-DBUS-StartupType=
      NotShowIn=i3;sway;hyprland;
    '';
    ".config/conky/conky.conf".text = ''
      --[[
      -- Color Definitions 
      -- solarized-white
          default_color = 'eee8d5',
          default_outline_color = 'eee8d5',
          default_shade_color = 'eee8d5',
      -- gnome-blue
          default_color = '3584E4',
          default_outline_color = '3584E4',
          default_shade_color = '3584E4',
      -- arch-blue
          default_color = '1693cf',
          default_outline_color = '1693cf',
          default_shade_color = '1693cf',
      -- black
          default_color = 'black',
          default_outline_color = 'black',
          default_shade_color = 'black',
      -- cyan
          default_color = 'cyan',
          default_outline_color = 'cyan',
          default_shade_color = 'cyan',
      -- green
          default_color = 'green',
          default_outline_color = 'green',
          default_shade_color = 'green',
      -- manjaro
          default_color = '00b08d',
          default_outline_color = '00b08d',
          default_shade_color = '01b08d',
      -- pop-cyan
          default_color = '95f5f1',
          default_outline_color = '95f5f1',
          default_shade_color = '95f5f1',
      -- pop-yellow
          default_color = 'F28C2A',
          default_outline_color = 'F28C2A',
          default_shade_color = 'F28C2A',
      -- white
          default_color = 'white',
          default_outline_color = 'white',
          default_shade_color = 'white',
      ]]

      conky.config = {
        alignment = "top_right",
        background = false,
        border_width = 0,
        cpu_avg_samples = 2,
        default_color = "eee8d5",
        default_outline_color = "eee8d5",
        default_shade_color = "eee8d5",
        draw_borders = false,
        draw_graph_borders = false,
        draw_outline = false,
        draw_shades = false,
        use_xft = true,
        font = "IBM Plex Mono:Text:size=8",
        gap_x = 10,
        gap_y = 30,
        minimum_height = 5,
        minimum_width = 5,
        net_avg_samples = 2,
        no_buffers = true,
        out_to_console = false,
        out_to_stderr = false,
        extra_newline = false,
        own_window = true,
        own_window_class = "Conky",
        own_window_type = "normal",
        own_window_transparent = true,
        own_window_argb_visual = true,
        own_window_argb_value = 100,
        own_window_hints = "undecorated,below,sticky,skip_taskbar,skip_pager",
        stippled_borders = 0,
        update_interval = 2.0,
        uppercase = false,
        use_spacer = "none",
        show_graph_scale = false,
        show_graph_range = false
      }

      conky.text = [[
      ''${font IBM Plex Mono:Medium:size=20}''${time %H:%M}''${font}
      ''${font IBM Plex Mono:Text:size=10}''${time %A %Y-%m-%d}''${font}
      $hr
      ''${font IBM Plex Mono:Medium:size=11}''${texeci 86400 awk -F "=" '/^(NAME=)(.+)/{print $2}' "/etc/os-release" | tr -d '"'}''${font}

      Kernel: $kernel
      Uptime: $uptime
      $hr
      RAM: $mem/$memmax - $memperc% ''${membar 6}
      Swap: $swap/$swapmax - $swapperc% ''${swapbar 6}
      $hr
      Battery:
        Charge: ''${battery_percent BAT0}% ''${battery_bar 6 BAT0}
        Dis/Charge: ''${battery_time BAT0}
      $hr
      CPU:
        Usage: $cpu% ''${cpubar 6}
        Frequency (in GHz): $freq_g
        01: ''${cpu cpu1}% (''${freq_g 1}GHz) ''${goto 140}''${cpugraph cpu1 8,0 104E8B ff0000 -t}
        02: ''${cpu cpu2}% (''${freq_g 2}GHz) ''${goto 140}''${cpugraph cpu2 8,0 104E8B ff0000 -t}
        03: ''${cpu cpu3}% (''${freq_g 3}GHz) ''${goto 140}''${cpugraph cpu3 8,0 104E8B ff0000 -t}
        04: ''${cpu cpu4}% (''${freq_g 4}GHz) ''${goto 140}''${cpugraph cpu4 8,0 104E8B ff0000 -t}
      Load (avg): ''${goto 140}''${loadgraph 8,0 104E8B ff0000 -t}
         1 min: ''${loadavg 1}   5 min: ''${loadavg 2}
        15 min: ''${loadavg 3} 
      $hr
      Processes:
        Total: $processes  Running: $running_processes
      Name                   PID   CPU%   MEM%
        ''${top name 1} ''${top pid 1} ''${top cpu 1} ''${top mem 1}
        ''${top name 2} ''${top pid 2} ''${top cpu 2} ''${top mem 2}
        ''${top name 3} ''${top pid 3} ''${top cpu 3} ''${top mem 3}
        ''${top name 4} ''${top pid 4} ''${top cpu 4} ''${top mem 4}
        ''${top name 5} ''${top pid 5} ''${top cpu 5} ''${top mem 5}
        ''${top name 6} ''${top pid 6} ''${top cpu 6} ''${top mem 6}
        ''${top name 7} ''${top pid 7} ''${top cpu 7} ''${top mem 7}
        ''${top name 8} ''${top pid 8} ''${top cpu 8} ''${top mem 8}
      $hr
      Temps (C):
        CPU: ''${hwmon coretemp temp 1}°
          Core 1: ''${hwmon coretemp temp 2}°   Core 2: ''${hwmon coretemp temp 3}°
      $hr
      Networking:
        wlp2s0:
            Up: ''${upspeed wlp2s0} ''${goto 140}''${upspeedgraph wlp2s0 8,0 104E8B ff0000 -t}
          Down: ''${downspeed wlp2s0} ''${goto 140}''${downspeedgraph wlp2s0 8,0 104E8B ff0000 -t}
      $hr
      File systems:''${if_mounted /boot}
        efi ''${fs_used /boot}/''${fs_size /boot} ''${fs_bar 6 /boot}$endif''${if_mounted /nixos}
        nixos ''${fs_used /nixos}/''${fs_size /nixos} ''${fs_bar 6 /nixos}$endif''${if_mounted /mnt/backup/128Gext}
        128Gext ''${fs_used /mnt/backup/128Gext}/''${fs_size /mnt/backup/128Gext} ''${fs_bar 6 /mnt/backup/128Gext}$endif''${if_mounted /mnt/backup/256Gext}
        256Gext ''${fs_used /mnt/backup/256Gext}/''${fs_size /mnt/backup/256Gext} ''${fs_bar 6 /mnt/backup/256Gext}$endif
      Disk I/O:
            sda: ''${diskio sda} ''${goto 140}''${diskiograph sda 8,0 104E8B ff0000 -t}
            sdb: ''${diskio sdb} ''${goto 140}''${diskiograph sdb 8,0 104E8B ff0000 -t}
            sdc: ''${diskio sdc} ''${goto 140}''${diskiograph sdc 8,0 104E8B ff0000 -t}
      ]]
    '';
  };
}
