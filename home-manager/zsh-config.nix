{
  config,
  pkgs,
  ...
}:
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableVteIntegration = true;
    syntaxHighlighting.enable = true;
    initExtraFirst = ''
      # read in OS info
      ID=""
      if [ -r /etc/os-release ]; then
        source /etc/os-release
      fi
      setopt interactivecomments # allow comments in interactive mode
      setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
      setopt nonomatch           # hide error message if there is no match for the pattern
      setopt notify              # report the status of background jobs immediately
      setopt numericglobsort     # sort filenames numerically when it makes sense
      setopt promptsubst         # enable command substitution in prompt
      setopt hist_verify         # show command with history expansion to user before running it
      # configure key keybindings
      bindkey ' ' magic-space                           # do history expansion on space
      bindkey '^U' backward-kill-line                   # ctrl + U
      bindkey '^[[3;5~' kill-word                       # ctrl + Supr
      bindkey '^[[3~' delete-char                       # delete
      bindkey '^[[1;5C' forward-word                    # ctrl + ->
      bindkey '^[[1;5D' backward-word                   # ctrl + <-
      bindkey '^[[5~' beginning-of-buffer-or-history    # page up
      bindkey '^[[6~' end-of-buffer-or-history          # page down
      bindkey '^[[H' beginning-of-line                  # home
      bindkey '^[[F' end-of-line                        # end
      bindkey '^[[Z' undo                               # shift + tab undo last action
    '';
    initExtra = ''
      source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      # enable completion features
      zstyle ':completion:*:*:*:*:*' menu select
      zstyle ':completion:*' auto-description 'specify: %d'
      zstyle ':completion:*' completer _expand _complete
      zstyle ':completion:*' format 'Completing %d'
      zstyle ':completion:*' group-name '''
      zstyle ':completion:*' list-colors '''
      zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' rehash true
      zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
      zstyle ':completion:*' use-compctl false
      zstyle ':completion:*' verbose true
      zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
      # set variable identifying the chroot you work in (used in the prompt below)
      if [ -z "''${chroot_prompt:-}" ] && [ -r /etc/''${type}_chroot ]; then
          chroot_prompt=$(cat /etc/''${type}_chroot)
      fi
      # set a fancy prompt (non-color, unless we know we "want" color)
      case "$TERM" in
          xterm-color|*-256color) color_prompt=yes;;
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
              color_prompt=yes
          else
              color_prompt=
          fi
      fi
      # Determine if session is over SSH (used in the prompts below)
      over_ssh() {
          if [ -n "''${SSH_CLIENT}" ]; then
              return 0
          else
              return 1
          fi
      }
      # Fancy prompt.
      unset prompt_is_ssh
      if over_ssh ; then
          if [ "$color_prompt" = yes ] ; then
              if [ -z "''${TMUX}" ]; then
                  prompt_is_ssh='%F{green}[%F{red}SSH%F{green}]'
              else
                  prompt_is_ssh='%F{green}[%F{253}SSH%F{green}]'
              fi
          else
              prompt_is_ssh='[SSH]'
          fi
      fi
      configure_prompt() {
          prompt_symbol=@
          #prompt_symbol=㉿
          # Skull emoji for root terminal
          #[ "$EUID" -eq 0 ] && prompt_symbol=💀
          case "$PROMPT_ALTERNATIVE" in
              twoline)
                  PROMPT=$''\'%F{green}┌──''${ID:+(''${ID})─}''${VIRTUAL_ENV:+($(basename ''${VIRTUAL_ENV}))─}(%B%F{%(#.red.yellow)}%n''\'''${prompt_symbol}$''\'%m%b%F{green})-''${prompt_is_ssh}[%B%F{white}%(6~.%-1~/…/%4~.%5~)%b%F{green}]\n└─ %B%(#.#.$)%b%F{reset} ''\'
                  # Right-side prompt with exit codes and background processes
                  #RPROMPT=$''\'%(?.. %? %F{red}%B⨯%b%F{reset})%(1j. %j %F{yellow}%B⚙%b%F{reset}.)''\'
                  ;;
              oneline)
                  PROMPT=$''\'''${ID:+(''${ID}) }''${VIRTUAL_ENV:+($(basename ''${VIRTUAL_ENV}))}%B%F{%(#.red.yellow)}%n@%m%b''${prompt_is_ssh}%F{reset}:%B%F{white} %(6~.%-1~/…/%4~.%5~) %b%F{reset}%(#.#.$) ''\'
                  RPROMPT=
                  ;;
              backtrack)
                  PROMPT=$''\'''${ID:+(''${ID}) }''${VIRTUAL_ENV:+($(basename ''${VIRTUAL_ENV}))}%B%F{red}%n@%m%b''${prompt_is_ssh}%F{reset}:%B%F{white} %(6~.%-1~/…/%4~.%5~) %b%F{reset}%(#.#.$) ''\'
                  RPROMPT=
                  ;;
          esac
          unset prompt_symbol
      }
      if [ "$color_prompt" = yes ]; then
          # override default virtualenv indicator in prompt
          VIRTUAL_ENV_DISABLE_PROMPT=1
          configure_prompt
          typeset -gA ZSH_HIGHLIGHT_STYLES
          ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
          ZSH_HIGHLIGHT_STYLES[default]=none
          ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold
          # ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=white,underline
          ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
          ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
          ZSH_HIGHLIGHT_STYLES[global-alias]=fg=green,bold
          ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
          ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
          ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
          ZSH_HIGHLIGHT_STYLES[path]=bold
          ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
          ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
          ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
          ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
          ZSH_HIGHLIGHT_STYLES[command-substitution]=none
          ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta,bold
          ZSH_HIGHLIGHT_STYLES[process-substitution]=none
          ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta,bold
          ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=green
          ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=green
          ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
          ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
          ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
          ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
          ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
          ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
          ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta,bold
          ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta,bold
          ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta,bold
          ZSH_HIGHLIGHT_STYLES[assign]=none
          ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
          ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
          ZSH_HIGHLIGHT_STYLES[named-fd]=none
          ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
          ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan
          ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
          ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
          ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
          ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
          ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
          ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
          ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
          ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
      else
          PROMPT=''\'''${ID:+(''${ID}) }%n@%m''${prompt_is_ssh}:%~%(#.#.$) ''\'
      fi
      unset color_prompt force_color_prompt
      toggle_oneline_prompt(){
          if [ "$PROMPT_ALTERNATIVE" = "oneline" ]; then
              PROMPT_ALTERNATIVE=twoline
          else
              PROMPT_ALTERNATIVE=oneline
          fi
          configure_prompt
          zle reset-prompt
      }
      zle -N toggle_oneline_prompt
      bindkey '^P' toggle_oneline_prompt
      # If this is an xterm set the title to user@host:dir
      case "$TERM" in
          xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty)
              TERM_TITLE=$''\'\e]0;''${ID:+(''${ID})}''${VIRTUAL_ENV:+($(basename ''${VIRTUAL_ENV}))}%n@%m:%~\a''\'
              ;;
          *)
              ;;
      esac
      precmd() {
          # Print the previously configured title
          print -Pnr -- "$TERM_TITLE"
          # Print a new line before the prompt, but only if it is not the first line
          if [ "$NEWLINE_BEFORE_PROMPT" = "yes" ]; then
              if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
                  _NEW_LINE_BEFORE_PROMPT=1
              else
                  print ""
              fi
          fi
      }
      # enable color support of ls, less and man, and also add handy aliases
      if [ ! $(eval "$(dircolors -b)") ]; then
          test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
          export LS_COLORS="''${LS_COLORS}:ow=30;44:" # fix ls color for folders with 777 permissions
          alias ls='ls --color=auto'
          #alias dir='dir --color=auto'
          #alias vdir='vdir --color=auto'
          alias grep='grep --color=auto'
          alias fgrep='grep -F --color=auto'
          alias egrep='grep -E --color=auto'
          alias diff='diff --color=auto'
          alias ip='ip --color=auto'
          export LESS_TERMCAP_mb="$(tput sgr0; tput blink)"			# begin blink
          export LESS_TERMCAP_md="$(tput sgr0; tput bold; tput setaf 6)"	# begin bold
          export LESS_TERMCAP_me="$(tput sgr0)"				# reset bold/blink
          export LESS_TERMCAP_so="$(tput sgr0; tput bold; tput setaf 3)"	# begin standout mode
          export LESS_TERMCAP_se="$(tput sgr0)"				# end standout mode
          export LESS_TERMCAP_us="$(tput smul)"				# begin underline
          export LESS_TERMCAP_ue="$(tput sgr0)"				# reset underline
          # Take advantage of $LS_COLORS for completion as well
          zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
          zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
      fi
      # prepend ~/bin or ~/.local/bin to $PATH unless it is already there
      if [ -d $HOME/bin ] && ! ( printf "$PATH\n" | grep -Eq "$HOME/bin" ); then
          PATH="$HOME/bin:$PATH"
      fi
      if [ -d $HOME/.local/bin ] && ! ( printf "$PATH\n" | grep -Eq "$HOME/.local/bin" ); then
          PATH="$HOME/.local/bin:$PATH"
      fi
      export PATH
      export MAIL="$HOME/.maildir"
      export MAILPATH="$HOME/.maildir"
      # Firefox wayland:
      if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
          export MOZ_ENABLE_WAYLAND=1
      fi
    '';
    envExtra = ''
      # prepend ~/bin or ~/.local/bin to $PATH unless it is already there
      if [ -d "$HOME/bin" ] && ! ( printf "$PATH\n" | grep -Eq "$HOME/bin" ); then
          PATH="$HOME/bin:$PATH"
      fi
      if [ -d "$HOME/.local/bin" ] && ! ( printf "$PATH\n" | grep -Eq "$HOME/.local/bin" ); then
          PATH="$HOME/.local/bin:$PATH"
      fi
      export PATH
      #
      # Start ssh agent
      #
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
      gpgconf --launch gpg-agent
      GPG_TTY="$(tty)"
      export GPG_TTY
      gpg-connect-agent updatestartuptty /bye > /dev/null
      # set rust environment
      [ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env" || true
    '';
    logoutExtra = ''
      # when leaving the console clear the screen to increase privacy
      if [ "$SHLVL" = 1 ]; then
          clear
      fi
    '';
    sessionVariables = {
      PROMPT_ALTERNATIVE = "twoline";
      NEWLINE_BEFORE_PROMPT = "no";
    };
    localVariables = {
      WORDCHARS = "\${WORDCHARS//\/}"; # Don't consider certain characters part of the word
      PROMPT_EOL_MARK="";  # hide EOL sign ('%')
      TIMEFMT = "\$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'"; # configure `time` format
    };
    autocd = true;
    dotDir = ".config/zsh";
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
      history = "history 0";
    };
  };
}
