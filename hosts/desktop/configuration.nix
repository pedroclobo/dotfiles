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
		layout = "pt";
		xkbVariant = "";
		enable = true;
		displayManager = {
			autoLogin = {
				enable = true;
				user = "pedro";
			};
			defaultSession = "none+qtile";
			lightdm.enable = true;
			setupCommands = ''
				${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --off --output HDMI-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
			'';
		};
	};

	services.getty = {
		autologinUser = "pedro";
		extraArgs = [
			"--skip-login"
			"--nonewline"
			"--noissue"
			"--noclear"
		];
	};

	# Security
	security.sudo = {
		enable = true;
		wheelNeedsPassword = false;
	};

	# Modules
	modules = {
		alacritty = {
			enable = true;
			fontSize = 14;
			opacity = 0.95;
		};
		docker.enable = true;
		firefox.enable = true;
		git.enable = true;
		gpg.enable = true;
		neovim.enable = true;
		plymouth.enable = true;
		qtile.enable = true;
		scripts = {
			compiler.enable = true;
			opout.enable = true;
			power.enable = true;
			screen-clip.enable = true;
			screen-save.enable = true;
			syncf = {
				enable = true;
				host = "desktop";
			};
			yt-dl.enable = true;
		};
		sxiv.enable = true;
		tmux.enable = true;
		virt-manager.enable = true;
		zathura.enable = true;
		zsh.enable = true;
	};

	# Packages
	environment.systemPackages = with pkgs; [
		android-tools
		discord
		neofetch
		scrcpy
		slack
		unzip
		wget
		zip
	];

	system.stateVersion = "22.11";
}
