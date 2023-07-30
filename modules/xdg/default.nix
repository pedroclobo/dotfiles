{ pkgs, config, lib, ... }:

let
	cfg = config.modules.xdg;
	inherit (lib) mkEnableOption mkIf mkOption types;
in {
	options.modules.xdg = {
		enable = mkEnableOption "xdg";
		home = mkOption {
			type = with types; nullOr path;
			default = null;
		};
	};

	config.hm = mkIf cfg.enable {
		xdg = {
			enable = true;
			userDirs = {
				enable = true;
				desktop = "${cfg.home}/.desktop";
				documents = "${cfg.home}/dev";
				download = "${cfg.home}/dls";
				music = "${cfg.home}/music";
				pictures = "${cfg.home}/pic";
				publicShare = "${cfg.home}/.public";
				templates = "${cfg.home}/.templates";
				videos = "${cfg.home}/vids";
			};
		};
	};
}
