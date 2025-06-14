{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.abcde
  ];
  home.file = {
    ".abcde.conf".text = ''
      # -----------------$HOME/.abcde.conf----------------- #
      # 
      # A configuration file to convert music cds to 
      #       MP3 format using abcde version 2.7.1
      # or
      #       m4a/aac format using fdkaac and abcde version 2.7.1
      # 
      #       http://andrews-corner.org/abcde.html
      # -------------------------------------------------- #

      # Encode tracks immediately after reading. Saves disk space, gives
      # better reading of 'scratchy' disks and better troubleshooting of
      # encoding process but slows the operation of abcde quite a bit:
      LOWDISK=y

      # Specify the method to use to retrieve the track information,
      # the alternative is to specify 'cddb':
      CDDBMETHOD=musicbrainz

      # Make a local cache of cddb entries and then volunteer to use 
      # these entries when and if they match the cd:
      CDDBCOPYLOCAL="y"
      CDDBLOCALDIR="$HOME/.cddb"
      CDDBLOCALRECURSIVE="y"
      CDDBUSELOCAL="y"

      # Specify the encoder to use for MP3, or for M4A/AAC. For MP3
      # the alternatives are gogo, bladeenc, l3enc, xingmp3enc, mp3enc. 
      # fdkaac is the best choice for M4A/AAC under native Linux 
      # at the moment.
      ##############################
      # For MP3
      ##############################
      MP3ENCODERSYNTAX=lame 

      ##############################
      # For M4A/AAC
      ##############################
      # AACENCODERSYNTAX=ffmpeg

      # Specify the path to the selected encoder. In most cases the encoder
      # should be in your $PATH as I illustrate below, otherwise you will 
      # need to specify the full path.

      ##############################
      # For MP3
      ##############################
      LAME=lame

      ##############################
      # For M4A/AAC
      ##############################
      # FDKAAC=ffmpeg

      ##############################
      # For MP3
      ##############################
      # For MP3, multiple options can be selected as '--preset standard --another-option' etc.
      # The '-V 2' option gives VBR encoding between 170-210 kbits/s.
      LAMEOPTS='-V 2' 

      ##############################
      # For M4A/AAC
      ##############################
      # For M4A/AAC multiple options can be selected as '--best --another-option' etc.
      # FDKAACENCOPTS='-c:a libfdk_aac -b:a 192k'

      # Output type
      ##############################
      # For MP3
      ##############################
      OUTPUTTYPE="mp3"

      ##############################
      # For M4A/AAC
      ##############################
      # OUTPUTTYPE="m4a"

      # The cd ripping program to use. There are a few choices here: cdda2wav,
      # dagrab, cddafs (Mac OS X only) and flac. New to abcde 2.7 is 'libcdio'.
      CDROMREADERSYNTAX=cdparanoia            
                                           
      # Give the location of the ripping program and pass any extra options,
      # if using libcdio set 'CD_PARANOIA=cd-paranoia'.
      CDPARANOIA=cdparanoia  
      #CDPARANOIAOPTS="--never-skip=40"

      # Give the location of the CD identification program:       
      CDDISCID=cd-discid            
                                     
      # Give the base location here for the encoded music files.
      OUTPUTDIR="$HOME/Music/new-music"

      # The default actions that abcde will take.
      ACTIONS=cddb,playlist,read,encode,tag,move,clean
                    
      # Decide here how you want the tracks labelled for a standard 'single-artist',
      # multi-track encode and also for a multi-track, 'various-artist' encode:
      OUTPUTFORMAT="''${OUTPUT}/''${ARTISTFILE}/''${ALBUMFILE}/''${TRACKNUM} ''${TRACKFILE}"
      VAOUTPUTFORMAT="''${OUTPUT}/Various Artists/''${ALBUMFILE}/''${TRACKNUM} ''${TRACKFILE}"

      # Decide here how you want the tracks labelled for a standard 'single-artist',
      # single-track encode and also for a single-track 'various-artist' encode.
      # (Create a single-track encode with 'abcde -1' from the commandline.)
      ONETRACKOUTPUTFORMAT="''${OUTPUT}/''${ARTISTFILE}/''${TRACKFILE}"
      VAONETRACKOUTPUTFORMAT="''${OUTPUT}/Various Artists/''${ALBUMFILE}/''${TRACKFILE}"

      # Create playlists for single and various-artist encodes. I would suggest
      # commenting these out for single-track encoding.
      #PLAYLISTFORMAT="''${OUTPUT}/''${ARTISTFILE}-''${ALBUMFILE}/''${ALBUMFILE}.m3u"
      #VAPLAYLISTFORMAT="''${OUTPUT}/Various-''${ALBUMFILE}/''${ALBUMFILE}.m3u"

      # This function takes out dots preceding the album name, and removes a grab
      # bag of illegal characters. It allows spaces, if you do not wish spaces add
      # in -e 's/ /_/g' after the first sed command.
      mungefilename ()
      {
        echo "$@" | sed -e 's/^\.*//' | tr -d ":><|*/\"'?[:cntrl:]"
      }

      # What extra options?
      MAXPROCS=2                              # Run a few encoders simultaneously
      PADTRACKS=y                             # Makes tracks 01 02 not 1 2
      EXTRAVERBOSE=2                          # Useful for debugging
      #COMMENT='abcde version 2.7'             # Place a comment...
      #EJECTCD=y                               # Please eject cd when finished :-)
      '';
  };
}
