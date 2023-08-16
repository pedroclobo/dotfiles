{ pkgs, config, lib, ... }:

let
  cfg = config.modules.nitrogen;
  inherit (lib) mkEnableOption mkIf;
in {
  options.modules.nitrogen.enable = mkEnableOption "nitrogen";

  config = mkIf cfg.enable {
    hm = {
      home.packages = with pkgs; [ nitrogen ];

      systemd.user.services.nitrogen = {
        Unit = {
          Description = "Set wallpaper";
          After = [ "graphical-session-pre.target" ];
          PartOf = [ "graphical-session.target" ];
        };
        Service = {
          Type = "oneshot";
          ExecStart = "${pkgs.nitrogen}/bin/nitrogen --restore";
        };
        Install = { WantedBy = [ "graphical-session.target" ]; };
      };
    };
  };
}
