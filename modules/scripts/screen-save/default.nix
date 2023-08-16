{ pkgs, config, lib, ... }:

let
  cfg = config.modules.scripts.screen-save;
  inherit (lib) mkEnableOption mkIf;

  screen-save = pkgs.writeScriptBin "screen-save" ''
    dir="$HOME/images/screenshot"
    [ ! -d "$dir" ] && mkdir -p "$dir"

    type=$(printf "Full screen\nCurrent window\nSelected area" | dmenu -i -p 'Save to storage: ')

    case $type in
        "Full screen") maim "$dir/""$(date '+%y%m%d-%H%M-%S').png" ;;
        "Current window") maim -i "$(xdotool getactivewindow)" "$dir/""$(date '+%y%m%d-%H%M-%S').png" ;;
        "Selected area") maim -s "$dir/""$(date '+%y%m%d-%H%M-%S').png" ;;
        *) ;;
    esac
  '';
in {
  options.modules.scripts.screen-save.enable =
    mkEnableOption "scripts.screen-save";

  config = mkIf cfg.enable {
    hm.home.packages = with pkgs; [ dmenu maim screen-save xdotool ];
  };
}
