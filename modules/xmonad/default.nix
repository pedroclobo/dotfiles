{ pkgs, config, lib, ... }:

let
	cfg = config.modules.xmonad;
	inherit (lib) mkEnableOption mkIf mkOption types;
in {
	options.modules.xmonad = {
		enable = mkEnableOption "xmonad";
	};

	config = mkIf cfg.enable {
		hm = {
			home.packages = with pkgs; [
				(nerdfonts.override { fonts = [ "UbuntuMono" ]; })
				dmenu
				xorg.xset
			];

			programs = {
				xmobar = {
					enable = true;
					extraConfig = builtins.readFile ./xmobar;
				};
			};
		};

		services.xserver.windowManager.xmonad = {
			enable = true;
			enableContribAndExtras = true;
			config = builtins.readFile ./xmonad.hs;
		};
	};
}
