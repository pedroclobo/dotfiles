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
			];

			home.file.".config/qtile/config.py".text = builtins.readFile ./config.py;
		};

		services.xserver = {
			enable = true;
			windowManager = { qtile = { enable = true; }; };
			layout = "pt";
			xkbVariant = "";
		};
	};
}
