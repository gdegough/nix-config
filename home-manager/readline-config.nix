{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".inputrc".text = ''
      $include /etc/inputrc
      # Read enough characters to consume a multi-key sequence instead of inserting stray characters into the editing buffer
      "\e[": skip-csi-sequence
      # Up-arrow for previous matching command
      "\e[A": history-search-backward
      # Down-arrow for next matching command
      "\e[B": history-search-forward
      # Home for beginning of line
      "\e[1~": beginning-of-line
      # End for end of line
      "\e[4~": end-of-line
      # Tab to attempt a completion on the text before point
      "\t": complete
      # Ctrl-right for forward word
      "\e[1;5C": forward-word
      # Ctrl-left for backward word
      "\e[1;5D": backward-word
    '';
  };
}
