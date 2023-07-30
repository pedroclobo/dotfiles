{ pkgs, config, lib, ... }:

let
	cfg = config.modules.xcape;
	inherit (lib) mkEnableOption mkIf;
in {
	options.modules.xcape.enable = mkEnableOption "xcape";

	config.hm = mkIf cfg.enable {
		services.xcape = {
			enable = true;
			mapExpression = {
				Caps_Lock = "Escape";
			};
		};

		systemd.user.services.remap_caps = {
			Unit = {
				Description = "Remap CAPS Lock";
				After = [ "graphical-session-pre.target" ];
				PartOf = [ "graphical-session.target" ];
			};
			Service = {
				Type = "oneshot";
				ExecStart = "${pkgs.xorg.setxkbmap}/bin/setxkbmap -option \"caps:ctrl_modifier\"";
			};
			Install = { WantedBy = [ "graphical-session.target" ]; };
		};
	};
}
