{
  description = "Greg's Nix Config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";
    # sops-nix.url = "github:mic92/sops-nix";
    impermanence.url = "github:nix-community/impermanence";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    nix-colors.url = "github:misterio77/nix-colors";
    nixvim.url = "github:pta2002/nixvim";
    nixneovimplugins.url = "github:jooooscha/nixpkgs-vim-extra-plugins";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: 
  let
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # your hostname
      leanangle = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        # > Our main nixos configuration file <
        modules = [
          ./hosts/leanangle/configuration.nix
        ];
      };
      lemurpro = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        # > Our main nixos configuration file <
        modules = [
          ./hosts/lemurpro/configuration.nix
        ];
      };
      xps13 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        # > Our main nixos configuration file <
        modules = [
          ./hosts/xps13/configuration.nix
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      # your username@hostname
      "gmdegoug@leanangle" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = { inherit inputs outputs; };
        # > Our main home-manager configuration file <
        modules = [
          ./hosts/leanangle/users/gmdegoug-home.nix
        ];
      };
      "gmdegoug@lemurpro" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = { inherit inputs outputs; };
        # > Our main home-manager configuration file <
        modules = [
          ./hosts/lemurpro/users/gmdegoug-home.nix
        ];
      };
      "gmdegoug@xps13" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = { inherit inputs outputs; };
        # > Our main home-manager configuration file <
        modules = [
          ./hosts/xps13/users/gmdegoug-home.nix
        ];
      };
      "pdegough@leanangle" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = { inherit inputs outputs; };
        # > Our main home-manager configuration file <
        modules = [
          ./hosts/leanangle/users/pdegough-home.nix
        ];
      };
      "pdegough@lemurpro" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = { inherit inputs outputs; };
        # > Our main home-manager configuration file <
        modules = [
          ./hosts/lemurpro/users/pdegough-home.nix
        ];
      };
      "pdegough@xps13" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = { inherit inputs outputs; };
        # > Our main home-manager configuration file <
        modules = [
          ./hosts/xps13/users/pdegough-home.nix
        ];
      };
      "root@leanangle" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = { inherit inputs outputs; };
        # > Our main home-manager configuration file <
        modules = [
          ./hosts/leanangle/users/root-home.nix
        ];
      };
      "root@lemurpro" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = { inherit inputs outputs; };
        # > Our main home-manager configuration file <
        modules = [
          ./hosts/lemurpro/users/root-home.nix
        ];
      };
      "root@xps13" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = { inherit inputs outputs; };
        # > Our main home-manager configuration file <
        modules = [
          ./hosts/xps13/users/root-home.nix
        ];
      };
    };
  };
}
