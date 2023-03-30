{ pkgs, config, lib, ... }:

let
	cfg = config.modules.qtile;
	inherit (lib) mkEnableOption mkIf;
in {
	options.modules.qtile.enable = mkEnableOption "qtile";

	config = mkIf cfg.enable {
		hm = {
			home.packages = with pkgs; [
				dmenu
				(nerdfonts.override { fonts = [ "UbuntuMono" ]; })
				nitrogen
				picom
				redshift
				unclutter
				xcape
				xorg.xset
				xorg.setxkbmap
			];

			home.file = {
				".config/qtile/config.py".text = builtins.readFile ./config.py;

				".xinitrc".text = ''
					#!/bin/sh

					# Remap caps to control
					setxkbmap pt -option "caps:ctrl_modifier" &
					xcape -e "Caps_Lock=Escape" &

					nitrogen --restore &        # Set wallpaper
					xset s off -dpms &          # Disable screen timeout
					unclutter &                 # Hide mouse cursor when inactive
					redshift &                  # Night light
					picom &                     # Compositor

					qtile start
				'';
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
			autorun = true;
			displayManager.startx.enable = true;
			windowManager = { qtile = { enable = true; }; };
			layout = "pt";
			xkbVariant = "";
		};
	};
}
