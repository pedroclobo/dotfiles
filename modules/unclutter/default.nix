{ pkgs, config, lib, ... }:

let
  cfg = config.modules.unclutter;
  inherit (lib) mkEnableOption mkOption mkIf types;
in {
  options.modules.unclutter.enable = mkEnableOption "unclutter";

  config = mkIf cfg.enable { hm.services.unclutter = { enable = true; }; };
}
