{
  description = "NixOS configuration + Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = { self, nixpkgs, home-manager, nixvim }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        ./users.nix
        home-manager.nixosModules.home-manager {
          home-manager.users.lasse_gay = import ./home.nix;
	  home-manager.sharedModules = [ nixvim.homeManagerModules.nixvim ];
        }
      ];
    };
  };
}
