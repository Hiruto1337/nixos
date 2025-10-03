{
  description = "NixOS configuration + Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim";
    walker.url = "github:abenz1267/walker";
  };

  outputs = { self, nixpkgs, home-manager, nixvim, walker }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        ./users.nix
        home-manager.nixosModules.home-manager {
          home-manager.users.lasse_gay = import ./home.nix;
	  home-manager.sharedModules = [
	    nixvim.homeModules.nixvim
	    walker.homeManagerModules.default
	  ];
        }
      ];
    };

    # devShells.x86_64-linux.default = pkgs.mkShell {
      # buildInputs = [
        # 🦀 Rust
        # pkgs.rustc
        # pkgs.cargo
        # pkgs.rust-analyzer

        # 🐫 OCaml
        # pkgs.ocamlPackages.ocaml
        # pkgs.dune_3
        # pkgs.ocamlPackages.ocaml-lsp

        # 🐍 Python
        # pkgs.python3
        # pkgs.python3Packages.pip

        # 🚀 Go
        # pkgs.go

        # 🔧 Common
        # pkgs.git
        # pkgs.gnumake
      # ];
    # };
  };
}
