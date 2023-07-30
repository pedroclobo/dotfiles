{ pkgs, config, lib, ... }:

let
	cfg = config.modules.picom;
	inherit (lib) mkEnableOption mkOption mkIf types;
in {
	options.modules.picom.enable = mkEnableOption "picom";

	config = mkIf cfg.enable {
		hm.services.picom = {
			enable = true;
		};
	};
}
