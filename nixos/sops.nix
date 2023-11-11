{ 
  inputs
  , config
  , lib
  , pkgs
  , modulesPath
  , ...
}: 
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    gnupg = {
      home = "~/.gnupg";
      sshKeyPaths = [ ];
    };
  };
}
