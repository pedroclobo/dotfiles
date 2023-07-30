{ pkgs, config, lib, ... }:

let
	cfg = config.modules.mpv;
	inherit (lib) mkEnableOption mkIf;
in {
	options.modules.mpv.enable = mkEnableOption "mpv";

	config.hm = mkIf cfg.enable {
		programs.mpv.enable = true;
	};
}
