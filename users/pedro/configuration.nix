{ pkgs, home-manager, lib, config, options, ... }:

let
	inherit (lib) mkAliasDefinitions mkOption types;
	username = "pedro";
in {
	options = {
		hm = mkOption { type = types.attrs; };
		usr = mkOption { type = types.attrs; };
	};

	config = {
		home-manager.users.${username} = mkAliasDefinitions options.hm;
		users.users.${username} = mkAliasDefinitions options.usr;

		hm = {
			home = {
				username = username;
				homeDirectory = "/home/${username}";
				stateVersion = config.system.stateVersion;
			};
			programs = { home-manager = { enable = true; }; };
		};

		usr = {
			isNormalUser = true;
			extraGroups = [ "wheel" "vboxsf" ];
		};

		modules = {
			alacritty.enable = true;
			neovim.enable = true;
			qtile.enable = true;
			zsh.enable = true;
		};
	};
}
