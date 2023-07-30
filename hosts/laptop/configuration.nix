{ config, pkgs, home-manager, ... }:

{
	# Bootloader.
	boot.loader.grub.enable = true;
	boot.loader.grub.device = "/dev/sda";
	boot.loader.grub.useOSProber = true;

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
		libinput = {
			enable = true;
			touchpad = {
				middleEmulation = true;
				naturalScrolling = false;
				tapping = false;
			};
		};
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
			fontSize = 12;
			opacity = 0.95;
		};
		docker.enable = true;
		firefox.enable = true;
		git.enable = true;
		gpg.enable = true;
		lightdm = {
			enable = true;
			autoLogin.enable = false;
			defaultSession = "none+xmonad";
		};
		mpv.enable = true;
		scripts = {
			compiler.enable = true;
			opout.enable = true;
			power.enable = true;
			screen-clip.enable = true;
			screen-save.enable = true;
			syncf = {
				enable = true;
				host = "laptop";
			};
			yt-dl.enable = true;
		};
		neovim.enable = true;
		nitrogen.enable = true;
		picom.enable = true;
		qtile.enable = true;
		redshift = {
			enable = true;
			latitude = 38.71;
			longitude = -9.3;
		};
		sxiv.enable = true;
		tmux.enable = true;
		unclutter.enable = true;
		xcape.enable = true;
		xdg = {
			enable = true;
			home = "/home/pedro";
		};
		xorg.enable = true;
		xmonad.enable = true;
		zathura.enable = true;
		zsh.enable = true;
	};

	# Packages
	environment.systemPackages = with pkgs; [
		android-tools
		calc
		discord
		htop
		hyperfine
		neofetch
		pulsemixer
		scrcpy
		slack
		syncthing
		tree
		unzip
		wget
		zip
		zoom-us
	];

	fonts.fonts = with pkgs; [
		(nerdfonts.override { fonts = [ "UbuntuMono" ]; })
	];

	system.stateVersion = "22.11";
}
