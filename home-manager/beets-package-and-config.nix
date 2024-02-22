{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.beets-unstable
  ];
  home.file = {
    ".config/beets/config.yaml".text = ''
      library: library.db
      directory: /srv/public/Music/music-library
      asciify_paths: yes
      paths:
          default: $albumartist/$album%aunique{}/$track-$title
          singleton: Non-Album/$artist/$title
          comp: Compilations/$album%aunique{}/$track-$title
      import:
          write: yes
          copy: yes
          move: no
          autotag: yes
          incremental: yes
      match:
          preferred:
              countries: ['US', 'CA', 'GB|UK']
              media: ['CD', 'Digital Media|File']
      musicbrainz:
          host: musicbrainz.org
          searchlimit: 10
      ui:
          terminal_width: 164
          color: yes
          colors:
              text_success: green
              text_warning: yellow
              text_error: red
              text_highlight: red
              text_highlight_minor: lightgray
              action_default: turquoise
              action: blue
      replace:
          '[\\/]': '_'
          '^\.': '_'
          '[\x00-\x1f]': '_'
          '[<>:"\?\*\|]': '_'
          '\.$': '_'
          '\s+$': '''
          '^\s+': '''
          ' ': '-'
          '[{}(),\;\!]': '''
          "'": '''
          '\.': '''
          '_-_': '--'
          '-_-': '--'
          '_-': '--'
          '-_': '--'
    '';
  };
}
