{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./starship.nix
  ];
  programs.starship = {
    enableNushellIntegration = true;
  };
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
  programs.nushell = {
    enable = true;
    # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
    # configFile.source = "\$HOME/.config/nushell/config.nu";
    # for editing directly to config.nu 
    extraConfig = ''
      let carapace_completer = {|spans|
        carapace $spans.0 nushell $spans | from json
      }
      $env.config = {
        show_banner: false,
        completions: {
          case_sensitive: false # case-sensitive completions
          quick: true    # set to false to prevent auto-selecting completions
          partial: true    # set to false to prevent partial filling of the prompt
          algorithm: "fuzzy"    # prefix or fuzzy
          external: {
            # set to false to prevent nushell looking into $env.PATH to find more suggestions
            enable: true 
            # set to lower can improve completion performance at the cost of omitting some options
            max_results: 100 
            completer: $carapace_completer # check 'carapace_completer' 
          }
        }
      } 
      $env.PATH = ( $env.PATH | split row (char esep) | append /usr/bin/env )
    '';
    shellAliases = {
      lsblk = "lsblk -o NAME,MAJ:MIN,RM,SIZE,RO,TYPE,FSTYPE,MOUNTPOINTS";
      colors = "(x=\$(tput op) y=\$(printf %76s);for i in {0..255};do o=00\$i;echo -e \${o:\${#o}-3:3} \$(tput setaf \$i;tput setab \$i)\${y// /=}\$x;done)";
      check-cpu-vulnerabilities = "grep . /sys/devices/system/cpu/vulnerabilities/*";
      dfd = "df -h --output=\"source,fstype,size,used,avail,pcent,target\" -x devtmpfs -x tmpfs";
      ls = "ls --color=auto";
      "l." = "ls -hdl --group-directories-first .*";
      l = "ls -a1 --group-directories-first";
      ll = "ls -halF --group-directories-first";
      less = "less --RAW-CONTROL-CHARS --chop-long-lines";
      lo = "gnome-session-quit --no-prompt";
      lscolor-normal = "ln -sf \${HOME}/.config/dircolors/normal.dircolors \${HOME}/.dircolors; eval \$(dircolors -b \${HOME}/.dircolors)";
      lscolor-normallight = "ln -sf \${HOME}/.config/dircolors/normal-lightbg.dircolors \${HOME}/.dircolors; eval \$(dircolors -b \${HOME}/.dircolors)";
      lscolor-256dark = "ln -sf \${HOME}/.config/dircolors/256dark.dircolors \${HOME}/.dircolors; eval \$(dircolors -b \${HOME}/.dircolors)";
      lscolor-dark = "ln -sf \${HOME}/.config/dircolors/ansi-dark.dircolors \${HOME}/.dircolors; eval \$(dircolors -b \${HOME}/.dircolors)";
      lscolor-light = "ln -sf \${HOME}/.config/dircolors/ansi-light.dircolors \${HOME}/.dircolors; eval \$(dircolors -b \${HOME}/.dircolors)";
      lscolor-universal = "ln -sf \${HOME}/.config/dircolors/ansi-universal.dircolors \${HOME}/.dircolors; eval \$(dircolors -b \${HOME}/.dircolors)";
      lscolor-manjaro = "ln -sf \${HOME}/.config/dircolors/manjaro.dircolors \${HOME}/.dircolors; eval \$(dircolors -b \${HOME}/.dircolors)";
      psa = "ps -eo user,group,ppid,pid,%cpu,%mem,vsz,rss,stat,start,time,comm,args";
      drop-caches = "echo 1 | sudo tee /proc/sys/vm/drop_caches";
      dmesg = "journalctl --dmesg -o short-monotonic --no-hostname --no-pager";
      create-input-file = "sed ':a;N;$!ba;s/\\n/ /g'";
      sudo = "sudo ";
      vim = "vim ";
    };
  };  
}
