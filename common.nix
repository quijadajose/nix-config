{ config, pkgs, ... }: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  time.timeZone = "America/Santiago";
  i18n.defaultLocale = "en_US.UTF-8";
  networking.networkmanager.enable = true;

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb.layout = "us";

  users.users.unknown = {
    isNormalUser = true;
    description = "unknown";
    extraGroups = [ "networkmanager" "wheel" "docker" "podman" ];
    packages = with pkgs; [ helix git vscode ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}

