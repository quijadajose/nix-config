{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Santiago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_CL.UTF-8";
    LC_IDENTIFICATION = "es_CL.UTF-8";
    LC_MEASUREMENT = "es_CL.UTF-8";
    LC_MONETARY = "es_CL.UTF-8";
    LC_NAME = "es_CL.UTF-8";
    LC_NUMERIC = "es_CL.UTF-8";
    LC_PAPER = "es_CL.UTF-8";
    LC_TELEPHONE = "es_CL.UTF-8";
    LC_TIME = "es_CL.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
      hplip # solo si usas impresoras HP
    ];
    browsing = true; # para detectar impresoras en red (Avahi)
  };

  # Enable sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.unknown = {
    isNormalUser = true;
    description = "unknown";
    extraGroups = [
      "lp"
      "lpadmin"
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = with pkgs; [
      helix
      docker
      docker-compose
      obsidian
      openjdk17
      openjdk21
      spotify
      git
      vscode
      postman
      discord
      telegram-desktop
      code-cursor
      prismlauncher
      cloudflare-warp
    ];
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless.enable = true;
  
  programs.firefox.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  environment.systemPackages = with pkgs; [
    tree
  ];

  #networking.firewall.allowedTCPPorts = [ 3000 ];

  xdg.portal.enable = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";
}

