{ pkgs, config, lib, ... }:

let
  cfg = config.modules.scripts.keyboard;
  inherit (lib) mkEnableOption mkIf;

  keyboard = pkgs.writeScriptBin "keyboard" ''
    choice=$(printf "us\npt" | dmenu -i -p "Choose a keyboard layout: ")

    setxkbmap $choice
  '';
in {
  options.modules.scripts.keyboard.enable = mkEnableOption "scripts.keyboard";

  config.hm =
    mkIf cfg.enable { home.packages = with pkgs; [ dmenu keyboard ]; };
}
