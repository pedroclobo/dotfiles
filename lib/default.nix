{ system, pkgs, home-manager, lib, ... }:

let
	inherit (builtins) concatLists attrValues readDir;
	inherit (lib) mapAttrs hasSuffix;

	mkHost = { hostname, username }:
		lib.nixosSystem {
			inherit system pkgs;

			modules = [
				{ networking.hostName = hostname; }
				../hosts/${hostname}/configuration.nix
				../hosts/${hostname}/hardware.nix
				../users/${username}/configuration.nix

				home-manager.nixosModules.home-manager
				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
					};
				}
			] ++ mkModules ../modules;
		};

	mkOverlays = dir:
		concatLists (attrValues (mapAttrs (name: value:
			if value == "directory" then
				mkOverlays "${dir}/${name}"
			else if value == "regular" && hasSuffix ".nix" name then
				[ (import "${dir}/${name}") ]
			else
				[ ]) (readDir dir)));

	mkModules = dir:
		concatLists (attrValues (mapAttrs (name: value:
			if value == "directory" then
				mkModules "${dir}/${name}"
			else if value == "regular" && hasSuffix ".nix" name then
				[ (import "${dir}/${name}") ]
			else
				[ ]) (readDir dir)));

in {
	mkHost = mkHost;
	mkOverlays = mkOverlays;
	mkModules = mkModules;
}
