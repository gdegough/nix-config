{
  description = "Greg's nix config";

  inputs = {
    ## Nixpkgs
    ## You can access packages and modules from different nixpkgs revs
    ## at the same time. Here are working examples:
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    ## Also see the 'stable-packages' overlay at 'overlays/default.nix'.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    ## Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    ## Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    # home-manager.url = "github:nix-community/home-manager"; # Unstable
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    ## Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";

    ## Shameless plug: looking for a way to nixify your themes and make
    ## everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";

    ## System76 COSMIC alpha packages
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-cosmic,
    ...
  } @ inputs: let
    inherit (self) outputs;
    ## Supported systems for your flake packages, shell, etc.
    systems = [
       "x86_64-linux"
    ];
    ## This is a function that generates an attribute by calling a function you
    ## pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
    system = "x86_64-linux";
  in {
    ## Your custom packages
    ## Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    ## Formatter for your nix files, available through 'nix fmt'
    ## Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    ## Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    ## Reusable nixos modules you might want to export
    ## These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    ## Reusable home-manager modules you might want to export
    ## These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;

    ## NixOS configuration entrypoint
    ## Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      leanangle = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
          }
          nixos-cosmic.nixosModules.default
          ## > Our main nixos configuration file <
          ./nixos/leanangle/configuration.nix
        ];
      };
      lemurpro = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
          }
          nixos-cosmic.nixosModules.default
          ## > Our main nixos configuration file <
          ./nixos/lemurpro/configuration.nix
        ];
      };
      xps13 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ## > Our main nixos configuration file <
          ./nixos/xps13/configuration.nix
        ];
      };
      apex = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ## > Our main nixos configuration file <
          ./nixos/apex/configuration.nix
        ];
      };
    };

    ## Standalone home-manager configuration entrypoint
    ## Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "gmdegoug@leanangle" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system}; ## Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home-manager/leanangle/gmdegoug-home.nix
        ];
      };
      "pdegough@leanangle" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system}; ## Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home-manager/leanangle/pdegough-home.nix
        ];
      };
      "root@leanangle" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system}; ## Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home-manager/leanangle/root-home.nix
        ];
      };
      "gmdegoug@lemurpro" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system}; ## Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home-manager/lemurpro/gmdegoug-home.nix
        ];
      };
      "pdegough@lemurpro" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system}; ## Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home-manager/lemurpro/pdegough-home.nix
        ];
      };
      "root@lemurpro" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system}; ## Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home-manager/lemurpro/root-home.nix
        ];
      };
      "gmdegoug@xps13" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system}; ## Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home-manager/xps13/gmdegoug-home.nix
        ];
      };
      "pdegough@xps13" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system}; ## Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home-manager/xps13/pdegough-home.nix
        ];
      };
      "root@xps13" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system}; ## Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home-manager/xps13/root-home.nix
        ];
      };
      "gmdegoug@apex" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system}; ## Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home-manager/apex/gmdegoug-home.nix
        ];
      };
      "pdegough@apex" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system}; ## Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home-manager/apex/pdegough-home.nix
        ];
      };
      "root@apex" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system}; ## Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home-manager/apex/root-home.nix
        ];
      };
    };
  };
}
