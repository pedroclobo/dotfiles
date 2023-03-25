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
				unclutter
				xcape
				xorg.xset
			];

			home.file = {
				".config/qtile/config.py".text = builtins.readFile ./config.py;

				".xinitrc".text = ''
					#!/bin/sh

					# Remap caps to control
					xcape -e "Caps_Lock=Escape" &

					nitrogen --restore &        # Set wallpaper
					xset s off -dpms &          # Disable screen timeout
					unclutter &                 # Hide mouse cursor when inactive

					qtile start
				'';
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
