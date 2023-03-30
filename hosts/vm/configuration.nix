{ config, pkgs, home-manager, ... }:

{
	# Bootloader.
	boot.loader.grub = {
		enable = true;
		device = "/dev/sda";
	};

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

	# Enable VirtualBox guest tools
	virtualisation.virtualbox.guest.enable = true;
	virtualisation.virtualbox.guest.x11 = true;

	# Xorg
	services.xserver = {
		resolutions = [{
			x = 1920;
			y = 1080;
		}];
	};

	# Modules
	modules = {
		alacritty.enable = true;
		neovim.enable = true;
		qtile.enable = true;
		tmux.enable = true;
		zsh.enable = true;
	};

	system.stateVersion = "22.11";
}
