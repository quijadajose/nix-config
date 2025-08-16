{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./modules/overlays.nix
    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/locale.nix
    ./modules/audio.nix
    ./modules/desktop/plasma.nix
    ./modules/programs-gaming.nix
    ./modules/hardware-graphics.nix
    ./modules/packages-gaming.nix
    ./modules/users/gaming.nix
    ./modules/flatpak.nix
  ];

  system.nixos.label = "Gaming";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  powerManagement.cpuFreqGovernor = "performance";

  system.stateVersion = "25.05";
}
