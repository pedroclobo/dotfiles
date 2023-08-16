{ pkgs, config, lib, ... }:

let
  cfg = config.modules.scripts.yt-dl;
  inherit (lib) mkEnableOption mkIf;

  yt-dl = pkgs.writeScriptBin "yt-dl" ''
    while getopts ":a:v" flag; do
        case "$flag" in
            a) yt-dlp -o '%(title)s.%(ext)s' -f bestaudio[ext=m4a] \
                --embed-thumbnail --add-metadata "$2" ;;
            v) yt-dlp -o '%(title)s.%(ext)s' "$2" ;;
            *) exit 1 ;;
        esac
    done
  '';
in {
  options.modules.scripts.yt-dl.enable = mkEnableOption "scripts.yt-dl";

  config = mkIf cfg.enable { hm.home.packages = with pkgs; [ yt-dl yt-dlp ]; };
}
