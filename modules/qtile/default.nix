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
			};
		};

		services.xserver = {
			enable = true;
			windowManager = { qtile = { enable = true; }; };
		};
	};
}
