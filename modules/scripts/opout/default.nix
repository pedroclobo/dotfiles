{ pkgs, config, lib, ... }:

let
  cfg = config.modules.scripts.opout;
  inherit (lib) mkEnableOption mkIf;

  opout = pkgs.writeScriptBin "opout" ''
    file=$(readlink -f "$1")
    dir=$(dirname "$file")
    filename=$(basename "$file" | cut -f 1 -d '.')
    ext=$(basename "$file" | rev | cut -f 1 -d '.' | rev)

    echo 'setsid -f zathura "$filename.pdf"'

    case "$ext" in
        tex|md|rmd) setsid -f zathura "$filename.pdf" ;;
    esac
  '';
in {
  options.modules.scripts.opout.enable = mkEnableOption "scripts.opout";

  config = mkIf cfg.enable { hm.home.packages = with pkgs; [ opout zathura ]; };
}
