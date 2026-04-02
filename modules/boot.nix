{ pkgs, lib, ... }: {
  imports = [
    ./boot/lanzaboote.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Habilitamos systemd-boot por defecto, Lanzaboote lo desactivará si se incluye
  boot.loader.systemd-boot.enable = lib.mkDefault true;
  boot.loader.systemd-boot.configurationLimit = 2;
  
  boot.loader.efi.canTouchEfiVariables = true;
}
