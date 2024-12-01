# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #./swaylock.nix
    ];
    
  # Bootloader.
  #boot = {
  #  kernelParams = ["nihibernate"];
  #  supportedFilesystems = ["ntfs"];
  #  loader = {
  #    efi.canTouchEfiVariables = true;
  #    grub = {
  #      device = "nodev";
  #      efiSupport = true;
  #      enable = true;
  #      useOSProber = true;
  #      timeoutStyle = "menu";
  #    };
  #    timeout = 300;
  #};

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "nvidia-drm.fbdev=1" "nvidia-drm.fbdev=1" ];
  

  hardware = {
    # Enable OpenGL
    #opengl = {
    #  enable = true;
    #  #driSupport = true;
    #  driSupport32Bit = true;
    #};
    graphics.enable = true;
    graphics.enable32Bit = true;
    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      #forceFullCompositionPipeline = false;
      #package = config.boot.kernelPackages.nvidiaPackages.beta;
      #package = (import {}).linuxPackages.nvidiaPackages.latest;
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "555.58";
        sha256_64bit = "sha256-bXvcXkg2kQZuCNKRZM5QoTaTjF4l2TtrsKUvyicj5ew=";
        sha256_aarch64 = "sha256-7XswQwW1iFP4ji5mbRQ6PVEhD4SGWpjUJe1o8zoXYRE=";
        openSha256 = "sha256-hEAmFISMuXm8tbsrB+WiUcEFuSGRNZ37aKWvf0WJ2/c=";
        settingsSha256 = "sha256-vWnrXlBCb3K5uVkDFmJDVq51wrCoqgPF03lSjZOuU8M=";
        persistencedSha256 = "sha256-lyYxDuGDTMdGxX3CaiWUh1IQuQlkI2hPEs5LI20vEVw=";
      };
    };
    #pulseaudio.enable = true;
    #pulseaudio.support32Bit = true;
  

    #opengl.extraPackages = with pkgs; [nvidia-vaapi-driver];
    #opengl.extraPackages32 = with pkgs.pkgsi686Linux; [nvidia-vaapi-driver];
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

    # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking = {
    networkmanager.enable = true;
    networkmanager.insertNameservers = [ "1.1.1.1" "8.8.8.8" ];
    hostName = "kevin_nixos"; # Define your hostname.
    #wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    enableIPv6 = false;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 25565 ];
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Hyprland config
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    VK_DRIVER_FILES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";
  };

  #End Hyprland Config

  services = {
    ratbagd.enable = true;
    # Configure keymap in X11
    xserver = {
      xkb.layout = "de";
      videoDrivers = ["nvidia"];
      enable = true;
    };
    #desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
  };

  # Configure console keymap
  console.keyMap = "de";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kevin = {
    isNormalUser = true;
    description = "kevin";
    extraGroups = [ "networkmanager" "wheel" "audio" "wireshark" "input" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # enabling printig services
  #services.printing.enable = true;
    
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  };
  
  #xdg.portal.enable = true;
  #xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  
  # Enable virtualbox.
  virtualisation.virtualbox.host.enable = true;
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  vulkan-tools
  breeze-icons
  dunst
  libnotify
  swww
  kitty
  rofi-wayland
  networkmanagerapplet
  font-awesome
  wlr-randr
  dxvk
  htop
  vesktop # Discord but better
  gamescope
  xdotool
  cmatrix
  vlc
  ani-cli
  feh # Wallpaper
  pavucontrol # Music control
  keepassxc
  r2modman # Wie Thunder dingsda mods für Lethel Company
  mangohud # Wie MSI Afterburner aber auch FPS Cap
  unzip
  teamspeak5_client
  fastfetch
  headsetcontrol
  #mc # Better File Manager
  jdk21 #Java
  prismlauncher # Minecraft/Curseforge Ersatz
  #piper # Maus Settings
  killall
  termshark
  testdisk
  #rpi-imager
  kitty
  #swaylock
  libreoffice
  wl-clipboard
  rose-pine-cursor
  nwg-look
  glib
  gtk3
  dconf-editor  
  ];

#  home-manager.users.kevin = { pkgs, ... }: {
#  };

  system.stateVersion = "24.05"; # Did you read the comment?

}
