{ pkgs, config, lib, ... }:

let
  cfg = config.modules.redshift;
  inherit (lib) mkEnableOption mkOption mkIf types;
in {
  options.modules.redshift = {
    enable = mkEnableOption "redshift";
    latitude = mkOption {
      type = with types; nullOr (either str float);
      description = ''
        Your current latitude, between `-90.0` and
        `90.0`. Must be provided along with
        longitude.
      '';
      default = null;
    };
    longitude = mkOption {
      type = with types; nullOr (either str float);
      description = ''
        Your current longitude, between `-180.0` and
        `180.0`. Must be provided along with
        latitude.
      '';
      default = null;
    };
    temperature = {
      day = mkOption {
        type = types.int;
        default = 6500;
        description = ''
          Colour temperature to use during the day, between
          `1000` and `25000` K.
        '';
      };
      night = mkOption {
        type = types.int;
        default = 3400;
        description = ''
          Colour temperature to use at night, between
          `1000` and `25000` K.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    hm.services.redshift = {
      enable = true;
      provider = "manual";
      latitude = cfg.latitude;
      longitude = cfg.longitude;
      temperature = cfg.temperature;
    };
  };
}
