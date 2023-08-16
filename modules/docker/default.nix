{ pkgs, config, lib, ... }:

let
  cfg = config.modules.docker;
  inherit (lib) mkEnableOption mkIf;
in {
  options.modules.docker.enable = mkEnableOption "docker";

  config = mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    usr.extraGroups = [ "docker" ];
  };
}
