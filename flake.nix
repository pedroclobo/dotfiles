{
	description = "NixOS System Configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, nixpkgs-unstable, home-manager }:
		let
			system = "x86_64-linux";
			username = "pedro";

			inherit (nixpkgs) lib;

			util = import ./lib { inherit system pkgs home-manager lib; };

			pkg-sets = final: prev:
				let
					args = {
						system = system;
						config.allowUnfree = true;
					};
				in
				{ unstable = import nixpkgs-unstable args; };

			pkgs = import nixpkgs {
				inherit system;
				config.allowUnfree = true;
				overlays = util.mkOverlays ./overlays ++ [ pkg-sets ];
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
				laptop = util.mkHost {
					hostname = "laptop";
					username = username;
				};
			};
		};
}
