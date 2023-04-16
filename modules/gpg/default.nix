{ pkgs, config, lib, ... }:

let
	cfg = config.modules.gpg;
	inherit (lib) mkEnableOption mkIf;
in {
	options.modules.gpg.enable = mkEnableOption "gpg";

	config = mkIf cfg.enable {
		hm = {
			programs = {
				gpg = {
					enable = true;
				};
			};
			services = {
				gpg-agent = {
					enable = true;
				};
			};

		};
	};
}
