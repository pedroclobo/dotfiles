{ pkgs, config, lib, ... }:

let
	cfg = config.modules.zathura;
	inherit (lib) mkEnableOption mkIf;
in {
	options.modules.zathura.enable = mkEnableOption "zathura";

	config.hm = mkIf cfg.enable {
		programs.zathura = {
			enable = true;
			extraConfig = ''
				set selection-clipboard clipboard
			'';
		};
	};
}
