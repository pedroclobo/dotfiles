{ pkgs, config, lib, ... }:

let
	cfg = config.modules.tmux;
	inherit (lib) mkEnableOption mkIf;
in {
	options.modules.tmux.enable = mkEnableOption "tmux";

	config.hm = mkIf cfg.enable {
		programs.tmux = {
			enable = true;
			baseIndex = 1;
			disableConfirmationPrompt = true;
			keyMode = "vi";
			mouse = true;
			prefix = "C-a";
			historyLimit = 50000;
			escapeTime = 0;
			terminal = "tmux-256color";
			extraConfig = ''
				set-option -sa terminal-overrides ',alacritty:RGB'
			'';
			plugins = with pkgs.tmuxPlugins; [
				resurrect
				{
					plugin = continuum;
					extraConfig = ''
						set -g @continuum-boot 'on'
						set -g @continuum-restore 'on'
					'';
				}
			];
		};
	};
}
