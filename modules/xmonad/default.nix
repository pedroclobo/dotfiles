{ pkgs, config, lib, ... }:

let
	cfg = config.modules.xmonad;
	inherit (lib) mkEnableOption mkIf mkOption types;
in {
	options.modules.xmonad = {
		enable = mkEnableOption "xmonad";
	};

	config = mkIf cfg.enable {
		modules.nitrogen.enable = true;
		hm = {
			home.packages = with pkgs; [
				(nerdfonts.override { fonts = [ "UbuntuMono" ]; })
				dmenu
				picom
				redshift
				unclutter
				xcape
				xorg.setxkbmap
				xorg.xset
			];

			programs = {
				xmobar = {
					enable = true;
					extraConfig = builtins.readFile ./xmobar;
				};
			};

			/* xsession = {
				enable = true;
				initExtra = ''
					# Remap caps to control
					setxkbmap pt -option "caps:ctrl_modifier" &
					xcape -e "Caps_Lock=Escape" &

					nitrogen --restore &        # Set wallpaper
					xset s off -dpms &          # Disable screen timeout
					unclutter &                 # Hide mouse cursor when inactive
					redshift &                  # Night light
					picom &                     # Compositor
				'';
			}; */

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
			windowManager.xmonad = {
				enable = true; 
				enableContribAndExtras = true; 
				config = builtins.readFile ./xmonad.hs;
			};
		};
	};
}
