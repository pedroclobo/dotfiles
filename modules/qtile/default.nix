{ pkgs, config, lib, ... }:

let
	cfg = config.modules.qtile;
	inherit (lib) mkEnableOption mkIf mkOption types;
in {
	options.modules.qtile = {
		enable = mkEnableOption "qtile";
	};

	config = mkIf cfg.enable {
		hm = {
			home.packages = with pkgs; [
				dmenu
				(nerdfonts.override { fonts = [ "UbuntuMono" ]; })
				python310Packages.psutil
			];

			home.file = {
				".config/qtile/config.py".text = builtins.readFile ./config.py;
			};
		};
		services.xserver.windowManager.qtile.enable = true;
	};
}
