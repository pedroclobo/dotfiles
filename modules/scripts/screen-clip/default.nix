{ pkgs, config, lib, ... }:

let
  cfg = config.modules.scripts.screen-clip;
  inherit (lib) mkEnableOption mkIf;

  screen-clip = pkgs.writeScriptBin "screen-clip" ''
    type=$(printf "Full screen\nCurrent window\nSelected area" | dmenu -i -p 'Save to clipboard: ')

    case $type in
        "Full screen") maim | xclip -selection clipboard -t image/png ;;
        "Current window") maim -i "$(xdotool getactivewindow)" | xclip -selection clipboard -t image/png ;;
        "Selected area") maim -s | xclip -selection clipboard -t image/png ;;
        *) ;;
    esac
  '';
in {
  options.modules.scripts.screen-clip.enable =
    mkEnableOption "scripts.screen-clip";

  config = mkIf cfg.enable {
    hm.home.packages = with pkgs; [ dmenu maim screen-clip xclip xdotool ];
  };
}
