{ system, pkgs, home-manager, lib, ... }:

let
	mkHost = { hostname, username }:
		lib.nixosSystem {
			inherit system pkgs;

			modules = [
				{ networking.hostName = hostname; }
				(import ../hosts/${hostname}/configuration.nix {
					inherit pkgs home-manager username;
				})
				../hosts/${hostname}/hardware.nix

				home-manager.nixosModules.home-manager
				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
					};
				}
			];
		};
in { mkHost = mkHost; }
