{ pkgs, config, lib, ... }:

let
  cfg = config.modules.syncthing;
  inherit (lib) mkEnableOption mkIf;
in {
  options.modules.syncthing.enable = mkEnableOption "syncthing";

  config.hm = mkIf cfg.enable { services.syncthing.enable = true; };
}
