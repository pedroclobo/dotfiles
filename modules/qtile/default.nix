{ pkgs, config, lib, ... }:

let
	cfg = config.modules.qtile;
	inherit (lib) mkEnableOption mkIf mkOption types;
in {
	options.modules.qtile = {
		enable = mkEnableOption "qtile";
	};

	config = mkIf cfg.enable {
		modules.nitrogen.enable = true;
		hm = {
			home.packages = with pkgs; [
				dmenu
				(nerdfonts.override { fonts = [ "UbuntuMono" ]; })
				picom
				redshift
				unclutter
				xcape
				xorg.xset
				xorg.setxkbmap

				python310Packages.psutil
			];

			home.file = {
				".config/qtile/config.py".text = builtins.readFile ./config.py;
			};

			services = {
				picom = {
					enable = true;
				};
				redshift = {
					enable = true;
					provider = "manual";
					latitude = 38.71;
					longitude = -9.3;
					temperature = {
						day = 6500;
						night = 3400;
					};
				};
			};
		};

		services.xserver = {
			enable = true;
			windowManager = { qtile = { enable = true; }; };
		};
	};
}
