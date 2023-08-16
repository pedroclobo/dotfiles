{ pkgs, config, lib, ... }:

let
  cfg = config.modules.virt-manager;
  inherit (lib) mkEnableOption mkIf;
in {
  options.modules.virt-manager.enable = mkEnableOption "virt-manager";

  config = mkIf cfg.enable {
    virtualisation.libvirtd.enable = true;
    programs.dconf.enable = true;
    environment.systemPackages = with pkgs; [ virt-manager ];
    usr.extraGroups = [ "libvirtd" ];
  };
}

