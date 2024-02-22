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
    pkgs.tmux
  ];
  home.file = {
    ".config/tmux/tmux.conf".text = ''
      # split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %
      # reload config file (change file location to your the tmux.conf you want to use)
      bind r source-file ~/.config/tmux/tmux.conf
      # switch panes using Alt-arrow without prefix
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Increase scrollback buffer size
      set-option -g history-limit 20000
    '';
  };
}
