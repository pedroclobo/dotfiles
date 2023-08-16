{ pkgs, config, lib, ... }:

let
  cfg = config.modules.plymouth;
  inherit (lib) mkEnableOption mkIf;
in {
  options.modules.plymouth.enable = mkEnableOption "plymouth";

  config = mkIf cfg.enable {
    systemd.watchdog.rebootTime = "0";

    boot = {
      plymouth = { enable = true; };
      loader.timeout = 3;
      kernelParams = [
        "quiet"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
      ];
      consoleLogLevel = 0;
      initrd.verbose = false;
    };
  };
}
