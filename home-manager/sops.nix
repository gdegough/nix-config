{
  inputs
  , lib
  , config
  , pkgs
  , ...
}:
#with lib.hm.gvariant;
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

#  sops = {
#    gnupg = {
#      home = "~/.gnupg";
#      sshKeyPaths = [ ];
#    };
#  };

  home.packages = with pkgs; [
    sops
  ];
}
