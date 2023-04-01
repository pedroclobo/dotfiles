{ config, pkgs, home-manager, ... }:

{
	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.efi.efiSysMountPoint = "/boot/efi";

	# Locale
	time.timeZone = "Europe/Lisbon";
	i18n.defaultLocale = "en_US.UTF-8";
	i18n.extraLocaleSettings = {
		LC_ADDRESS = "pt_PT.UTF-8";
		LC_IDENTIFICATION = "pt_PT.UTF-8";
		LC_MEASUREMENT = "pt_PT.UTF-8";
		LC_MONETARY = "pt_PT.UTF-8";
		LC_NAME = "pt_PT.UTF-8";
		LC_NUMERIC = "pt_PT.UTF-8";
		LC_PAPER = "pt_PT.UTF-8";
		LC_TELEPHONE = "pt_PT.UTF-8";
		LC_TIME = "pt_PT.UTF-8";
	};

	# Configure console keymap
	console.keyMap = "pt-latin1";

	# Audio
	sound.enable = true;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};

	# Networking
	networking = { networkmanager = { enable = true; }; };
	services = { openssh = { enable = true; }; };

	# Enable nix extra commands
	nix.settings.experimental-features = "nix-command flakes";

	# Xorg
	services.xserver = {
		resolutions = [{
			x = 1920;
			y = 1080;
		}];
	};

	# Security
	security.sudo = {
		enable = true;
		wheelNeedsPassword = false;
	};

	# Modules
	modules = {
		alacritty.enable = true;
		docker.enable = true;
		firefox.enable = true;
		git.enable = true;
		neovim.enable = true;
		qtile = {
			enable = true;
			xrandrScript = ''
				--output eDP-1 --off \
				--output HDMI-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal;
			'';
			powerScript = ''
				#!/bin/sh
				# Perform various power managment actions

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
			autoLogin = "pedro";
		};
		plymouth.enable = true;
		tmux.enable = true;
		zathura.enable = true;
		zsh.enable = true;
	};

	system.stateVersion = "22.11";
}
