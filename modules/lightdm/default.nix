{ pkgs, config, lib, ... }:

let
	cfg = config.modules.lightdm;
	inherit (lib) mkEnableOption mkIf mkOption types;
in {
	options.modules.lightdm = {
		enable = mkEnableOption "lightdm";
		autoLogin = mkOption {
			type = types.submodule ({ config, options, ... }: {
				options = {
					enable = mkOption {
						type = with types; bool;
						default = false;
					};
					user = mkOption {
						type = with types; nullOr str;
						default = null;
					};
				};
			});
			default = null;
		};
		defaultSession = mkOption {
			type = with types; nullOr str;
			default = null;
		};
		setupCommands = mkOption {
			type = with types; lines;
			default = "";
		};
	};

	config = mkIf cfg.enable {
		services.xserver = {
			displayManager = {
				autoLogin = {
					enable = cfg.autoLogin.enable;
					user = cfg.autoLogin.user;
				};
				defaultSession = cfg.defaultSession;
				lightdm.enable = true;
				setupCommands = cfg.setupCommands;
			};
		};
	};
}
