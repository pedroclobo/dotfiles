{ pkgs, config, lib, ... }:

let
	cfg = config.modules.alacritty;
	inherit (lib) mkEnableOption mkIf;
in {
	options.modules.alacritty.enable = mkEnableOption "alacritty";

	config.hm = mkIf cfg.enable {
		programs.alacritty.enable = true;

		home = {
			file.".config/alacritty/alacritty.yml".text =
				builtins.readFile ./alacritty.yml;
			packages = with pkgs;
				[ (nerdfonts.override { fonts = [ "UbuntuMono" ]; }) ];
		};
	};
}
