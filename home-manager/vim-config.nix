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
    pkgs.powerline
  ];
  home.sessionVariables = {
    VISUAL = "vim";
    EDITOR = "vim";
    EXINIT = "se sm smd scr=1 ai ruler redraw sw=4 filec=\t";
    MERGE = "vimdiff";
    SYSTEMD_EDITOR = "vim";
  };
  home.file = {
    ".config/environment.d/50-vim.conf".text = ''
      VISUAL=vim
      EDITOR=vim
      EXINIT="se sm smd scr=1 ai ruler redraw sw=4 filec=\t"
      MERGE=vimdiff
      SYSTEMD_EDITOR=vim
    '';
  };
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ 
      gruvbox 
      vim-airline 
      vim-airline-themes 
      vim-colors-solarized 
    ];
    settings = {
      expandtab = true;
      shiftwidth = 4; 
      tabstop = 4;
    };
    extraConfig = ''
      filetype plugin indent on
      let g:tex_flavor = 'latex'
      set autoindent 
      set backspace=indent,eol,start
      set nosmarttab 
      set nowrap
      set smartindent
      set softtabstop=4 
      set formatoptions-=t
      syntax enable
      colorscheme gruvbox
    '';
  };
}
