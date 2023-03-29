{
	description = "NixOS System Configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager }:
		let
			system = "x86_64-linux";
			username = "pedro";

			inherit (nixpkgs) lib;

			util = import ./lib { inherit system pkgs home-manager lib; };

			pkgs = import nixpkgs {
				inherit system;
				config.allowUnfree = true;
				overlays = util.mkOverlays ./overlays;
			};

		in {
			nixosConfigurations = {
				vm = util.mkHost {
					hostname = "vm";
					username = username;
				};
				desktop = util.mkHost {
					hostname = "desktop";
					username = username;
				};
			};
		};
}
