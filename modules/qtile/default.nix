{ pkgs, config, lib, ... }:

let
	cfg = config.modules.qtile;
	inherit (lib) mkEnableOption mkIf mkOption types;

	scripts = [
		(pkgs.writeScriptBin "screen-clip" ''
			#!/bin/sh
			# Takes a screenshot and saves it to the clipboard.

			type=$(printf "Full screen\nCurrent window\nSelected area" | dmenu -i -p 'Save to clipboard: ')

			case $type in
				"Full screen") maim | xclip -selection clipboard -t image/png ;;
				"Current window") maim -i "$(xdotool getactivewindow)" | xclip -selection clipboard -t image/png ;;
				"Selected area") maim -s | xclip -selection clipboard -t image/png ;;
				*) ;;
			esac
		'')
		(pkgs.writeScriptBin "screen-save" ''
			#!/bin/sh
			# Takes a screenshot and saves it as a file.

			dir="$HOME/images/screenshot"
			[ ! -d "$dir" ] && mkdir -p "$dir"

			type=$(printf "Full screen\nCurrent window\nSelected area" | dmenu -i -p 'Save to storage: ')

			case $type in
				"Full screen") maim "$dir/""$(date '+%y%m%d-%H%M-%S').png" ;;
				"Current window") maim -i "$(xdotool getactivewindow)" "$dir/""$(date '+%y%m%d-%H%M-%S').png" ;;
				"Selected area") maim -s "$dir/""$(date '+%y%m%d-%H%M-%S').png" ;;
				*) ;;
			esac
		'')
	];

	scriptsPath = lib.strings.concatMapStringsSep ":" (x: "${x}/bin") scripts;

in {
	options.modules.qtile = {
		enable = mkEnableOption "qtile";
		xrandrScript = mkOption {
			type = types.str;
			description = "A xrandr script to be executed on startup";
			default = "";
		};
		powerScript = mkOption {
			type = types.str;
			description = "A script to power down the system";
			default = "";
		};
		autoLogin = mkOption {
			type = types.str;
			description = "Auto login as specified user";
			default = null;
		};
		autoStart = mkOption {
			type = types.bool;
			description = "Auto start";
			default = true;
		};
	};

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

				python310Packages.psutil

				# Scripts
				maim
				xclip
				xdotool
			];

			programs.zsh.initExtra = ''
				[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1 &> /dev/null
			'';

			home.file = {
				".config/qtile/config.py".text = builtins.readFile ./config.py;

				".xinitrc".text = ''
					#!${pkgs.bash}
					$HOME/.xsession
				'';
			};

			xsession = {
				enable = true;
				initExtra = ''
					PATH="$PATH:${scriptsPath}"

					${pkgs.xorg.xrandr}/bin/xrandr ${cfg.xrandrScript}

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

		services.getty = {
			autologinUser = cfg.autoLogin;
			extraArgs = [
				"--skip-login"
				"--nonewline"
				"--noissue"
				"--noclear"
			];
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
