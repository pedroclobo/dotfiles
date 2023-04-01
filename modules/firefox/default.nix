{ pkgs, config, lib, ... }:

let
	cfg = config.modules.firefox;
	inherit (lib) mkEnableOption mkIf;
in {
	options.modules.firefox.enable = mkEnableOption "firefox";

	config = mkIf cfg.enable {
		environment.sessionVariables = {
			BROWSER = "firefox";
		};
		hm.programs.firefox = {
			enable = true;
		};
	};
}
