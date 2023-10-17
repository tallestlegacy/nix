# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      
      # Home manager
      # <home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Nairobi";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
	
  # Enable Flatpak
  services.flatpak.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "gb";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;i

  
  # default shell
  programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.n00b = {
    isNormalUser = true;
    description = "n00b";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      spotify
      obsidian
      vscode
      google-chrome
      cypress
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # garabage collection
  nix.gc.automatic = true;
  nix.gc.dates = "6:00";
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
  
    # system packages
    pkgs.wget
    pkgs.flatpak
    pkgs.git
    pkgs.gnumake
    # home-manager
    pkgs.coreutils-full
    pkgs.ntfs3g

    # desktop
    pkgs.gnome.gnome-tweaks
    pkgs.papirus-icon-theme
    pkgs.papirus-folders
    pkgs.volantes-cursors

    # fonts
    pkgs.nerdfonts
    pkgs.noto-fonts
    pkgs.noto-fonts-emoji
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif

    # programming languages etc
    pkgs.gcc
    pkgs.go
    pkgs.nodejs_16
    pkgs.bun
    pkgs.rustup
    pkgs.dart
    pkgs.flutter
    pkgs.python311
    pkgs.python311Packages.pip
    pkgs.jdk11

    # LSP, formatting etc.
    pkgs.nil                      # nix
    pkgs.gopls                    # go lsp
    pkgs.gofumpt                  # go formatter
    pkgs.goimports-reviser        # go imports
    pkgs.golines                  # go lines formatting
    pkgs.gomodifytags             # go modify tags in template literals
    pkgs.delve                    # go debugger
    pkgs.rust-analyzer            # rust lsp
    pkgs.nodePackages_latest.svelte-language-server
    pkgs.nodePackages_latest.volar
    
    

    # tools
    pkgs.blackbox-terminal
    pkgs.kitty
    pkgs.gh
    pkgs.btop
    pkgs.ripgrep
    pkgs.gparted
    
    # text editors
    pkgs.neovim
    pkgs.helix

    # work, productivity etc
    pkgs.firefox
    pkgs.onlyoffice-bin

    # TODO remove me
    # cypress deps
    pkgs.xorg.libXScrnSaver
    pkgs.xorg.libXdamage
    pkgs.xorg.libX11
    pkgs.xorg.libxcb
    pkgs.xorg.libXcomposite
    pkgs.xorg.libXi
    pkgs.xorg.libXext
    pkgs.xorg.libXfixes
    pkgs.xorg.libXcursor
    pkgs.xorg.libXrender
    pkgs.xorg.libXrandr
    pkgs.mesa
    pkgs.cups
    pkgs.expat
    pkgs.ffmpeg
    pkgs.libdrm
    pkgs.libxkbcommon
    pkgs.at-spi2-atk
    pkgs.at-spi2-core
    pkgs.dbus
    pkgs.gdk-pixbuf
    pkgs.gtk3
    pkgs.cairo
    pkgs.pango
    pkgs.xorg.xauth
    pkgs.glib
    pkgs.nspr
    pkgs.atk
    pkgs.nss
    pkgs.gtk2
    pkgs.alsaLib
    pkgs.gnome2.GConf
    pkgs.unzip
    pkgs.libudev-zero
    # Needed to compile some of the node_modules dependencies from source
    pkgs.autoreconfHook
    pkgs.autoPatchelfHook

  ];

  nixpkgs.config.permittedInsecurePackages = [
    "nodejs-16.20.2"
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}