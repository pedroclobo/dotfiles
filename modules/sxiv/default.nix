{ pkgs, config, lib, ... }:

let
	cfg = config.modules.sxiv;
	inherit (lib) mkEnableOption mkIf;
in {
	options.modules.sxiv.enable = mkEnableOption "sxiv";

	config = mkIf cfg.enable {
		hm.home = {
			packages = with pkgs; [
				sxiv
			];
		};
	};
}
