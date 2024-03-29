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
        set -g status-left ""
        set -g status-right ""
        bind -T copy-mode-vi v send -X begin-selection
      '';
      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = nord;
          extraConfig = ''
            set -g @nord_tmux_no_patched_font "1"
          '';
        }
        yank
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
