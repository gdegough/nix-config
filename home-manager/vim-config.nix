{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
#with lib.hm.gvariant;
{
  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  home.packages = with pkgs; [
    powerline
  ];
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline vim-airline-themes vim-colors-solarized ];
    settings = {
      background = "dark";
      expandtab = true;
      shiftwidth = 4; 
      tabstop = 4;
    };
    extraConfig = ''
      colorscheme solarized
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
    '';
  };
  home.sessionVariables.EDITOR = "vim";
}
