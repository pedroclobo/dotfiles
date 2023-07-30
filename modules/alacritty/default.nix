{ pkgs, config, lib, ... }:

let
	cfg = config.modules.alacritty;
	inherit (lib) mkEnableOption mkIf mkOption types;
in {
	options.modules.alacritty = {
		enable = mkEnableOption "alacritty";
		fontSize = mkOption {
			type = types.number;
			description = "Font size";
			default = 14;
		};
		opacity = mkOption {
			type = types.float;
			description = "Terminal opacity";
			default = 1.0;
		};
	};

	config = mkIf cfg.enable {
		environment.sessionVariables = {
			TERMINAL = "alacritty";
		};
		hm = {
			programs.alacritty = {
				enable = true;
				settings = {
					window = {
						opacity = cfg.opacity;
						padding = {
							x = 10;
							y = 10;
						};
					};
					font = {
						normal = {
							family = "UbuntuMono Nerd Font";
							style = "Regular";
						};
						size = cfg.fontSize;
					};
					colors = {
						primary = {
							background = "#2e3440";
							foreground = "#d8dee9";
							dim_foreground = "#a5abb6";
						};
						cursor = {
							text = "#2e3440";
							cursor = "#d8dee9";
						};
						vi_mode_cursor = {
							text = "#2e3440";
							cursor = "#d8dee9";
						};
						selection = {
							text = "CellForeground";
							background = "#4c566a";
						};
						search = {
							matches = {
							foreground = "CellBackground";
							background = "#88c0d0";
							};
							footer_bar = {
							background = "#434c5e";
							foreground = "#d8dee9";
							};
						};
						normal = {
							black = "#3b4252";
							red = "#bf616a";
							green = "#a3be8c";
							yellow = "#ebcb8b";
							blue = "#81a1c1";
							magenta = "#b48ead";
							cyan = "#88c0d0";
							white = "#e5e9f0";
						};
						bright = {
							black = "#4c566a";
							red = "#bf616a";
							green = "#a3be8c";
							yellow = "#ebcb8b";
							blue = "#81a1c1";
							magenta = "#b48ead";
							cyan = "#8fbcbb";
							white = "#eceff4";
						};
						dim = {
							black = "#373e4d";
							red = "#94545d";
							green = "#809575";
							yellow = "#b29e75";
							blue = "#68809a";
							magenta = "#8c738c";
							cyan = "#6d96a5";
							white = "#aeb3bb";
						};
					};
				};
			};
		};
	};
}
