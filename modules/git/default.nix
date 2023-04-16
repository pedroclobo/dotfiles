{ pkgs, config, lib, ... }:

let
	cfg = config.modules.git;
	inherit (lib) mkEnableOption mkIf;
in {
	options.modules.git.enable = mkEnableOption "git";

	config.hm = mkIf cfg.enable {
		programs.gpg.enable = true;
		programs.git = {
			enable = true;
			aliases = {
				graph = "log --all --graph --decorate --oneline";
			};
			userEmail = "pedrocerqueiralobo@gmail.com";
			userName = "Pedro Lobo";
			extraConfig = {
				init.defaultBranch = "master";
				pull.rebase = true;
			};
			signing = {
				key = "0AFF77833048F8EC";
				signByDefault = true;
			};
		};
	};
}

