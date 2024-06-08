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
    enableBashIntegration = true;
  };
  programs.carapace = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.bash = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    historySize = 2000;
    historyFileSize = 2000;
    historyControl = [ "ignoredups" "erasedups" ];
    shellOptions = [ "histappend" "checkwinsize" ];
    historyFile = "$HOME/.bash_history";
    initExtra = ''
      source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      '';
    bashrcExtra = ''
      # Start ssh agent
      #
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
      gpgconf --launch gpg-agent
      export GPG_TTY="$(tty)"
      gpg-connect-agent updatestartuptty /bye > /dev/null

      # If this is an xterm set the title to user@host:dir
      case "$TERM" in
          xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty)
              PS1="\[\e]0;\u@\h: \w\a\]''${PS1}"
              ;;
          *)
              ;;
      esac

      # enable color support of ls, less and man, and also add handy aliases
      if [ ! $(eval "$(dircolors -b)") ]; then
          test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
          export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions

          alias ls='ls --color=auto'
          #alias dir='dir --color=auto'
          #alias vdir='vdir --color=auto'

          alias grep='grep --color=auto'
          alias fgrep='grep -F --color=auto'
          alias egrep='grep -E --color=auto'
          alias diff='diff --color=auto'
          alias ip='ip --color=auto'

          export LESS_TERMCAP_mb="$(tput sgr0; tput blink)"           # begin blink
          export LESS_TERMCAP_md="$(tput sgr0; tput bold; tput setaf 6)"  # begin bold
          export LESS_TERMCAP_me="$(tput sgr0)"               # reset bold/blink
          export LESS_TERMCAP_so="$(tput sgr0; tput bold; tput setaf 3)"  # begin standout mode
          export LESS_TERMCAP_se="$(tput sgr0)"               # end standout mode
          export LESS_TERMCAP_us="$(tput smul)"               # begin underline
          export LESS_TERMCAP_ue="$(tput sgr0)"               # reset underline
      fi

      # prepend ~/bin or ~/.local/bin to $PATH unless it is already there
      if [ -d "$HOME/bin" ] && ! ( printf "$PATH\n" | grep -Eq "$HOME/bin" ); then
          PATH="$HOME/bin:$PATH"
      fi
      if [ -d "$HOME/.local/bin" ] && ! ( printf "$PATH\n" | grep -Eq "$HOME/.local/bin" ); then
          PATH="$HOME/.local/bin:$PATH"
      fi
      export PATH

      # set rust environment
      [ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env" || true

      # Firefox wayland:
      if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
          export MOZ_ENABLE_WAYLAND=1
      fi
      '';
    profileExtra = ''
      # if running bash
      if [ -n "$BASH_VERSION" ]; then
          # include .bashrc if it exists
          if [ -f $HOME/.bashrc ]; then
          . $HOME/.bashrc
          fi
      fi

      #
      # Start ssh agent
      #
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
      gpgconf --launch gpg-agent
      export GPG_TTY="$(tty)"
      gpg-connect-agent updatestartuptty /bye > /dev/null

      # set PATH so it includes user's private bin if it exists
      if [ -d $HOME/.local/bin ] ; then
          PATH="$HOME/.local/bin:$PATH"
      fi
      export PATH
      #
      # set rust environment
      # 
      [ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env" || true
      '';
    logoutExtra = ''
      # when leaving the console clear the screen to increase privacy
      if [ "$SHLVL" = 1 ]; then
          clear
      fi
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
      lscolor-256dark = "ln -sf \${HOME}/.config/dircolors/solarized/256dark.dircolors \${HOME}/.dircolors; eval \$(dircolors -b \${HOME}/.dircolors)";
      lscolor-dark = "ln -sf \${HOME}/.config/dircolors/solarized/ansi-dark.dircolors \${HOME}/.dircolors; eval \$(dircolors -b \${HOME}/.dircolors)";
      lscolor-light = "ln -sf \${HOME}/.config/dircolors/solarized/ansi-light.dircolors \${HOME}/.dircolors; eval \$(dircolors -b \${HOME}/.dircolors)";
      lscolor-universal = "ln -sf \${HOME}/.config/dircolors/solarized/ansi-universal.dircolors \${HOME}/.dircolors; eval \$(dircolors -b \${HOME}/.dircolors)";
      lscolor-manjaro = "ln -sf \${HOME}/.config/dircolors/manjaro.dircolors \${HOME}/.dircolors; eval \$(dircolors -b \${HOME}/.dircolors)";
      psa = "ps -eo user,group,ppid,pid,%cpu,%mem,vsz,rss,stat,start,time,comm,args";
      drop-caches = "echo 1 | sudo tee /proc/sys/vm/drop_caches";
      dmesg = "journalctl --dmesg -o short-monotonic --no-hostname --no-pager";
      create-input-file = "sed ':a;N;$!ba;s/\\n/ /g'";
      sudo = "sudo ";
      vim = "vim ";
      power-profile = "sudo system76-power charge-thresholds --profile balanced && sudo system76-power profile battery && sudo light -S 50";
    };
  };
}
