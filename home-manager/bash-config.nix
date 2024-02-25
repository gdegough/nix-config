{
  config,
  pkgs,
  ...
}:
{
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
      #
      # read in OS info
      #
      ID=""
      if [ -r /etc/os-release ]; then
        source /etc/os-release
      fi

      #
      # Start ssh agent
      #
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
      gpgconf --launch gpg-agent
      GPG_TTY="$(tty)"
      export GPG_TTY
      gpg-connect-agent updatestartuptty /bye > /dev/null

      # Determine if session is over SSH (used in the prompts below)
      over_ssh() {
          if [ -n "''${SSH_CLIENT}" ]; then
              return 0
          else
              return 1
          fi
      }

      # set a fancy prompt (non-color, unless we know we "want" color)
      case $TERM in
          xterm-color|*-256color)
              use_color=true
              ;;
      esac

      # uncomment for a colored prompt, if the terminal has the capability; turned
      # off by default to not distract the user: the focus in a terminal window
      # should be on the output of commands, not on the prompt
      force_color_prompt=yes

      if [ -n "$force_color_prompt" ]; then
          if tput setaf 1 >&/dev/null; then
              # We have color support; assume it's compliant with Ecma-48
              # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
              # a case would tend to support setf rather than setaf.)
              use_color=true
          else
              use_color=false
          fi
      fi

      PROMPT_ALTERNATIVE=twoline
      NEWLINE_BEFORE_PROMPT='no'

      if $use_color; then
          # override default virtualenv indicator in prompt
          VIRTUAL_ENV_DISABLE_PROMPT=1

          reset="\[$(tput sgr0)\]"
          black="\[$(tput sgr0; tput setaf 0)\]"
          red="\[$(tput sgr0; tput setaf 1)\]"
          green="\[$(tput sgr0; tput setaf 2)\]"
          yellow="\[$(tput sgr0; tput setaf 3)\]"
          blue="\[$(tput sgr0; tput setaf 4)\]"
          magenta="\[$(tput sgr0; tput setaf 5)\]"
          cyan="\[$(tput sgr0; tput setaf 6)\]"
          white="\[$(tput sgr0; tput setaf 7)\]"
          prompt_color=$green
          info_color=$cyan
          prompt_symbol='@'
          if [ $EUID -eq 0 ]; then # Change prompt colors for root user
              prompt_color=$cyan
              info_color=$red
              # Skull emoji for root terminal
              #prompt_symbol=💀
          fi
          case $PROMPT_ALTERNATIVE in
              twoline)
                  PS1="$prompt_color┌──''${ID:+($ID)─}''${chroot_prompt:+($chroot_prompt)─}($info_color\u$prompt_symbol\h$prompt_color)─"
                  if over_ssh; then
                      PS1+="$prompt_color[''${red}SSH$prompt_color]"
                  fi
                  PS1+="$prompt_color[$white\w$prompt_color]\n$prompt_color└─$info_color\$''${reset} "
                  ;;
              oneline)
                  PS1="$prompt_color''${ID:+($ID) }''${chroot_prompt:+($chroot_prompt) }$info_color\u$prompt_symbol\h"
                  if over_ssh; then
                      PS1+="$prompt_color[''${red}SSH$prompt_color]"
                  fi
                  PS1+="$prompt_color:$white \w $info_color\$''${reset} "
                  ;;
              backtrack)
                  PS1="$prompt_color''${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)) }''${chroot_prompt:+($chroot_prompt)}$info_color\u$prompt_symbol\h"
                  if over_ssh; then
                      PS1+="$prompt_color[''${red}SSH$prompt_color]"
                  fi
                  PS1+="$prompt_color:$white\w$info_color\$''$reset "
                  ;;
          esac
          unset prompt_color info_color black red green yellow blue magenta cyan white reset prompt_symbol
      else
          PS1="''${ID:+($ID) }''${chroot_prompt:+($chroot_prompt) }\u@\h"
          if over_ssh; then
              PS1+="[SSH]"
          fi
          PS1+=": \w \$ "
      fi
      unset use_color force_color_prompt

      # If this is an xterm set the title to user@host:dir
      case "$TERM" in
          xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty)
              PS1="\[\e]0;''${ID:+($ID)}''${chroot_prompt:+($chroot_prompt)}\u@\h: \w\a\]$PS1"
              ;;
          *)
              ;;
      esac

      [ $NEWLINE_BEFORE_PROMPT = yes ] && PROMPT_COMMAND="PROMPT_COMMAND=echo"

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
      GPG_TTY="$(tty)"
      export GPG_TTY
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
