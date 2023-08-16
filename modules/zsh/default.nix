{ pkgs, config, lib, ... }:

let
  cfg = config.modules.zsh;
  inherit (lib) mkEnableOption mkIf;
in {
  options.modules.zsh.enable = mkEnableOption "zsh";

  config = mkIf cfg.enable {
    hm = {
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
          shellAliases = {
            uni = ''
              files=$(find "$HOME/uni" -not -path "*/\.git*" | sort)
              selected=$(echo "$files" | fzf)
              [ "$selected" = "" ] && return
              [ -d "$selected" ] && cd "$selected" || xdg-open "$selected"
            '';
          };
        };
        exa = {
          enable = true;
          enableAliases = true;
        };
        fzf = {
          enable = true;
          enableZshIntegration = true;
          defaultOptions = [ "--layout=reverse" "--height 40%" ];
        };
      };
    };
    usr = { shell = pkgs.zsh; };
    programs.zsh.enable = cfg.enable;
  };
}
