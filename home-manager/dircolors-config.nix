{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/dircolors/solarized/256dark.dircolors".text = ''
      # Dark 256 color solarized theme for the color GNU ls utility.
      # Used and tested with dircolors (GNU coreutils) 8.5
      #
      # @author  {@link http://sebastian.tramp.name Sebastian Tramp}
      # @license http://sam.zoy.org/wtfpl/  Do What The Fuck You Want To Public License (WTFPL)
      #
      # More Information at
      # https://github.com/seebi/dircolors-solarized

      # COLOR needs one of these arguments: 'tty' colorizes output to ttys, but not
      # pipes. 'all' adds color characters to all output. 'none' shuts colorization
      # off.
      COLOR tty

      # Below are TERM entries, which can be a glob patterns, to match
      # against the TERM environment variable to determine if it is colorizable.
      TERM Eterm
      TERM alacritty
      TERM foot
      TERM ansi
      TERM *color*
      TERM con[0-9]*x[0-9]*
      TERM cons25
      TERM console
      TERM cygwin
      TERM *direct*
      TERM dtterm
      TERM gnome
      TERM hurd
      TERM jfbterm
      TERM konsole
      TERM kterm
      TERM linux
      TERM linux-c
      TERM mlterm
      TERM putty
      TERM rxvt*
      TERM screen*
      TERM st
      TERM terminator
      TERM tmux*
      TERM vt100
      TERM xterm*

      ## Documentation
      #
      # standard colors
      #
      # Below are the color init strings for the basic file types. A color init
      # string consists of one or more of the following numeric codes:
      # Attribute codes:
      # 00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
      # Text color codes:
      # 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
      # Background color codes:
      # 40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white
      #
      #
      # 256 color support
      # see here: http://www.mail-archive.com/bug-coreutils@gnu.org/msg11030.html)
      #
      # Text 256 color coding:
      # 38;5;COLOR_NUMBER
      # Background 256 color coding:
      # 48;5;COLOR_NUMBER

      ## Special files

      NORMAL                          00;38;5;244          # no color code at all
      #FILE                           00                   # regular file: use no color at all
      RESET                           0                    # reset to "normal" color
      DIR                             00;38;5;33           # directory 01;34
      LINK                            00;38;5;37           # symbolic link. (If you set this to 'target' instead of a
                                                           # numerical value, the color is as for the file pointed to.)
      MULTIHARDLINK                   00                   # regular file with more than one link
      FIFO                            48;5;230;38;5;136;01 # pipe
      SOCK                            48;5;230;38;5;136;01 # socket
      DOOR                            48;5;230;38;5;136;01 # door
      BLK                             48;5;230;38;5;244;01 # block device driver
      CHR                             48;5;230;38;5;244;01 # character device driver
      ORPHAN                          48;5;235;38;5;160    # symlink to nonexistent file, or non-stat'able file
      SETUID                          48;5;160;38;5;230    # file that is setuid (u+s)
      SETGID                          48;5;136;38;5;230    # file that is setgid (g+s)
      CAPABILITY                      30;41                # file with capability
      STICKY_OTHER_WRITABLE           48;5;64;38;5;230     # dir that is sticky and other-writable (+t,o+w)
      OTHER_WRITABLE                  48;5;235;38;5;33     # dir that is other-writable (o+w) and not sticky
      STICKY                          48;5;33;38;5;230     # dir with the sticky bit set (+t) and not other-writable
      # This is for files with execute permission:
      EXEC                            00;38;5;64
      MISSING                         48;5;160;38;5;254;05
      MULTIHARDLINK                   00                   # regular file with more than one link
      RESET                           00                   # reset to "normal" color

      ## Archives or compressed (violet + bold for compression)
      .tar    			00;38;5;61
      .tgz    			00;38;5;61
      .arj    			00;38;5;61
      .taz    			00;38;5;61
      .lzh    			00;38;5;61
      .lzma   			00;38;5;61
      .tlz    			00;38;5;61
      .txz    			00;38;5;61
      .zip    			00;38;5;61
      .z      			00;38;5;61
      .Z      			00;38;5;61
      .dz    			 	00;38;5;61
      .gz     			00;38;5;61
      .lz     			00;38;5;61
      .xz     			00;38;5;61
      .bz2    			00;38;5;61
      .bz     			00;38;5;61
      .tbz    			00;38;5;61
      .tbz2   			00;38;5;61
      .tz     			00;38;5;61
      .deb    			00;38;5;61
      .rpm    			00;38;5;61
      .jar    			00;38;5;61
      .rar    			00;38;5;61
      .ace    			00;38;5;61
      .zoo    			00;38;5;61
      .cpio   			00;38;5;61
      .7z     			00;38;5;61
      .rz     			00;38;5;61
      .apk    			00;38;5;61
      .gem    			00;38;5;61
      .bin    			00;38;5;61
      .cab    			00;38;5;61
      .dmg    			00;38;5;61
      .iso   	 			00;38;5;61
      .msi    			00;38;5;61             # Win
      .tx     			00;38;5;61
      .war    			00;38;5;61
      .xpi    			00;38;5;61


      # files that may be executed:
      .app             		00;38;5;166
      .com             		00;38;5;166
      .exe             		00;38;5;166
      .reg             		00;38;5;166    # Win
      .cmd             		00;38;5;166
      .bat             		00;38;5;166
      .sh              		00;38;5;166
      .zsh             		00;38;5;166
      .bash                           00;38;5;166
      .csh                            00;38;5;166
      .erb                            00;38;5;166

      #
      .h               		00;38;5;64
      .haml                           00;38;5;64
      .hs                             00;38;5;64
      .htm                            00;38;5;64
      .html                           00;38;5;64
      .java                           00;38;5;64
      .js                             00;38;5;64
      .l                              00;38;5;64
      .less                           00;38;5;64
      .man                            00;38;5;64
      .mkd                            00;38;5;64
      .n                              00;38;5;64
      .objc                           00;38;5;64
      .org                            00;38;5;64
      .p                              00;38;5;64
      .php                            00;38;5;64
      .pl                             00;38;5;64
      .pm                             00;38;5;64
      .pod                            00;38;5;64
      .py                             00;38;5;64
      .rb                             00;38;5;64
      .sass                           00;38;5;64
      .scss                           00;38;5;64
      .shtml                          00;38;5;64
      .txt                            00;38;5;64
      .vim                            00;38;5;64
      .xml                            00;38;5;64
      *Makefile                       00;38;5;64
      *Rakefile                       00;38;5;64
      *Dockerfile                     00;38;5;64
      *build.xml                      00;38;5;64
      .c                              00;38;5;64
      .cpp                            00;38;5;64
      .cc                             00;38;5;64
      .go                             00;38;5;64
      .sql                            00;38;5;64
      .0                              00;38;5;64
      .1                              00;38;5;64
      .2                              00;38;5;64
      .3                              00;38;5;64
      .4                              00;38;5;64
      .5                              00;38;5;64
      .6                              00;38;5;64
      .7                              00;38;5;64
      .8                              00;38;5;64
      .9                              00;38;5;64
      .cl                             00;38;5;64
      .coffee                         00;38;5;64
      .css                            00;38;5;64
      .cxx                            00;38;5;64
      .el                             00;38;5;64
      .srt                            00;38;5;64

      # Image formats (yellow)
      .jpg                            00;38;5;136
      .JPG                            00;38;5;136 #stupid but needed
      .jpeg                           00;38;5;136
      .gif                            00;38;5;136
      .bmp                            00;38;5;136
      .pbm                            00;38;5;136
      .pgm                            00;38;5;136
      .ppm                            00;38;5;136
      .tga                            00;38;5;136
      .xbm                            00;38;5;136
      .xpm                            00;38;5;136
      .tif                            00;38;5;136
      .tiff                           00;38;5;136
      .png                            00;38;5;136
      .PNG                            00;38;5;136
      .svg                            00;38;5;136
      .svgz                           00;38;5;136
      .mng                            00;38;5;136
      .pcx                            00;38;5;136
      .dl                             00;38;5;136
      .xcf                            00;38;5;136
      .xwd                            00;38;5;136
      .yuv                            00;38;5;136
      .cgm                            00;38;5;136
      .emf                            00;38;5;136
      .eps                            00;38;5;136
      .CR2                            00;38;5;136
      .ico                            00;38;5;136
      .dvi                            00;38;5;136
      .mpa                            00;38;5;136
      .pps                            00;38;5;136
      .ppsx                           00;38;5;136
      .ps                             00;38;5;136
      .swf                            00;38;5;136
      .pdf                            00;38;5;136

      # Files of special interest (base1)
      .tex                            00;38;5;245
      .rdf                            00;38;5;245
      .owl                            00;38;5;245
      .n3                             00;38;5;245
      .ttl                            00;38;5;245
      .nt                             00;38;5;245
      .torrent                        00;38;5;245
      *rc                             00;38;5;245
      *1                              00;38;5;245
      .nfo                            00;38;5;245
      *README                         00;38;5;245
      *README.txt                     00;38;5;245
      *readme.txt                     00;38;5;245
      .md                             00;38;5;245
      *README.markdown                00;38;5;245
      .ini                            00;38;5;245
      .yml                            00;38;5;245
      .yaml                           00;38;5;245
      .cfg                            00;38;5;245
      .conf                           00;38;5;245
      .doc                            00;38;5;245
      .docx                           00;38;5;245
      .dot                            00;38;5;245
      .dotx                           00;38;5;245
      .fla                            00;38;5;245
      .odp                            00;38;5;245
      .ods                            00;38;5;245
      .odt                            00;38;5;245
      .otp                            00;38;5;245
      .ots                            00;38;5;245
      .ott                            00;38;5;245
      .ppt                            00;38;5;245
      .pptx                           00;38;5;245
      .psd                            00;38;5;245
      .rtf                            00;38;5;245
      .xls                            00;38;5;245
      .xlsx                           00;38;5;245
      .dircolors                      00;38;5;245

      # "unimportant" files as logs and backups (base01)
      .log                            00;38;5;240
      .bak                            00;38;5;240
      .aux                            00;38;5;240
      .lof                            00;38;5;240
      .lol                            00;38;5;240
      .lot                            00;38;5;240
      .out                            00;38;5;240
      .toc                            00;38;5;240
      .bbl                            00;38;5;240
      .blg                            00;38;5;240
      *~                              00;38;5;240
      *#                              00;38;5;240
      .part                           00;38;5;240
      .incomplete                     00;38;5;240
      .swp                            00;38;5;240
      .tmp                            00;38;5;240
      .temp                           00;38;5;240
      .o                              00;38;5;240
      .pyc                            00;38;5;240
      .class                          00;38;5;240
      .cache                          00;38;5;240
      .BAK                            00;38;5;240
      .dist                           00;38;5;240
      .DIST                           00;38;5;240
      .off                            00;38;5;240
      .OFF                            00;38;5;240
      .old                            00;38;5;240
      .OLD                            00;38;5;240
      .org_archive                    00;38;5;240
      .orig                           00;38;5;240
      .ORIG                           00;38;5;240
      .swo                            00;38;5;240
      *,v                             00;38;5;240
      .idx2                           00;38;5;240

      # Audio formats (orange)
      .aac                            00;38;5;166
      .au                             00;38;5;166
      .mid                            00;38;5;166
      .midi                           00;38;5;166
      .mka                            00;38;5;166
      .mp3                            00;38;5;166
      .mpc                            00;38;5;166
      .ra                             00;38;5;166
      .wav                            00;38;5;166
      .m4a                            00;38;5;166
      # http://wiki.xiph.org/index.php/MIME_Types_and_File_Extensions
      .ogg                            00;38;5;166
      .opus                           00;38;5;166
      .axa                            00;38;5;166
      .oga                            00;38;5;166
      .flac                           00;38;5;166
      .spx                            00;38;5;166
      .xspf                           00;38;5;166

      # Video formats (as audio + bold)
      .mov                            00;38;5;166
      .MOV                            00;38;5;166
      .mpg                            00;38;5;166
      .mpeg                           00;38;5;166
      .m2v                            00;38;5;166
      .mkv                            00;38;5;166
      .ogm                            00;38;5;166
      .mp4                            00;38;5;166
      .m4v                            00;38;5;166
      .mp4v                           00;38;5;166
      .vob                            00;38;5;166
      .qt                             00;38;5;166
      .nuv                            00;38;5;166
      .wmv                            00;38;5;166
      .asf                            00;38;5;166
      .rm                             00;38;5;166
      .rmvb                           00;38;5;166
      .flc                            00;38;5;166
      .avi                            00;38;5;166
      .fli                            00;38;5;166
      .flv                            00;38;5;166
      .gl                             00;38;5;166
      .m2ts                           00;38;5;166
      .divx                           00;38;5;166
      .webm                           00;38;5;166
      .anx                            00;38;5;166
      # http://wiki.xiph.org/index.php/MIME_Types_and_File_Extensions
      .axv                            00;38;5;166
      .ogv                            00;38;5;166
      .ogx                            00;38;5;166
      .ts                             00;38;5;166

      # The brightmagenta (Solarized: purple) color is free for you to use for your
      # custom file type
      .gpg                            00;38;5;33
      .pgp                            00;38;5;33
      .asc                            00;38;5;33
      .3des                           00;38;5;33
      .aes                            00;38;5;33
      .enc                            00;38;5;33
      .sqlite                         00;38;5;33
    '';
    ".config/dircolors/solarized/ansi-dark.dircolors".text = ''
      # Exact Solarized Dark color theme for the color GNU ls utility.
      # Designed for dircolors (GNU coreutils) 5.97
      #
      # This simple theme was simultaneously designed for these terminal color schemes:
      # - Solarized dark  (best)
      # - Solarized light
      # - default dark
      # - default light
      # with a slight optimization for Solarized Dark.
      #
      # How the colors were selected:
      # - Terminal emulators often have an option typically enabled by default that makes
      #   bold a different color.  It is important to leave this option enabled so that
      #   you can access the entire 16-color Solarized palette, and not just 8 colors.
      # - We favor universality over a greater number of colors.  So we limit the number
      #   of colors so that this theme will work out of the box in all terminals,
      #   Solarized or not, dark or light.
      # - We choose to have the following category of files:
      #   NORMAL & FILE, DIR, LINK, EXEC and
      #   editable text including source, unimportant text, binary docs & multimedia source
      #   files, viewable multimedia, archived/compressed, and unimportant non-text
      # - For uniqueness, we stay away from the Solarized foreground colors are -- either
      #   base00 (brightyellow) or base0 (brightblue).  However, they can be used if
      #   you know what the bg/fg colors of your terminal are, in order to optimize the display.
      # - 3 different options are provided: universal, solarized dark, and solarized light.
      #   The only difference between the universal scheme and one that's optimized for
      #   dark/light is the color of "unimportant" files, which should blend more with the
      #   background
      # - We note that blue is the hardest color to see on dark bg and yellow is the hardest
      #   color to see on light bg (with blue being particularly bad).  So we choose yellow
      #   for multimedia files which are usually accessed in a GUI folder browser anyway.
      #   And blue is kept for custom use of this scheme's user.
      # - See table below to see the assignments.


      # Installation instructions:
      # This file goes in the /etc directory, and must be world readable.
      # You can copy this file to .dircolors in your $HOME directory to override
      # the system defaults.

      # COLOR needs one of these arguments: 'tty' colorizes output to ttys, but not
      # pipes. 'all' adds color characters to all output. 'none' shuts colorization
      # off.
      COLOR tty

      # Below are TERM entries, which can be a glob patterns, to match
      # against the TERM environment variable to determine if it is colorizable.
      TERM Eterm
      TERM alacritty
      TERM foot
      TERM ansi
      TERM *color*
      TERM con[0-9]*x[0-9]*
      TERM cons25
      TERM console
      TERM cygwin
      TERM *direct*
      TERM dtterm
      TERM gnome
      TERM hurd
      TERM jfbterm
      TERM konsole
      TERM kterm
      TERM linux
      TERM linux-c
      TERM mlterm
      TERM putty
      TERM rxvt*
      TERM screen*
      TERM st
      TERM terminator
      TERM tmux*
      TERM vt100
      TERM xterm*

      # EIGHTBIT, followed by '1' for on, '0' for off. (8-bit output)
      EIGHTBIT		1

      #############################################################################
      # Below are the color init strings for the basic file types. A color init
      # string consists of one or more of the following numeric codes:
      #
      # Attribute codes:
      #   00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
      # Text color codes:
      #   30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
      # Background color codes:
      #   40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white
      #
      # NOTES:
      # - See http://www.oreilly.com/catalog/wdnut/excerpt/color_names.html
      # - Color combinations
      #   ANSI Color code       Solarized  Notes                Universal             SolDark              SolLight
      #   ~~~~~~~~~~~~~~~       ~~~~~~~~~  ~~~~~                ~~~~~~~~~             ~~~~~~~              ~~~~~~~~
      #   00    none                                            NORMAL, FILE          <SAME>               <SAME>
      #   30    black           base02
      #   01;30 bright black    base03     bg of SolDark
      #   31    red             red                             docs & mm src         <SAME>               <SAME>
      #   01;31 bright red      orange                          EXEC                  <SAME>               <SAME>
      #   32    green           green                           editable text         <SAME>               <SAME>
      #   01;32 bright green    base01                          unimportant text      <SAME>
      #   33    yellow          yellow     unclear in light bg  multimedia            <SAME>               <SAME>
      #   01;33 bright yellow   base00     fg of SolLight                             unimportant non-text
      #   34    blue            blue       unclear in dark bg   user customized       <SAME>               <SAME>
      #   01;34 bright blue     base0      fg in SolDark                                                   unimportant text
      #   35    magenta         magenta                         LINK                  <SAME>               <SAME>
      #   01;35 bright magenta  violet                          archive/compressed    <SAME>               <SAME>
      #   36    cyan            cyan                            DIR                   <SAME>               <SAME>
      #   01;36 bright cyan     base1                           unimportant non-text                       <SAME>
      #   37    white           base2
      #   01;37 bright white    base3      bg in SolLight
      #   05;37;41                         unclear in Putty dark


      ### By file type

      # global default
      NORMAL			00
      # normal file
      FILE 			00
      # directory
      DIR 			34
      # 777 directory
      OTHER_WRITABLE 		34;40
      # symbolic link
      LINK 			35

      # pipe, socket, block device, character device (blue bg)
      FIFO 			30;44
      SOCK 			35;44
      DOOR 			35;44 # Solaris 2.5 and later
      BLK  			31;44
      CHR  			37;44

      CAPABILITY              30;41      # file with capability
      SETGID                  01;33   # file that is setgid (g+s)
      SETUID                  01;31   # file that is setuid (u+s)
      STICKY                  01;34   # dir with the sticky bit set (+t) and not other-writable
      STICKY_OTHER_WRITABLE   01;32   # dir that is sticky and other-writable (+t,o+w)

      #############################################################################
      ### By file attributes

      # Orphaned symlinks (blinking white on red)
      # Blink may or may not work (works on iTerm dark or light, and Putty dark)
      ORPHAN  		05;37;41
      # ... and the files that orphaned symlinks point to (blinking white on red)
      MISSING 		05;37;41

      # files with execute permission
      EXEC			31  # Unix
      .cmd			31  # Win
      .exe 			31  # Win
      .com 			31  # Win
      .bat 			31  # Win
      .reg 			31  # Win
      .app 			31  # OSX


      #############################################################################
      ### By extension

      # List any file extensions like '.gz' or '.tar' that you would like ls
      # to colorize below. Put the extension, a space, and the color init string.
      # (and any comments you want to add after a '#')

      ### Text formats

      # Text that we can edit with a regular editor
      .txt 			32
      .org 			32
      .md 			32
      .mkd 			32
      *1           		32
      .cfg         		32
      .conf        		32
      .dircolors              32
      .srt                    32

      # Source text
      .h 			32
      .c 			32
      .C 			32
      .cc 			32
      .cpp 			32
      .cxx 			32
      .objc 			32
      .cl 			32
      .sh 			32
      .bash 			32
      .csh 			32
      .zsh 			32
      .el 			32
      .vim 			32
      .java 			32
      .pl 			32
      .pm 			32
      .py 			32
      .rb 			32
      .hs 			32
      .php 			32
      .htm 			32
      .html 			32
      .shtml 			32
      .erb 			32
      .haml 			32
      .xml 			32
      *build.xml   		32
      .rdf 			32
      .css 			32
      .sass 			32
      .scss 			32
      .less 			32
      .js 			32
      .coffee 		32
      .man 			32
      .0 			32
      .1 			32
      .2 			32
      .3 			32
      .4 			32
      .5 			32
      .6 			32
      .7 			32
      .8 			32
      .9 			32
      .l 			32
      .n 			32
      .p 			32
      .pod 			32
      .tex 			32
      .go 			32
      .sql 			32
      .ini         		32
      *Makefile    		32
      .n3          		32
      .nfo         		32
      .nt          		32
      .owl         		32
      *Rakefile    		32
      *rc          		32
      *README      		32
      *README.markdown 	32
      *readme.txt  		32
      *README.txt  		32
      .torrent     		32
      .ttl         		32
      .yml         		32
      .yaml        		32

      ### Multimedia formats

      # Image
      .bmp 			33
      .cgm 			33
      .dl 			33
      .dvi 			33
      .emf 			33
      .eps 			33
      .gif 			33
      .jpeg 			33
      .jpg 			33
      .JPG 			33
      .mng 			33
      .pbm 			33
      .pcx 			33
      .pdf 			33
      .pgm 			33
      .png 			33
      .PNG 			33
      .ppm 			33
      .pps 			33
      .ppsx 			33
      .ps 			33
      .svg 			33
      .svgz 			33
      .tga 			33
      .tif 			33
      .tiff 			33
      .xbm 			33
      .xcf 			33
      .xpm 			33
      .xwd 			33
      .yuv 			33
      .axa         		33 
      .CR2         		33
      .divx        		33
      .ico         		33

      # Audio
      .aac 			33
      .au  			33
      .flac 			33
      .m4a 			33
      .mid 			33
      .midi 			33
      .mka 			33
      .mp3 			33
      .mpa 			33
      .ogg  			33
      .ra 			33
      .wav 			33

      # Video
      .anx 			33
      .asf 			33
      .avi 			33
      .axv 			33
      .flc 			33
      .fli 			33
      .flv 			33
      .gl 			33
      .m2v 			33
      .m4v 			33
      .mkv 			33
      .mov 			33
      .MOV 			33
      .mp4 			33
      .mp4v 			33
      .mpeg 			33
      .mpg 			33
      .nuv 			33
      .ogm 			33
      .ogv 			33
      .ogx 			33
      .qt 			33
      .rm 			33
      .rmvb 			33
      .swf 			33
      .vob 			33
      .webm 			33
      .wmv 			33
      .m2ts 			33
      .mpc 			33
      .oga 			33
      .spx 			33
      .xspf 			33
      .ts 			33

      ### Misc

      # Binary document formats and multimedia source
      .doc 			31
      .docx 			31
      .rtf 			31
      .odt 			31
      .dot 			31
      .dotx 			31
      .ott 			31
      .xls 			31
      .xlsx 			31
      .ods 			31
      .ots 			31
      .ppt 			31
      .pptx 			31
      .odp 			31
      .otp 			31
      .fla 			31
      .psd 			31
      *Dockerfile  		31

      # Archives, compressed
      .7z   			35
      .apk  			35
      .arj  			35
      .bin  			35
      .bz   			35
      .bz2  			35
      .cab  			35  # Win
      .deb  			35
      .dmg  			35  # OSX
      .gem  			35
      .gz   			35
      .iso  			35
      .jar  			35
      .msi  			35  # Win
      .rar  			35
      .rpm  			35
      .tar  			35
      .tbz  			35
      .tbz2 			35
      .tgz  			35
      .tx   			35
      .war  			35
      .xpi  			35
      .xz   			35
      .z    			35
      .Z    			35
      .zip  			35
      .ace         		35
      .cpio        		35
      .dz          		35
      .lz          		35
      .lzh         		35
      .lzma        		35
      .rz          		35
      .taz         		35
      .tlz         		35
      .txz         		35
      .tz          		35
      .zoo         		35


      # For testing
      .ANSI-30-black 		30
      .ANSI-01;30-brblack 	01;30
      .ANSI-31-red 		31
      .ANSI-01;31-brred 	01;31
      .ANSI-32-green 		32
      .ANSI-01;32-brgreen 	01;32
      .ANSI-33-yellow 	33
      .ANSI-01;33-bryellow 	01;33
      .ANSI-34-blue 		34
      .ANSI-01;34-brblue 	01;34
      .ANSI-35-magenta 	35
      .ANSI-01;35-brmagenta 	01;35
      .ANSI-36-cyan 		36
      .ANSI-01;36-brcyan 	01;36
      .ANSI-37-white 		37
      .ANSI-01;37-brwhite 	01;37

      #############################################################################
      # Your customizations

      # Unimportant text files
      # For universal scheme, use brightgreen 01;32
      # For optimal on light bg (but too prominent on dark bg), use white 01;34
      .log 			32
      *~ 			32
      *# 			32
      .bbl         		32
      .blg         		32
      .cache       		32
      .class       		32
      .incomplete  		32
      .lof         		32
      .lol         		32
      .lot         		32
      .o           		32
      .out         		32
      .part        		32
      .pyc         		32
      .temp        		32
      .tmp         		32
      .toc         		32
      #.log 			34
      #*~ 			34
      #*# 			34
      #.bbl         		34
      #.blg         		34
      #.cache       		34
      #.class       		34
      #.incomplete  		34
      #.lof         		34
      #.lol         		34
      #.lot         		34
      #.o           		34
      #.out         		34
      #.part        		34
      #.pyc         		34
      #.temp        		34
      #.tmp         		34
      #.toc         		34


      # Unimportant non-text files
      # For universal scheme, use brightcyan 36
      # For optimal on dark bg (but too prominent on light bg), change to 33
      #.bak 			36
      #.BAK 			36
      #.old 			36
      #.OLD 			36
      #.org_archive 		36
      #.off 			36
      #.OFF 			36
      #.dist 			36
      #.DIST 			36
      #.orig 			36
      #.ORIG 			36
      #.swp 			36
      #.swo 			36
      #*,v 			36
      #.aux         		36
      .bak 			33
      .BAK 			33
      .old 			33
      .OLD 			33
      .org_archive 		33
      .off 			33
      .OFF 			33
      .dist 			33
      .DIST 			33
      .orig 			33
      .ORIG 			33
      .swp 			33
      .swo 			33
      *,v 			33
      .aux         		33
      .idx2 			33

      # The brightmagenta (Solarized: purple) color is free for you to use for your
      # custom file type
      .gpg 			34
      .pgp 			34
      .asc 			34
      .3des 			34
      .aes 			34
      .enc 			34
      .sqlite 		34
    '';
    ".config/dircolors/solarized/ansi-light.dircolors".text = ''
      # Exact Solarized Light color theme for the color GNU ls utility.
      # Designed for dircolors (GNU coreutils) 5.97
      #
      # This simple theme was simultaneously designed for these terminal color schemes:
      # - Solarized dark
      # - Solarized light (best)
      # - default dark
      # - default light
      # with a slight optimization for Solarized Light.
      #
      # How the colors were selected:
      # - Terminal emulators often have an option typically enabled by default that makes
      #   bold a different color.  It is important to leave this option enabled so that
      #   you can access the entire 16-color Solarized palette, and not just 8 colors.
      # - We favor universality over a greater number of colors.  So we limit the number
      #   of colors so that this theme will work out of the box in all terminals,
      #   Solarized or not, dark or light.
      # - We choose to have the following category of files:
      #   NORMAL & FILE, DIR, LINK, EXEC and
      #   editable text including source, unimportant text, binary docs & multimedia source
      #   files, viewable multimedia, archived/compressed, and unimportant non-text
      # - For uniqueness, we stay away from the Solarized foreground colors are -- either
      #   base00 (brightyellow) or base0 (brightblue).  However, they can be used if
      #   you know what the bg/fg colors of your terminal are, in order to optimize the display.
      # - 3 different options are provided: universal, solarized dark, and solarized light.
      #   The only difference between the universal scheme and one that's optimized for
      #   dark/light is the color of "unimportant" files, which should blend more with the
      #   background
      # - We note that blue is the hardest color to see on dark bg and yellow is the hardest
      #   color to see on light bg (with blue being particularly bad).  So we choose yellow
      #   for multimedia files which are usually accessed in a GUI folder browser anyway.
      #   And blue is kept for custom use of this scheme's user.
      # - See table below to see the assignments.


      # Installation instructions:
      # This file goes in the /etc directory, and must be world readable.
      # You can copy this file to .dircolors in your $HOME directory to override
      # the system defaults.

      # COLOR needs one of these arguments: 'tty' colorizes output to ttys, but not
      # pipes. 'all' adds color characters to all output. 'none' shuts colorization
      # off.
      COLOR tty

      # Below are TERM entries, which can be a glob patterns, to match
      # against the TERM environment variable to determine if it is colorizable.
      TERM Eterm
      TERM alacritty
      TERM foot
      TERM ansi
      TERM *color*
      TERM con[0-9]*x[0-9]*
      TERM cons25
      TERM console
      TERM cygwin
      TERM *direct*
      TERM dtterm
      TERM gnome
      TERM hurd
      TERM jfbterm
      TERM konsole
      TERM kterm
      TERM linux
      TERM linux-c
      TERM mlterm
      TERM putty
      TERM rxvt*
      TERM screen*
      TERM st
      TERM terminator
      TERM tmux*
      TERM vt100
      TERM xterm*

      # EIGHTBIT, followed by '1' for on, '0' for off. (8-bit output)
      EIGHTBIT 1

      #############################################################################
      # Below are the color init strings for the basic file types. A color init
      # string consists of one or more of the following numeric codes:
      #
      # Attribute codes:
      #   00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
      # Text color codes:
      #   30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
      # Background color codes:
      #   40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white
      #
      # NOTES:
      # - See http://www.oreilly.com/catalog/wdnut/excerpt/color_names.html
      # - Color combinations
      #   ANSI Color code       Solarized  Notes                Universal             SolDark              SolLight
      #   ~~~~~~~~~~~~~~~       ~~~~~~~~~  ~~~~~                ~~~~~~~~~             ~~~~~~~              ~~~~~~~~
      #   00    none                                            NORMAL, FILE          <SAME>               <SAME>
      #   30    black           base02
      #   01;30 bright black    base03     bg of SolDark
      #   31    red             red                             docs & mm src         <SAME>               <SAME>
      #   01;31 bright red      orange                          EXEC                  <SAME>               <SAME>
      #   32    green           green                           editable text         <SAME>               <SAME>
      #   01;32 bright green    base01                          unimportant text      <SAME>
      #   33    yellow          yellow     unclear in light bg  multimedia            <SAME>               <SAME>
      #   01;33 bright yellow   base00     fg of SolLight                             unimportant non-text
      #   34    blue            blue       unclear in dark bg   user customized       <SAME>               <SAME>
      #   01;34 bright blue     base0      fg in SolDark                                                   unimportant text
      #   35    magenta         magenta                         LINK                  <SAME>               <SAME>
      #   01;35 bright magenta  violet                          archive/compressed    <SAME>               <SAME>
      #   36    cyan            cyan                            DIR                   <SAME>               <SAME>
      #   01;36 bright cyan     base1                           unimportant non-text                       <SAME>
      #   37    white           base2
      #   01;37 bright white    base3      bg in SolLight
      #   05;37;41                         unclear in Putty dark


      ### By file type

      # global default
      NORMAL 00
      # normal file
      FILE 00
      # directory
      DIR 36
      # symbolic link
      LINK 35

      # pipe, socket, block device, character device (blue bg)
      FIFO 30;44
      SOCK 35;44
      DOOR 35;44 # Solaris 2.5 and later
      BLK  33;44
      CHR  37;44


      #############################################################################
      ### By file attributes

      # Orphaned symlinks (blinking white on red)
      # Blink may or may not work (works on iTerm dark or light, and Putty dark)
      ORPHAN  05;37;41
      # ... and the files that orphaned symlinks point to (blinking white on red)
      MISSING 05;37;41

      # files with execute permission
      EXEC 31  # Unix
      .cmd 31  # Win
      .exe 31  # Win
      .com 31  # Win
      .bat 31  # Win
      .reg 31  # Win
      .app 31  # OSX

      #############################################################################
      ### By extension

      # List any file extensions like '.gz' or '.tar' that you would like ls
      # to colorize below. Put the extension, a space, and the color init string.
      # (and any comments you want to add after a '#')

      ### Text formats

      # Text that we can edit with a regular editor
      .txt 32
      .org 32
      .md 32
      .mkd 32
      .srt 32

      # Source text
      .h 32
      .c 32
      .C 32
      .cc 32
      .cpp 32
      .cxx 32
      .objc 32
      .cl 32
      .sh 32
      .bash 32
      .csh 32
      .zsh 32
      .el 32
      .vim 32
      .java 32
      .pl 32
      .pm 32
      .py 32
      .rb 32
      .hs 32
      .php 32
      .htm 32
      .html 32
      .shtml 32
      .erb 32
      .haml 32
      .xml 32
      .rdf 32
      .css 32
      .sass 32
      .scss 32
      .less 32
      .js 32
      .coffee 32
      .man 32
      .0 32
      .1 32
      .2 32
      .3 32
      .4 32
      .5 32
      .6 32
      .7 32
      .8 32
      .9 32
      .l 32
      .n 32
      .p 32
      .pod 32
      .tex 32
      .go 32
      .sql 32

      ### Multimedia formats

      # Image
      .bmp 33
      .cgm 33
      .dl 33
      .dvi 33
      .emf 33
      .eps 33
      .gif 33
      .jpeg 33
      .jpg 33
      .JPG 33
      .mng 33
      .pbm 33
      .pcx 33
      .pdf 33
      .pgm 33
      .png 33
      .PNG 33
      .ppm 33
      .pps 33
      .ppsx 33
      .ps 33
      .svg 33
      .svgz 33
      .tga 33
      .tif 33
      .tiff 33
      .xbm 33
      .xcf 33
      .xpm 33
      .xwd 33
      .xwd 33
      .yuv 33

      # Audio
      .aac 33
      .au  33
      .flac 33
      .m4a 33
      .mid 33
      .midi 33
      .mka 33
      .mp3 33
      .mpa 33
      .mpeg 33
      .mpg 33
      .ogg  33
      .ra 33
      .wav 33

      # Video
      .anx 33
      .asf 33
      .avi 33
      .axv 33
      .flc 33
      .fli 33
      .flv 33
      .gl 33
      .m2v 33
      .m4v 33
      .mkv 33
      .mov 33
      .MOV 33
      .mp4 33
      .mp4v 33
      .mpeg 33
      .mpg 33
      .nuv 33
      .ogm 33
      .ogv 33
      .ogx 33
      .qt 33
      .rm 33
      .rmvb 33
      .swf 33
      .vob 33
      .webm 33
      .wmv 33

      ### Misc

      # Binary document formats and multimedia source
      .doc 31
      .docx 31
      .rtf 31
      .odt 31
      .dot 31
      .dotx 31
      .ott 31
      .xls 31
      .xlsx 31
      .ods 31
      .ots 31
      .ppt 31
      .pptx 31
      .odp 31
      .otp 31
      .fla 31
      .psd 31

      # Archives, compressed
      .7z   35
      .apk  35
      .arj  35
      .bin  35
      .bz   35
      .bz2  35
      .cab  35  # Win
      .deb  35
      .dmg  35  # OSX
      .gem  35
      .gz   35
      .iso  35
      .jar  35
      .msi  35  # Win
      .rar  35
      .rpm  35
      .tar  35
      .tbz  35
      .tbz2 35
      .tgz  35
      .tx   35
      .war  35
      .xpi  35
      .xz   35
      .z    35
      .Z    35
      .zip  35

      # For testing
      .ANSI-30-black 30
      .ANSI-01;30-brblack 01;30
      .ANSI-31-red 31
      .ANSI-01;31-brred 01;31
      .ANSI-32-green 32
      .ANSI-01;32-brgreen 01;32
      .ANSI-33-yellow 33
      .ANSI-01;33-bryellow 01;33
      .ANSI-34-blue 34
      .ANSI-01;34-brblue 01;34
      .ANSI-35-magenta 35
      .ANSI-01;35-brmagenta 01;35
      .ANSI-36-cyan 36
      .ANSI-01;36-brcyan 01;36
      .ANSI-37-white 37
      .ANSI-01;37-brwhite 01;37

      #############################################################################
      # Your customizations

      # Unimportant text files
      # For universal scheme, use brightgreen 01;32
      # For optimal on light bg (but too prominent on dark bg), use white 01;34
      #.log 01;32
      #*~ 01;32
      #*# 01;32
      .log 34
      *~ 34
      *# 34

      # Unimportant non-text files
      # For universal scheme, use brightcyan 01;36
      # For optimal on dark bg (but too prominent on light bg), change to 01;33
      .bak 36
      .BAK 36
      .old 36
      .OLD 36
      .org_archive 36
      .off 36
      .OFF 36
      .dist 36
      .DIST 36
      .orig 36
      .ORIG 36
      .swp 36
      .swo 36
      *,v 36
      .idx2 36
      #.bak 33
      #.BAK 33
      #.old 33
      #.OLD 33
      #.org_archive 33
      #.off 33
      #.OFF 33
      #.dist 33
      #.DIST 33
      #.orig 33
      #.ORIG 33
      #.swp 33
      #.swo 33
      #*,v 33

      # The brightmagenta (Solarized: purple) color is free for you to use for your
      # custom file type
      .gpg 34
      .gpg 34
      .pgp 34
      .asc 34
      .3des 34
      .aes 34
      .enc 34
      .sqlite 34
    '';
    ".config/dircolors/solarized/ansi-universal.dircolors".text = ''
      # Exact Solarized Dark color theme for the color GNU ls utility.
      # Designed for dircolors (GNU coreutils) 5.97
      #
      # This simple theme was simultaneously designed for these terminal color schemes:
      # - Solarized dark  (best)
      # - Solarized light
      # - default dark
      # - default light
      # with a slight optimization for Solarized Dark.
      #
      # How the colors were selected:
      # - Terminal emulators often have an option typically enabled by default that makes
      #   bold a different color.  It is important to leave this option enabled so that
      #   you can access the entire 16-color Solarized palette, and not just 8 colors.
      # - We favor universality over a greater number of colors.  So we limit the number
      #   of colors so that this theme will work out of the box in all terminals,
      #   Solarized or not, dark or light.
      # - We choose to have the following category of files:
      #   NORMAL & FILE, DIR, LINK, EXEC and
      #   editable text including source, unimportant text, binary docs & multimedia source
      #   files, viewable multimedia, archived/compressed, and unimportant non-text
      # - For uniqueness, we stay away from the Solarized foreground colors are -- either
      #   base00 (brightyellow) or base0 (brightblue).  However, they can be used if
      #   you know what the bg/fg colors of your terminal are, in order to optimize the display.
      # - 3 different options are provided: universal, solarized dark, and solarized light.
      #   The only difference between the universal scheme and one that's optimized for
      #   dark/light is the color of "unimportant" files, which should blend more with the
      #   background
      # - We note that blue is the hardest color to see on dark bg and yellow is the hardest
      #   color to see on light bg (with blue being particularly bad).  So we choose yellow
      #   for multimedia files which are usually accessed in a GUI folder browser anyway.
      #   And blue is kept for custom use of this scheme's user.
      # - See table below to see the assignments.


      # Installation instructions:
      # This file goes in the /etc directory, and must be world readable.
      # You can copy this file to .dircolors in your $HOME directory to override
      # the system defaults.

      # COLOR needs one of these arguments: 'tty' colorizes output to ttys, but not
      # pipes. 'all' adds color characters to all output. 'none' shuts colorization
      # off.
      COLOR tty

      # Below are TERM entries, which can be a glob patterns, to match
      # against the TERM environment variable to determine if it is colorizable.
      TERM Eterm
      TERM alacritty
      TERM foot
      TERM ansi
      TERM *color*
      TERM con[0-9]*x[0-9]*
      TERM cons25
      TERM console
      TERM cygwin
      TERM *direct*
      TERM dtterm
      TERM gnome
      TERM hurd
      TERM jfbterm
      TERM konsole
      TERM kterm
      TERM linux
      TERM linux-c
      TERM mlterm
      TERM putty
      TERM rxvt*
      TERM screen*
      TERM st
      TERM terminator
      TERM tmux*
      TERM vt100
      TERM xterm*

      # EIGHTBIT, followed by '1' for on, '0' for off. (8-bit output)
      EIGHTBIT		1

      #############################################################################
      # Below are the color init strings for the basic file types. A color init
      # string consists of one or more of the following numeric codes:
      #
      # Attribute codes:
      #   00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
      # Text color codes:
      #   30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
      # Background color codes:
      #   40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white
      #
      # NOTES:
      # - See http://www.oreilly.com/catalog/wdnut/excerpt/color_names.html
      # - Color combinations
      #   ANSI Color code       Solarized  Notes                Universal             SolDark              SolLight
      #   ~~~~~~~~~~~~~~~       ~~~~~~~~~  ~~~~~                ~~~~~~~~~             ~~~~~~~              ~~~~~~~~
      #   00    none                                            NORMAL, FILE          <SAME>               <SAME>
      #   30    black           base02
      #   01;30 bright black    base03     bg of SolDark
      #   31    red             red                             docs & mm src         <SAME>               <SAME>
      #   01;31 bright red      orange                          EXEC                  <SAME>               <SAME>
      #   32    green           green                           editable text         <SAME>               <SAME>
      #   01;32 bright green    base01                          unimportant text      <SAME>
      #   33    yellow          yellow     unclear in light bg  multimedia            <SAME>               <SAME>
      #   01;33 bright yellow   base00     fg of SolLight                             unimportant non-text
      #   34    blue            blue       unclear in dark bg   user customized       <SAME>               <SAME>
      #   01;34 bright blue     base0      fg in SolDark                                                   unimportant text
      #   35    magenta         magenta                         LINK                  <SAME>               <SAME>
      #   01;35 bright magenta  violet                          archive/compressed    <SAME>               <SAME>
      #   36    cyan            cyan                            DIR                   <SAME>               <SAME>
      #   01;36 bright cyan     base1                           unimportant non-text                       <SAME>
      #   37    white           base2
      #   01;37 bright white    base3      bg in SolLight
      #   05;37;41                         unclear in Putty dark


      ### By file type

      # global default
      NORMAL			00
      # normal file
      FILE 			00
      # directory
      DIR 			36
      # 777 directory
      OTHER_WRITABLE 		30;43
      # symbolic link
      LINK 			34;40

      # pipe, socket, block device, character device (blue bg)
      FIFO 			36;40
      SOCK 			31;40
      DOOR 			35;40   # Solaris 2.5 and later
      BLK			33;40	# block device driver
      CHR			33;40	# character device driver

      CAPABILITY              30;41   # file with capability
      SETGID                  01;33   # file that is setgid (g+s)
      SETUID                  01;31   # file that is setuid (u+s)
      STICKY                  01;34   # dir with the sticky bit set (+t) and not other-writable
      STICKY_OTHER_WRITABLE   01;32   # dir that is sticky and other-writable (+t,o+w)

      #############################################################################
      ### By file attributes

      # Orphaned symlinks (blinking white on red)
      # Blink may or may not work (works on iTerm dark or light, and Putty dark)
      ORPHAN  		05;37;41
      # ... and the files that orphaned symlinks point to (blinking white on red)
      MISSING 		05;37;41

      # files with execute permission
      EXEC			31  # Unix
      .cmd			31  # Win
      .exe 			31  # Win
      .com 			31  # Win
      .bat 			31  # Win
      .reg 			31  # Win
      .app 			31  # OSX


      #############################################################################
      ### By extension

      # List any file extensions like '.gz' or '.tar' that you would like ls
      # to colorize below. Put the extension, a space, and the color init string.
      # (and any comments you want to add after a '#')

      ### Text formats

      # Text that we can edit with a regular editor
      .txt 			32
      .org 			32
      .md 			32
      .mkd 			32
      *1           		32
      .cfg         		32
      .conf        		32
      .csv			32
      .dircolors              32
      .srt                    32

      # Source text
      .h 			32
      .c 			32
      .C 			32
      .cc 			32
      .cpp 			32
      .cxx 			32
      .objc 			32
      .cl 			32
      .sh 			32
      .bash 			32
      .csh 			32
      .zsh 			32
      .el 			32
      .vim 			32
      .java 			32
      .pl 			32
      .pm 			32
      .py 			32
      .rb 			32
      .hs 			32
      .php 			32
      .htm 			32
      .html 			32
      .shtml 			32
      .erb 			32
      .haml 			32
      .xml 			32
      *build.xml   		32
      .rdf 			32
      .css 			32
      .sass 			32
      .scss 			32
      .less 			32
      .js 			32
      .coffee 		32
      .man 			32
      .0 			32
      .1 			32
      .2 			32
      .3 			32
      .4 			32
      .5 			32
      .6 			32
      .7 			32
      .8 			32
      .9 			32
      .l 			32
      .n 			32
      .p 			32
      .pod 			32
      .tex 			32
      .go 			32
      .sql 			32
      .ini         		32
      *Makefile    		32
      .n3          		32
      .nfo         		32
      .nt          		32
      .owl         		32
      *Rakefile    		32
      *rc          		32
      *README      		32
      *README.markdown 	32
      *readme.txt  		32
      *README.txt  		32
      .torrent     		32
      .ttl         		32
      .yml         		32
      .yaml        		32

      ### Multimedia formats

      # Image
      .bmp 			33
      .cgm 			33
      .dl 			33
      .dvi 			33
      .emf 			33
      .eps 			33
      .gif 			33
      .jpeg 			33
      .jpg 			33
      .JPG 			33
      .mng 			33
      .pbm 			33
      .pcx 			33
      .pdf 			33
      .pgm 			33
      .png 			33
      .PNG 			33
      .ppm 			33
      .pps 			33
      .ppsx 			33
      .ps 			33
      .svg 			33
      .svgz 			33
      .tga 			33
      .tif 			33
      .tiff 			33
      .xbm 			33
      .xcf 			33
      .xpm 			33
      .xwd 			33
      .yuv 			33
      .axa         		33 
      .CR2         		33
      .divx        		33
      .ico         		33

      # Audio
      .aac 			33
      .au  			33
      .flac 			33
      .m4a 			33
      .mid 			33
      .midi 			33
      .mka 			33
      .mp3 			33
      .mpa 			33
      .ogg  			33
      .ra 			33
      .wav 			33

      # Video
      .anx 			33
      .asf 			33
      .avi 			33
      .axv 			33
      .flc 			33
      .fli 			33
      .flv 			33
      .gl 			33
      .m2ts 			33
      .m2v 			33
      .m4v 			33
      .mkv 			33
      .mov 			33
      .MOV 			33
      .mp4 			33
      .mp4v 			33
      .mpc 			33
      .mpeg 			33
      .mpg 			33
      .nuv 			33
      .oga 			33
      .ogm 			33
      .ogv 			33
      .ogx 			33
      .qt 			33
      .rm 			33
      .rmvb 			33
      .spx 			33
      .swf 			33
      .ts 			33
      .vob 			33
      .webm 			33
      .wmv 			33
      .xspf 			33

      ### Misc

      # Binary document formats and multimedia source
      .doc 			35
      .docx 			35
      .rtf 			35
      .odt 			35
      .dot 			35
      .dotx 			35
      .ott 			35
      .xls 			35
      .xlsx 			35
      .ods 			35
      .ots 			35
      .ppt 			35
      .pptx 			35
      .odp 			35
      .otp 			35
      .fla 			35
      .psd 			35
      *Dockerfile  		35

      # Archives, compressed
      .7z   			35
      .apk  			35
      .arj  			35
      .bin  			35
      .bz   			35
      .bz2  			35
      .cab  			35  # Win
      .deb  			35
      .dmg  			35  # OSX
      .gem  			35
      .gz   			35
      .iso  			35
      .jar  			35
      .msi  			35  # Win
      .rar  			35
      .rpm  			35
      .tar  			35
      .tbz  			35
      .tbz2 			35
      .tgz  			35
      .tx   			35
      .war  			35
      .xpi  			35
      .xz   			35
      .z    			35
      .Z    			35
      .zip  			35
      .ace         		35
      .cpio        		35
      .dz          		35
      .lz          		35
      .lzh         		35
      .lzma        		35
      .rz          		35
      .taz         		35
      .tlz         		35
      .txz         		35
      .tz          		35
      .zoo         		35


      # For testing
      .ANSI-30-black 		30
      .ANSI-01;30-brblack 	01;30
      .ANSI-31-red 		31
      .ANSI-01;31-brred 	01;31
      .ANSI-32-green 		32
      .ANSI-01;32-brgreen 	01;32
      .ANSI-33-yellow 	33
      .ANSI-01;33-bryellow 	01;33
      .ANSI-34-blue 		34
      .ANSI-01;34-brblue 	01;34
      .ANSI-35-magenta 	35
      .ANSI-01;35-brmagenta 	01;35
      .ANSI-36-cyan 		36
      .ANSI-01;36-brcyan 	01;36
      .ANSI-37-white 		37
      .ANSI-01;37-brwhite 	01;37

      #############################################################################
      # Your customizations

      # Unimportant text files
      # For universal scheme, use brightgreen 01;32
      # For optimal on light bg (but too prominent on dark bg), use white 01;34
      .log 			32
      *~ 			32
      *# 			32
      .bbl         		32
      .blg         		32
      .cache       		32
      .class       		32
      .incomplete  		32
      .lof         		32
      .lol         		32
      .lot         		32
      .o           		32
      .out         		32
      .part        		32
      .pyc         		32
      .temp        		32
      .tmp         		32
      .toc         		32
      #.log 			34
      #*~ 			34
      #*# 			34
      #.bbl         		34
      #.blg         		34
      #.cache       		34
      #.class       		34
      #.incomplete  		34
      #.lof         		34
      #.lol         		34
      #.lot         		34
      #.o           		34
      #.out         		34
      #.part        		34
      #.pyc         		34
      #.temp        		34
      #.tmp         		34
      #.toc         		34


      # Unimportant non-text files
      # For universal scheme, use brightcyan 01;36
      # For optimal on dark bg (but too prominent on light bg), change to 01;33
      .bak 			34
      .BAK 			34
      .old 			34
      .OLD 			34
      .org_archive 		34
      .off 			34
      .OFF 			34
      .dist 			34
      .DIST 			34
      .orig 			34
      .ORIG 			34
      .swp 			34
      .swo 			34
      *,v 			34
      .aux         		34
      .idx2         		34

      # The brightmagenta (Solarized: purple) color is free for you to use for your
      # custom file type
      .gpg 			35
      .pgp 			35
      .asc 			35
      .3des 			35
      .aes 			35
      .enc 			35
      .sqlite 		35
    '';
    ".config/dircolors/manjaro.dircolors".text = ''
      # Configuration file for dircolors, a utility to help you set the
      # LS_COLORS environment variable used by GNU ls with the --color option.

      # Copyright (C) 1996-2014 Free Software Foundation, Inc.
      # Copying and distribution of this file, with or without modification,
      # are permitted provided the copyright notice and this notice are preserved.

      # The keywords COLOR, OPTIONS, and EIGHTBIT (honored by the
      # slackware version of dircolors) are recognized but ignored.

      # You can copy this file to .dircolors in your $HOME directory to override
      # the system defaults.

      # Below are TERM entries, which can be a glob patterns, to match
      # against the TERM environment variable to determine if it is colorizable.
      TERM Eterm
      TERM alacritty
      TERM foot
      TERM ansi
      TERM *color*
      TERM con[0-9]*x[0-9]*
      TERM cons25
      TERM console
      TERM cygwin
      TERM *direct*
      TERM dtterm
      TERM gnome
      TERM hurd
      TERM jfbterm
      TERM konsole
      TERM kterm
      TERM linux
      TERM linux-c
      TERM mlterm
      TERM putty
      TERM rxvt*
      TERM screen*
      TERM st
      TERM terminator
      TERM tmux*
      TERM vt100
      TERM xterm*

      # Below are the color init strings for the basic file types. A color init
      # string consists of one or more of the following numeric codes:
      # Attribute codes:
      # 00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
      # Text color codes:
      # 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
      # Background color codes:
      # 40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white
      #NORMAL 00	# no color code at all
      #FILE 00	# regular file: use no color at all
      RESET 0		# reset to "normal" color
      DIR 01;34	# directory
      LINK 01;36	# symbolic link.  (If you set this to 'target' instead of a
                      # numerical value, the color is as for the file pointed to.)
      MULTIHARDLINK 00	# regular file with more than one link
      FIFO 40;33	# pipe
      SOCK 01;35	# socket
      DOOR 01;35	# door
      BLK 40;33;01	# block device driver
      CHR 40;33;01	# character device driver
      ORPHAN 01;05;37;41  # orphaned syminks
      MISSING 01;05;37;41 # ... and the files they point to
      SETUID 37;41	# file that is setuid (u+s)
      SETGID 30;43	# file that is setgid (g+s)
      CAPABILITY 30;41	# file with capability
      STICKY_OTHER_WRITABLE 30;42 # dir that is sticky and other-writable (+t,o+w)
      OTHER_WRITABLE 34;42 # dir that is other-writable (o+w) and not sticky
      STICKY 37;44	# dir with the sticky bit set (+t) and not other-writable

      # This is for files with execute permission:
      EXEC 01;32

      # List any file extensions like '.gz' or '.tar' that you would like ls
      # to colorize below. Put the extension, a space, and the color init string.
      # (and any comments you want to add after a '#')

      # If you use DOS-style suffixes, you may want to uncomment the following:
      #.cmd 01;32 # executables (bright green)
      #.exe 01;32
      #.com 01;32
      #.btm 01;32
      #.bat 01;32
      # Or if you want to colorize scripts even if they do not have the
      # executable bit actually set.
      #.sh  01;32
      #.csh 01;32

       # archives or compressed (bright red)
      .tar 01;31
      .tgz 01;31
      .arc 01;31
      .arj 01;31
      .taz 01;31
      .lha 01;31
      .lz4 01;31
      .lzh 01;31
      .lzma 01;31
      .tlz 01;31
      .txz 01;31
      .tzo 01;31
      .t7z 01;31
      .zip 01;31
      .z   01;31
      .Z   01;31
      .dz  01;31
      .gz  01;31
      .lrz 01;31
      .lz  01;31
      .lzo 01;31
      .xz  01;31
      .bz2 01;31
      .bz  01;31
      .tbz 01;31
      .tbz2 01;31
      .tz  01;31
      .deb 01;31
      .rpm 01;31
      .jar 01;31
      .war 01;31
      .ear 01;31
      .sar 01;31
      .rar 01;31
      .alz 01;31
      .ace 01;31
      .zoo 01;31
      .cpio 01;31
      .7z  01;31
      .rz  01;31
      .cab 01;31

      # image formats
      .jpg 01;35
      .jpeg 01;35
      .gif 01;35
      .bmp 01;35
      .pbm 01;35
      .pgm 01;35
      .ppm 01;35
      .tga 01;35
      .xbm 01;35
      .xpm 01;35
      .tif 01;35
      .tiff 01;35
      .png 01;35
      .svg 01;35
      .svgz 01;35
      .mng 01;35
      .pcx 01;35
      .mov 01;35
      .mpg 01;35
      .mpeg 01;35
      .m2v 01;35
      .mkv 01;35
      .webm 01;35
      .ogm 01;35
      .mp4 01;35
      .m4v 01;35
      .mp4v 01;35
      .vob 01;35
      .qt  01;35
      .nuv 01;35
      .wmv 01;35
      .asf 01;35
      .rm  01;35
      .rmvb 01;35
      .flc 01;35
      .avi 01;35
      .fli 01;35
      .flv 01;35
      .gl 01;35
      .dl 01;35
      .xcf 01;35
      .xwd 01;35
      .yuv 01;35
      .cgm 01;35
      .emf 01;35

      # http://wiki.xiph.org/index.php/MIME_Types_and_File_Extensions
      .axv 01;35
      .anx 01;35
      .ogv 01;35
      .ogx 01;35

      # Document files
      .pdf 00;32
      .ps 00;32
      .txt 00;32
      .patch 00;32
      .diff 00;32
      .log 00;32
      .tex 00;32
      .doc 00;32

      # audio formats
      .aac 00;36
      .au 00;36
      .flac 00;36
      .m4a 00;36
      .mid 00;36
      .midi 00;36
      .mka 00;36
      .mp3 00;36
      .mpc 00;36
      .ogg 00;36
      .ra 00;36
      .wav 00;36

      # http://wiki.xiph.org/index.php/MIME_Types_and_File_Extensions
      .axa 00;36
      .oga 00;36
      .spx 00;36
      .xspf 00;36
    '';
    ".config/dircolors/normal.dircolors".text = ''
      # This file goes in the /etc directory, and must be world readable.
      # You can copy this file to .dir_colors in your $HOME directory to override
      # the system defaults.

      # Configuration file for dircolors, a utility to help you set the
      # LS_COLORS environment variable used by GNU ls with the --color option.

      # Copyright (C) 1996-2021 Free Software Foundation, Inc.
      # Copying and distribution of this file, with or without modification,
      # are permitted provided the copyright notice and this notice are preserved.

      # The keywords COLOR, OPTIONS, and EIGHTBIT (honored by the
      # slackware version of dircolors) are recognized but ignored.

      # For compatibility, the pattern "^COLOR.*none" is recognized as a way to
      # disable colorization.  See https://bugzilla.redhat.com/1349579 for details.

      # Below are TERM entries, which can be a glob patterns, to match
      # against the TERM environment variable to determine if it is colorizable.
      TERM Eterm
      TERM alacritty
      TERM foot
      TERM ansi
      TERM *color*
      TERM con[0-9]*x[0-9]*
      TERM cons25
      TERM console
      TERM cygwin
      TERM *direct*
      TERM dtterm
      TERM gnome
      TERM hurd
      TERM jfbterm
      TERM konsole
      TERM kterm
      TERM linux
      TERM linux-c
      TERM mlterm
      TERM putty
      TERM rxvt*
      TERM screen*
      TERM st
      TERM terminator
      TERM tmux*
      TERM vt100
      TERM xterm*

      # Below are the color init strings for the basic file types.
      # One can use codes for 256 or more colors supported by modern terminals.
      # The default color codes use the capabilities of an 8 color terminal
      # with some additional attributes as per the following codes:
      # Attribute codes:
      # 00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
      # Text color codes:
      # 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
      # Background color codes:
      # 40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white
      #NORMAL 00	# no color code at all
      #FILE 00	# regular file: use no color at all
      RESET 0		# reset to "normal" color
      DIR 01;34	# directory
      LINK 01;36	# symbolic link.  (If you set this to 'target' instead of a
                      # numerical value, the color is as for the file pointed to.)
      MULTIHARDLINK 00	# regular file with more than one link
      FIFO 40;33	# pipe
      SOCK 01;35	# socket
      DOOR 01;35	# door
      BLK 40;33;01	# block device driver
      CHR 40;33;01	# character device driver
      ORPHAN 40;31;01 # symlink to nonexistent file, or non-stat'able file ...
      MISSING 01;37;41 # ... and the files they point to
      SETUID 37;41	# file that is setuid (u+s)
      SETGID 30;43	# file that is setgid (g+s)
      CAPABILITY 30;41	# file with capability
      STICKY_OTHER_WRITABLE 30;42 # dir that is sticky and other-writable (+t,o+w)
      OTHER_WRITABLE 34;42 # dir that is other-writable (o+w) and not sticky
      STICKY 37;44	# dir with the sticky bit set (+t) and not other-writable

      # This is for files with execute permission:
      EXEC 01;32

      # List any file extensions like '.gz' or '.tar' that you would like ls
      # to colorize below. Put the extension, a space, and the color init string.
      # (and any comments you want to add after a '#')

      # If you use DOS-style suffixes, you may want to uncomment the following:
      #.cmd 01;32 # executables (bright green)
      #.exe 01;32
      #.com 01;32
      #.btm 01;32
      #.bat 01;32
      # Or if you want to colorize scripts even if they do not have the
      # executable bit actually set.
      #.sh  01;32
      #.csh 01;32

       # archives or compressed (bright red)
      .tar 01;31
      .tgz 01;31
      .arc 01;31
      .arj 01;31
      .taz 01;31
      .lha 01;31
      .lz4 01;31
      .lzh 01;31
      .lzma 01;31
      .tlz 01;31
      .txz 01;31
      .tzo 01;31
      .t7z 01;31
      .zip 01;31
      .z   01;31
      .dz  01;31
      .gz  01;31
      .lrz 01;31
      .lz  01;31
      .lzo 01;31
      .xz  01;31
      .zst 01;31
      .tzst 01;31
      .bz2 01;31
      .bz  01;31
      .tbz 01;31
      .tbz2 01;31
      .tz  01;31
      .deb 01;31
      .rpm 01;31
      .jar 01;31
      .war 01;31
      .ear 01;31
      .sar 01;31
      .rar 01;31
      .alz 01;31
      .ace 01;31
      .zoo 01;31
      .cpio 01;31
      .7z  01;31
      .rz  01;31
      .cab 01;31
      .wim 01;31
      .swm 01;31
      .dwm 01;31
      .esd 01;31

      # image formats
      .jpg 01;35
      .jpeg 01;35
      .mjpg 01;35
      .mjpeg 01;35
      .gif 01;35
      .bmp 01;35
      .pbm 01;35
      .pgm 01;35
      .ppm 01;35
      .tga 01;35
      .xbm 01;35
      .xpm 01;35
      .tif 01;35
      .tiff 01;35
      .png 01;35
      .svg 01;35
      .svgz 01;35
      .mng 01;35
      .pcx 01;35
      .mov 01;35
      .mpg 01;35
      .mpeg 01;35
      .m2v 01;35
      .mkv 01;35
      .webm 01;35
      .webp 01;35
      .ogm 01;35
      .mp4 01;35
      .m4v 01;35
      .mp4v 01;35
      .vob 01;35
      .qt  01;35
      .nuv 01;35
      .wmv 01;35
      .asf 01;35
      .rm  01;35
      .rmvb 01;35
      .flc 01;35
      .avi 01;35
      .fli 01;35
      .flv 01;35
      .gl 01;35
      .dl 01;35
      .xcf 01;35
      .xwd 01;35
      .yuv 01;35
      .cgm 01;35
      .emf 01;35

      # https://wiki.xiph.org/MIME_Types_and_File_Extensions
      .ogv 01;35
      .ogx 01;35

      # audio formats
      .aac 01;36
      .au 01;36
      .flac 01;36
      .m4a 01;36
      .mid 01;36
      .midi 01;36
      .mka 01;36
      .mp3 01;36
      .mpc 01;36
      .ogg 01;36
      .ra 01;36
      .wav 01;36

      # https://wiki.xiph.org/MIME_Types_and_File_Extensions
      .oga 01;36
      .opus 01;36
      .spx 01;36
      .xspf 01;36
    '';
    ".config/dircolors/normal-lightbg.dircolors".text = ''
      # Configuration file for the color ls utility - modified for lighter backgrounds

      # This file goes in the /etc directory, and must be world readable.
      # You can copy this file to .dir_colors in your $HOME directory to override
      # the system defaults.

      # Configuration file for dircolors, a utility to help you set the
      # LS_COLORS environment variable used by GNU ls with the --color option.

      # Copyright (C) 1996-2021 Free Software Foundation, Inc.
      # Copying and distribution of this file, with or without modification,
      # are permitted provided the copyright notice and this notice are preserved.

      # The keywords COLOR, OPTIONS, and EIGHTBIT (honored by the
      # slackware version of dircolors) are recognized but ignored.

      # For compatibility, the pattern "^COLOR.*none" is recognized as a way to
      # disable colorization.  See https://bugzilla.redhat.com/1349579 for details.

      # Below are TERM entries, which can be a glob patterns, to match
      # against the TERM environment variable to determine if it is colorizable.
      TERM Eterm
      TERM alacritty
      term foot
      TERM ansi
      TERM *color*
      TERM con[0-9]*x[0-9]*
      TERM cons25
      TERM console
      TERM cygwin
      TERM *direct*
      TERM dtterm
      TERM gnome
      TERM hurd
      TERM jfbterm
      TERM konsole
      TERM kterm
      TERM linux
      TERM linux-c
      TERM mlterm
      TERM putty
      TERM rxvt*
      TERM screen*
      TERM st
      TERM terminator
      TERM tmux*
      TERM vt100
      TERM xterm*

      # Below are the color init strings for the basic file types.
      # One can use codes for 256 or more colors supported by modern terminals.
      # The default color codes use the capabilities of an 8 color terminal
      # with some additional attributes as per the following codes:
      # Attribute codes:
      # 00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
      # Text color codes:
      # 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
      # Background color codes:
      # 40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white
      #NORMAL 00	# no color code at all
      #FILE 00	# regular file: use no color at all
      RESET 0		# reset to "normal" color
      DIR 00;34	# directory
      LINK 00;36	# symbolic link.  (If you set this to 'target' instead of a
                      # numerical value, the color is as for the file pointed to.)
      MULTIHARDLINK 00	# regular file with more than one link
      FIFO 40;33	# pipe
      SOCK 00;35	# socket
      DOOR 00;35	# door
      BLK 40;33;01	# block device driver
      CHR 40;33;01	# character device driver
      ORPHAN 40;31;01 # symlink to nonexistent file, or non-stat'able file ...
      MISSING 01;37;41 # ... and the files they point to
      SETUID 37;41	# file that is setuid (u+s)
      SETGID 30;43	# file that is setgid (g+s)
      CAPABILITY 30;41	# file with capability
      STICKY_OTHER_WRITABLE 30;42 # dir that is sticky and other-writable (+t,o+w)
      OTHER_WRITABLE 34;42 # dir that is other-writable (o+w) and not sticky
      STICKY 37;44	# dir with the sticky bit set (+t) and not other-writable

      # This is for files with execute permission:
      EXEC 00;32

      # List any file extensions like '.gz' or '.tar' that you would like ls
      # to colorize below. Put the extension, a space, and the color init string.
      # (and any comments you want to add after a '#')

      # If you use DOS-style suffixes, you may want to uncomment the following:
      #.cmd 01;32 # executables (bright green)
      #.exe 01;32
      #.com 01;32
      #.btm 01;32
      #.bat 01;32
      # Or if you want to colorize scripts even if they do not have the
      # executable bit actually set.
      #.sh  01;32
      #.csh 01;32

       # archives or compressed (bright red)
      .tar 00;31
      .tgz 00;31
      .arc 00;31
      .arj 00;31
      .taz 00;31
      .lha 00;31
      .lz4 00;31
      .lzh 00;31
      .lzma 00;31
      .tlz 00;31
      .txz 00;31
      .tzo 00;31
      .t7z 00;31
      .zip 00;31
      .z   00;31
      .dz  00;31
      .gz  00;31
      .lrz 00;31
      .lz  00;31
      .lzo 00;31
      .xz  00;31
      .zst 00;31
      .tzst 00;31
      .bz2 00;31
      .bz  00;31
      .tbz 00;31
      .tbz2 00;31
      .tz  00;31
      .deb 00;31
      .rpm 00;31
      .jar 00;31
      .war 00;31
      .ear 00;31
      .sar 00;31
      .rar 00;31
      .alz 00;31
      .ace 00;31
      .zoo 00;31
      .cpio 00;31
      .7z  00;31
      .rz  00;31
      .cab 00;31
      .wim 00;31
      .swm 00;31
      .dwm 00;31
      .esd 00;31

      # image formats
      .jpg 00;35
      .jpeg 00;35
      .mjpg 00;35
      .mjpeg 00;35
      .gif 00;35
      .bmp 00;35
      .pbm 00;35
      .pgm 00;35
      .ppm 00;35
      .tga 00;35
      .xbm 00;35
      .xpm 00;35
      .tif 00;35
      .tiff 00;35
      .png 00;35
      .svg 00;35
      .svgz 00;35
      .mng 00;35
      .pcx 00;35
      .mov 00;35
      .mpg 00;35
      .mpeg 00;35
      .m2v 00;35
      .mkv 00;35
      .webm 00;35
      .webp 00;35
      .ogm 00;35
      .mp4 00;35
      .m4v 00;35
      .mp4v 00;35
      .vob 00;35
      .qt  00;35
      .nuv 00;35
      .wmv 00;35
      .asf 00;35
      .rm  00;35
      .rmvb 00;35
      .flc 00;35
      .avi 00;35
      .fli 00;35
      .flv 00;35
      .gl 00;35
      .dl 00;35
      .xcf 00;35
      .xwd 00;35
      .yuv 00;35
      .cgm 00;35
      .emf 00;35

      # https://wiki.xiph.org/MIME_Types_and_File_Extensions
      .ogv 00;35
      .ogx 00;35

      # audio formats
      .aac 00;36
      .au 00;36
      .flac 00;36
      .m4a 00;36
      .mid 00;36
      .midi 00;36
      .mka 00;36
      .mp3 00;36
      .mpc 00;36
      .ogg 00;36
      .ra 00;36
      .wav 00;36

      # https://wiki.xiph.org/MIME_Types_and_File_Extensions
      .oga 00;36
      .opus 00;36
      .spx 00;36
      .xspf 00;36
    '';
    ".config/dircolors/solarized/README.md".text = ''
      <h1>Solarized Color Theme for GNU ls (as setup by GNU dircolors)</h1>

      This is a repository of themes for GNU ls (configured via GNU
      dircolors) that support Ethan Schoonover’s [Solarized color
      scheme](http://ethanschoonover.com/solarized).

      See the [Solarized homepage](http://ethanschoonover.com/solarized)
      for screenshots, details and color theme implementations for terminal
      emulators and other applications, such as Vim, Emacs, and Mutt.

      Quick note for MacOS users: Your OS does not use GNU ls, so you can not use
      this themes. However, [@logic](https://github.com/logic) provided something
      your can use in [this issue](https://github.com/seebi/dircolors-solarized/issues/10).
      Another option (as [proposed](https://github.com/seebi/dircolors-solarized/issues/10#issuecomment-2641754)
      by [@metamorfos](https://github.com/metamorfos)) is to install GNU ls with
      homebrew (coreutils).

      <h2>(Selected) Table of Contents</h2>

      * [Repositories](#repositories)
      * [Themes](#themes)
        * [Theme #1: "256dark"](#256dark)
        * [Theme #2: "ansi-\*"](#ansi)
      * [Installation](#installation)
      * [Understanding Solarized Colors in Terminals](#understanding-solarized-colors-in-terminals)

      <h2 id="repositories">Repositories</h2>

        * The main Solarized repository: [/altercation/solarized](https://github.com/altercation/solarized)
        * These themes as a separate repository: [/seebi/dircolors-solarized](https://github.com/seebi/dircolors-solarized)

      <h2 id="themes">Themes</h2>

      First, note that "256 colors" does not necessarily mean better than "ANSI".
      Read on for more details.

      1.  "256dark" - Degraded Solarized Dark theme for terminal emulators and
          newer dircolors that both support 256 colors. This theme allows for the display
          of the *approximate* Solarized palette, but it's very easy to set up and allows
          for the use of many more colors beyond the 16 in Solarized.
          (By [seebi](https://github.com/seebi))

          Note: In the future, it may be possible to change the approximate
          Solarized colors to the exact Solarized palette; and this theme would
          automatically improve.  Work on an appropriate .Xresources has not yet
          started. (See [256-color remapping discussion](https://github.com/altercation/solarized/issues/8).)

      2.  "ansi-universal" - Universal theme for 16-color or 256-color
          terminal emulators and any version of dircolors.  It is optimized for
          Solarized Dark and Light and acceptable with default ANSI colors. This theme allows
          for the display of the *exact* Solarized palette, but it requires the reconfiguration
          of the terminal emulator's ANSI color settings and limits you to the 16
          Solarized colors. (By [huyz](https://github.com/huyz))

          "ansi-dark" - Tweaked version of "ansi-universal", slightly more
          optimized for the Solarized Dark palette to the slight detriment of the
          Solarized Light palette.

          "ansi-light" - Tweaked version of "ansi-universal", slightly more
          optimized for the Solarized Light palette to the slight detriment of the
          Solarized Dark palette.

      <h3 id="256dark">Theme #1: "256dark" (by <a href="https://github.com/seebi">seebi</a>)</h3>

      <h4 id="256dark-features">Features / Properties</h4>

        * Solarized :-)
        * Comment style for backup and log and cache files
        * Highlighted style for files of special interest (.tex, Makefiles, .ini ...)
        * Bold hierarchies:
          * archive = violet, compressed archive = violet + bold
          * audio = orange, video = orange + bold
        * Tested use-cases:
          * latex directories
          * source code directories
        * Special files (block devices, pipes, ...) are inverted using the
          solarized light palette  for the background
        * Symbolic links bold and distinguishable from directories

      <h4 id="256dark-screenshots">Screenshots</h4>

      Here is a [1920pxx1200px screenshot](https://github.com/seebi/dircolors-solarized/raw/master/img/dircolors.256dark.png) of a prepared [tmux](http://tmux.sourceforge.net/)-session.
      It is captured from a [gnome-terminal](http://library.gnome.org/users/gnome-terminal/stable/index.html.en) using the [dz-version of the awesome Inconsolata font](http://nodnod.net/2009/feb/12/adding-straight-single-and-double-quotes-inconsola/) but you can use any [libvte](http://developer.gnome.org/vte/0.27/) based terminal emulator (and other emulator which support 256colors).
      I recently switched to [sakura](https://launchpad.net/sakura) and my decision was based on [this comparison](http://www.calno.com/evilvte/) and the priming that the gnome-terminal was too slow and too fat.

       * **upper left** - Common colors in action: Executables, archives, audio/video stuff, dead links
       * **lower left** - latex directory: tex-trash is in comment style and tex are main files of interest and highlighted
       * **upper right and thereunder** - source directories: all source files are standard highlighted, makefiles, configuration files and READMEs are of special interest, and object and class files are commented out.
       * **lower right** - all colors in action, uncommon stuff like pipes and block devices

      ![tmux session](https://github.com/seebi/dircolors-solarized/raw/master/img/dircolors.256dark.png)

      Some more screenshots are provided by [andrew from webupd8.org](http://www.webupd8.org/2011/04/solarized-must-have-color-paletter-for.html).

      <h3 id="ansi">Theme #2: "ansi-\*" (by <a href="https://github.com/huyz">huyz</a>)</h3>

      This theme and its variants require that the terminal emulator be properly
      configured to display the Solarized palette instead of the 16 default ANSI
      colors.

      <h4 id="ansi-features">Features / Properties</h4>

      This theme called "ansi-universal" and its variants "ansi-dark" and
      "ansi-light", were designed to work best with both Solarized Dark and Light
      palettes, but also to work under terminals' default ANSI colors. In other
      words, these themes were designed with a "fallback" scenario: if you happen to
      find yourself on a terminal where the Solarized palette has not been set up,
      you won't have elements become invisible, incrediby hard to read, or a boring
      gray.

      Thus, the universal theme was designed with these 4 palettes in mind:

      -   Solarized Dark: "ansi-universal" works best when the terminal emulator is
          set to this scheme
      -   Solarized Light: "ansi-universal" works best when the terminal emulator is
          set to this scheme
      -   Default terminal ANSI Colors with a dark background
      -   Default terminal ANSI Colors with a light background

      The "ansi-dark" and "ansi-light" are slightly optimized versions of "ansi-universal"
      for Solarized Dark and Solarized Light, respectively, if you're willing
      to sacrifice a bit of universality.

      Colors were selected based on the characteristics of the items to be displayed:

      -   Visibility generally follows importance, with an attempt to let unimportant
          items fade into the background (which is not always possible when
          simultaneously supporting dark and light backgrounds)
      -   Loud colors are chosen to call attention to noteworthy items

      <h4 id="ansi-screenshots">Screenshots</h4>

      Solarized Dark (this example uses iTerm2 on OS X):

      ![Solarized Dark](https://github.com/huyz/dircolors-solarized/raw/master/img/screen-dircolors-in-iTerm2-solarized_dark.png)]

      To see what this theme looks like when the terminal emulator is set with different color palettes:

      *   [Solarized Light (with iTerm2 on OS X)](https://github.com/huyz/dircolors-solarized/raw/master/img/screen-dircolors-in-iTerm2-solarized_light.png)
      *   [Default dark background of iTerm on OS X](https://github.com/huyz/dircolors-solarized/raw/master/img/screen-dircolors-in-iTerm-dark.png)
      *   [Default light background of iTerm on OS X](https://github.com/huyz/dircolors-solarized/raw/master/img/screen-dircolors-in-iTerm-light.png)
      *   [Default dark colors of PuTTY on Windows](https://github.com/huyz/dircolors-solarized/raw/master/img/screen-dircolors-in-PuTTY-dark_default.png)
      *   [Default light colors of PuTTY on Windows](https://github.com/huyz/dircolors-solarized/raw/master/img/screen-dircolors-in-PuTTY-light_system.png) (Select "Use system colors")


      <h2 id="installation">Installation</h2>

      ### Downloads

      If you have come across these themes via the [dircolors-only repository] on
      github, you may want to check the main [Solarized repository] to see if there
      are official themes.

      In the future, the [dircolors-only repository] may be kept in sync with the main
      [Solarized repository], but the [dircolors-only repository] may be left separate
      for installation convenience and to include the latest improvements.

      At this time, issues, bug reports, changelogs are to be reported at the
      [dircolors-only repository].

      If you want to access the latest improvements to a specific theme, then go to
      that theme's unique github directory:

      *   "256dark":                  https://github.com/seebi/dircolors-solarized
      *   "ansi-\*":                  https://github.com/huyz/dircolors-solarized

      [Solarized repository]:         https://github.com/altercation/solarized
      [dircolors-only repository]:    https://github.com/seebi/dircolors-solarized

      ### General Instructions

      The Solarized color themes are distributed as database files for GNU
      dircolors, which is the application that sets up colors for GNU ls.
      To use any of the database files, run this:

          eval `dircolors /path/to/dircolorsdb`

      To activate the theme for all future shell sessions, copy or link that file to
      `~/.dircolors`, and include the above command in your `~/.profile` (for bash)
      or `~/.zshrc` (for zsh).

      For Ubuntu 14.04 it is sufficient to copy or link database file to `~/.dircolors`.
      Statement in `~/.bashrc` will take care about triggering eval command.

      ### Additional Instructions for 256-color Solarized Themes, e.g. "256dark"

      For the 256-color Solarized dircolors themes, such as "256dark", you need a 256-color
      terminal (e.g. `gnome-terminal` or `urxvt`) and a correct `TERM` variable,
      e.g.:

          export TERM=xterm-256color        # for common 256 color terminals (e.g. gnome-terminal)
          export TERM=screen-256color       # for a tmux -2 session (also for screen)
          export TERM=rxvt-unicode-256color # for a colorful rxvt unicode session

      ### Additional Instructions for ANSI Solarized Themes, e.g. "ansi-universal"

      For the ANSI Solarized dircolors themes (which work with both 16-color and
      256-color terminals) you must configure your terminal emulator (See the
      section "Understanding Solarized Colors in Terminals" for a detailed
      explanation behind these settings):

      1.  Make sure that you have changed your terminal emulator's color settings to
          the Solarized palette.

      2.  Make sure that bold text is displayed using bright colors. For example,
          -   For iTerm2 on OS X, this means that Text Preferences must have the `Draw
              bold text in bright colors` checkbox *selected*.
          -   For Apple's Terminal.app on OS X, this means that Text Settings must
              have the `Use bright colors for bold text` checkbox *selected*.

      3.  It's recommended to turn off the display of bold typeface for bold
          text.  For example,
          -   For iTerm2 on OS X, this means that Text Preferences should have the
              `Draw bold text in bold font` checkbox *unselected*.
          -   For Apple's Terminal.app on OS X, this means that Text Settings
              should have the `Use bold fonts` checkbox *unselected*.
          -   For XTerm, this may mean setting the `font` and `boldFont` to be the
              same in your .Xresources or .Xdefaults, e.g.:

                  xterm*font: fixed
                  xterm*boldFont: fixed

      Example: for iTerm2, these are the correct settings:

      ![iTerm bold settings](https://github.com/huyz/dircolors-solarized/raw/master/img/screen-iTerm2-bold-options.png)


      <h2 id="understanding">Understanding Solarized Colors in Terminals</h2>

      ### How Solarized works with ANSI-redefinition themes

      8- or 256-color terminal programs such as dircolors use color codes that
      correspond to the expected 8 normal ANSI colors.  dircolors additionally
      supports bold, which terminal emulators will usually display by using the
      *bright* versions of the 8 ANSI colors and/or by using a bold typeface with a
      heavier weight. (Note that different terminal emulators may have slightly
      different ideas of what color values to use when displaying the 16 [ANSI color
      escape codes](http://en.wikipedia.org/wiki/ANSI_escape_code#Colors).)

      In order to be displayed by 8- or 256-color terminal programs, which cannot
      specify RGB values, Solarized must replace the default ANSI colors.  Since the
      Solarized palette uses 16 colors, not only must this color scheme replace the
      8 normal colors but must also take over the 8 *bright* colors, for a total of
      16 colors. This means that a Solarized terminal application loses the ability
      to bold text but gains 8 more Solarized colors.

      About half of the Solarized palette is reminiscent of the original ANSI
      colors, e.g. Solarized red is close to ANSI red (or more precisely, the
      general consensus of what ANSI red should look like).  But the rest of the
      Solarized colors do not correspond to any ANSI colors, e.g. there is no ANSI
      color that corresponds to Solarized orange or purple.

      This means that, for example, if the dircolors theme wants to display "green", a
      Solarized terminal will display something close to green, but if the theme
      wants to display "bold yellow" or "bright yellow", a Solarized terminal will
      not be able to display it.  However, a Solarized theme will be able to display
      the new colors orange and purple and also several shades of gray.  This is
      again thanks to the replacement of the ANSI *bright* colors; e.g. ANSI "bold
      red", which is usually displayed as "bright red", will now show as Solarized
      orange, while ANSI "bold blue", which is usually displayed as "bright blue",
      will now be a shade of gray.

      #### Terminal Emulator

      Because dircolors is entirely dependent on the terminal emulator for the
      display of its colors, you cannot directly tell a dircolors theme to display
      Solarized orange, e.g. by specifying an RGB value. Instead, the theme's colors
      must be chosen using the available color codes (either ANSI or one of the 256
      XTerm colors) with the expectation that the terminal emulator will display
      them as appropriate Solarized colors. For example, the dircolors color
      format `01;31` which normally would be "bold red" is expected to be displayed
      by the terminal emulator as Solarized orange.

      So in order for dircolors to display the *exact* Solarized palette, you have
      to set your Terminal emulator's color settings to the Solarized palette. The
      [Solarized repository] includes theme settings for some popular terminal
      emulators as well as Xresources; or you can download them from the official
      [Solarized] homepage. If you use the 16-color themes *without* having
      changed your emulator's palette, you will get a strange selection of colors
      that may be hard to read or gray.

      Yes, this means that, to use the *exact* Solarized theme for dircolors, you
      need to change color settings for not one but two different programs: your
      terminal emulator and dircolors.  The two sets of settings will work in
      concert to display Solarized colors appropriately.

      #### Bold Settings

      Historically, there has been a one-to-one correspondence between the bolded
      versions of the 8 default ANSI colors and the bright versions of the 8 default
      colors.  Back in the day, when a color program demanded the display of bold
      text, it was probably just easier for terminal emulators to display a brighter
      version of whatever color the text was (and expect the user to interpret that
      as bold) than to display a typeface with a bold weight.

      Nowadays, it is easy for terminal emulators to display bold typefaces, so it
      doesn't make sense for bolded text to change color, but the confusing
      association remains. In fact, new terminal emulators allow users to break the
      correspondence between bold and bright and can simply change the font.

      However, ANSI terminal applications such as older dircolors only
      have a conception of bold and don't know about the possibility of using up to
      16 colors.  So to use all 16 Solarized colors, we change the semantics of
      "bold" in the theme to mean that we want to access the 8 new Solarized colors,
      including the grays. Recall the example above, where we described that the
      dirco color format `01;31`, which would have normally displayed bold red, is
      expected to show up as Solarized orange.

      This is why it is important to *not* break the association between bold and
      bright colors. Many terminal emulators offer an option to disable the use of
      bright colors for bold, and you must not do so.  Often, new users of Solarized
      will be confused when they change their terminal emulator's color palette to
      Solarized but haven't yet installed Solarized-specific color themes for all
      their terminal applications (e.g. mutt, ls's dircolors, irssi, and their
      colorized shell prompts).  They will see texts that are hard to read or
      disappear entirely.  The solution isn't to disable bright colors; the solution
      is to install Solarized color themes for all terminal applications and then you
      will have all 16 colors.

      Also, because the semantics of "bold" are lost in favor of more colors, it
      also makes sense to disable the display of bold text as a bold typeface.  It
      won't hurt to see bold typefaces wherever the new 8 Solarized colors are
      displayed but it doesn't make much sense anymore.

      ### How Solarized works with 256-color themes

      Newer versions of dircolors, as well as modern terminal emulators, support 256
      colors.  Since 256 > 16, does this mean that 256-color dircolors themes are
      better than ANSI dircolors themes for displaying the Solarized palette?  Not
      necessarily.  Solarized is a 16-color palette with unique RGB values.
      256-color terminal emulators have more colors than the ANSI palette but
      completely different RGB values. (See [8-bit color
      graphics](http://en.wikipedia.org/wiki/256_colors).) The "256dark"
      theme was designed to use these standard fixed colors.

      #### How Solarized could work with 256 colors without touching ANSI

      There is ongoing
      [discussion](https://github.com/altercation/solarized/issues/8) on how to
      reconfigure the approximate Solarized colors (the default 256 XTerm colors) to
      display the exact Solarized colors.  The benefit of this approach is that the
      ANSI colors would not be messed with, and all the existing terminal
      applications (with non-Solarized-aware color themes) that expect ANSI colors
      would get ANSI colors; i.e. you would not see text accidentally disappear or
      turn gray on you as soon as you change your terminal emulator's ANSI color
      settings to Solarized.

      The disadvantage of such a solution means that 8-color terminal applications
      such as irssi or older dircolors would not be able to display Solarized
      colors, no matter what theme they used.

      Work on an official solution has not yet started but the
      [discussion](https://github.com/altercation/solarized/issues/8) has presented
      some working solutions, at least for XTerm and possibly other Linux terminal
      emulators.


      The Solarized Color Values
      --------------------------

      L\*a\*b values are canonical (White D65, Reference D50), other values are
      matched in sRGB space.


          SOLARIZED HEX     16/8 TERMCOL  XTERM/HEX   L*A*B      sRGB        HSB
          --------- ------- ---- -------  ----------- ---------- ----------- -----------
          base03    #002b36  8/4 brblack  234 #1c1c1c 15 -12 -12   0  43  54 193 100  21
          base02    #073642  0/4 black    235 #262626 20 -12 -12   7  54  66 192  90  26
          base01    #586e75 10/7 brgreen  240 #4e4e4e 45 -07 -07  88 110 117 194  25  46
          base00    #657b83 11/7 bryellow 241 #585858 50 -07 -07 101 123 131 195  23  51
          base0     #839496 12/6 brblue   244 #808080 60 -06 -03 131 148 150 186  13  59
          base1     #93a1a1 14/4 brcyan   245 #8a8a8a 65 -05 -02 147 161 161 180   9  63
          base2     #eee8d5  7/7 white    254 #d7d7af 92 -00  10 238 232 213  44  11  93
          base3     #fdf6e3 15/7 brwhite  230 #ffffd7 97  00  10 253 246 227  44  10  99
          yellow    #b58900  3/3 yellow   136 #af8700 60  10  65 181 137   0  45 100  71
          orange    #cb4b16  9/3 brred    166 #d75f00 50  50  55 203  75  22  18  89  80
          red       #dc322f  1/1 red      160 #d70000 50  65  45 220  50  47   1  79  86
          magenta   #d33682  5/5 magenta  125 #af005f 50  65 -05 211  54 130 331  74  83
          violet    #6c71c4 13/5 brmagenta 61 #5f5faf 50  15 -45 108 113 196 237  45  77
          blue      #268bd2  4/4 blue      33 #0087ff 55 -10 -45  38 139 210 205  82  82
          cyan      #2aa198  6/6 cyan      37 #00afaf 60 -35 -05  42 161 152 175  74  63
          green     #859900  2/2 green     64 #5f8700 60 -20  65 133 153   0  68 100  60

      NOTE:

      *   For "256-color" themes, the XTERM/HEX column lists the approximate Solarized
          colors that are used (note the RGB values in the XTERM/HEX column only
          approximates the RGB values in the HEX column).
      *   For "ANSI" themes, the TERMCOL column lists the ANSI colors that are replaced 
          with the Solarized colors listed under the HEX column.
      '';
  };
}
