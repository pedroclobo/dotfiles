{ pkgs, config, lib, ... }:

let
	cfg = config.modules.xdg;
	inherit (lib) mkEnableOption mkIf mkOption types;
in {
	options.modules.xdg = {
		enable = mkEnableOption "xdg";
		home = mkOption {
			type = with types; nullOr path;
			default = null;
		};
	};

	config.hm = mkIf cfg.enable {
		xdg = {
			enable = true;
			mimeApps = {
				enable = true;
				defaultApplications = {
					"application/epub+zip" = "org.pwmt.zathura-pdf-mupdf.desktop";
					"application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
					"application/json" = "firefox.desktop";
					"image/gif" = "sxiv.desktop";
					"image/jpeg" = "sxiv.desktop";
					"image/jpg" = "sxiv.desktop";
					"image/png" = "sxiv.desktop";
					"text/markdown" = "nvim.desktop";
					"text/x-asm" = "nvim.desktop";
					"text/x-c" = "nvim.desktop";
					"text/x-fortran" = "nvim.desktop";
					"text/x-java-source" = "nvim.desktop";
					"text/x-pascal" = "nvim.desktop";
					"text/x-python" = "nvim.desktop";
					"text/x-shellscript" = "nvim.desktop";
				};
			};
			userDirs = {
				enable = true;
				desktop = "${cfg.home}/.desktop";
				documents = "${cfg.home}/dev";
				download = "${cfg.home}/dls";
				music = "${cfg.home}/music";
				pictures = "${cfg.home}/pic";
				publicShare = "${cfg.home}/.public";
				templates = "${cfg.home}/.templates";
				videos = "${cfg.home}/vids";
			};
		};
	};
}
