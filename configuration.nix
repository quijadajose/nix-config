{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./home-manager.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_6_14;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Santiago";

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

  services.xserver = {
    enable = true;

    layout = "us";

    windowManager.openbox.enable = true;

    displayManager = {
      lightdm.enable = true;
      defaultSession = "none+openbox";
    };
  };

  services.libinput = {
    enable = true;
    touchpad = {
      tapping = true;
      naturalScrolling = true;
    };
    mouse.naturalScrolling = false;
  };

  users.users.unknown = {
    isNormalUser = true;
    description = "unknown";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.pathsToLink = [ "/libexec" ];

  system.stateVersion = "24.11";
}