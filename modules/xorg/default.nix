{ pkgs, config, lib, ... }:

let
  cfg = config.modules.xorg;
  inherit (lib) mkEnableOption mkIf;
in {
  options.modules.xorg.enable = mkEnableOption "xorg";

  config = mkIf cfg.enable {
    services.xserver = {
      layout = "us";
      xkbVariant = "";
      enable = true;
    };

    services.getty = {
      autologinUser = "pedro";
      extraArgs = [ "--skip-login" "--nonewline" "--noissue" "--noclear" ];
    };
  };
}
