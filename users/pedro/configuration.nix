{ pkgs, home-manager, lib, config, options, ... }:

let
	inherit (lib) mkAliasDefinitions mkOption types;
	username = "pedro";
in {
	options = { hm = mkOption { type = types.attrs; }; };

	config = {
		home-manager.users.${username} = mkAliasDefinitions options.hm;

		hm = {
			home = {
				username = username;
				homeDirectory = "/home/${username}";
				stateVersion = config.system.stateVersion;
			};
			programs = { home-manager = { enable = true; }; };
		};

		users.users.${username} = {
			isNormalUser = true;
			extraGroups = [ "wheel" ];
		};

		modules = { zsh.enable = true; };
	};
}
