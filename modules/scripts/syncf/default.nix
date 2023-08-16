{ pkgs, config, lib, ... }:

let
  cfg = config.modules.scripts.syncf;
  inherit (lib) mkEnableOption mkIf mkOption types;

  syncf = pkgs.writeScriptBin "syncf" ''
    DESTINATION="${if cfg.host == "desktop" then "laptop" else "desktop"}"

    sync_repos() {
        diff=$(rsync --dry-run --verbose --recursive --update --delete --exclude "dotfiles" "$HOME"/repos $DESTINATION:)
        echo "$diff" | grep "deleting"
        echo ""

        echo "Do you which to continue? "
        read -r answer
        case $answer in
            [Yy]*) rsync --verbose --recursive --update --delete --exclude "dotfiles" "$HOME"/repos $DESTINATION: ;;
            *) exit ;;
        esac
    }

    sync_uni() {
        diff=$(rsync --dry-run --verbose --recursive --update --delete "$HOME"/uni $DESTINATION:)
        echo "$diff" | grep "deleting"
        echo ""

        echo "Do you which to continue? "
        read -r answer
        case $answer in
            [Yy]*) rsync --verbose --recursive --update --delete "$HOME"/uni $DESTINATION: ;;
            *) exit ;;
        esac
    }

    choice=$(printf "repos\nuni" | fzf)

    case $choice in
        repos) sync_repos ;;
        uni) sync_uni ;;
        *) ;;
    esac
  '';
in {
  options.modules.scripts.syncf = {
    enable = mkEnableOption "scripts.syncf";
    host = mkOption {
      type = types.str;
      description = "The destination host";
      default = "";
    };
  };

  config =
    mkIf cfg.enable { hm.home.packages = with pkgs; [ fzf rsync syncf ]; };
}
