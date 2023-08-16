{ pkgs, config, lib, ... }:

let
  cfg = config.modules.scripts.compiler;
  inherit (lib) mkEnableOption mkIf;

  compiler = pkgs.writeScriptBin "compiler" ''
    file=$(readlink -f "$1")
    dir=$(dirname "$file")
    filename=$(basename "$file" | cut -f 1 -d '.')
    ext=$(basename "$file" | rev | cut -f 1 -d '.' | rev)

    cd "$dir" || exit
    case "$ext" in
        md) pandoc -o "$filename".pdf "$filename".md ;;
    esac
  '';
in {
  options.modules.scripts.compiler.enable = mkEnableOption "scripts.compiler";

  config = mkIf cfg.enable {
    hm.home.packages = with pkgs; [
      compiler
      pandoc
      texlive.combined.scheme-medium
    ];
  };
}
