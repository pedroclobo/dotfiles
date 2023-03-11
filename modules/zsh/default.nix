{ pkgs, config, lib, ... }:

let
	cfg = config.modules.zsh;
	inherit (lib) mkEnableOption mkIf;
in {
	options.modules.zsh.enable = mkEnableOption "zsh";

	config.hm = mkIf cfg.enable {
		programs = {
			zsh = {
				autocd = true;
				enable = true;
				enableAutosuggestions = true;
				enableSyntaxHighlighting = true;
				enableCompletion = true;
				history = {
					ignoreDups = true;
					ignoreSpace = true;
					save = 100000;
					share = true;
				};
				historySubstringSearch.enable = true;
				initExtra = builtins.readFile ./zshrc;
			};
			exa = {
				enable = true;
				enableAliases = true;
			};
		};
	};
}