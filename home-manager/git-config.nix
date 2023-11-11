{
  inputs
  , lib
  , config
  , pkgs
  , ...
}:
#with lib.hm.gvariant;
{
  programs.git = {
    enable = true;
    userName = "gdegough";
    userEmail = "gdegough@gmail.com";
  };
}
