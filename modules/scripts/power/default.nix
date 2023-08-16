{ pkgs, config, lib, ... }:

let
  cfg = config.modules.scripts.power;
  inherit (lib) mkEnableOption mkIf;

  power = pkgs.writeScriptBin "power" ''
    reboot_menu() {
        choice=$(printf "Linux\nWindows\nFirmware" | dmenu -i -p "Reboot to: ")

        case $choice in
            Linux) systemctl reboot ;;
            Windows) systemctl reboot --boot-loader-entry=auto-windows ;;
            Firmware) systemctl reboot --firmware-setup ;;
            *) ;;
        esac
    }

    choice=$(printf "Shutdown\nReboot\nSuspend" | dmenu -i -p "Power menu: ")

    case $choice in
        Shutdown) systemctl poweroff ;;
        Reboot) reboot_menu ;;
        Hibernate) systemctl hibernate ;;
        Suspend) systemctl suspend ;;
        *) ;;
    esac
  '';
in {
  options.modules.scripts.power.enable = mkEnableOption "scripts.power";

  config = mkIf cfg.enable { hm.home.packages = with pkgs; [ dmenu power ]; };
}
