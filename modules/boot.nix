{ pkgs, lib, ... }: {
  imports = [
    ./boot/lanzaboote.nix
  ];
  # i remove this because it's not compatible with virtualbox
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxPackages;

  # Habilitamos systemd-boot por defecto, Lanzaboote lo desactivará si se incluye
  boot.loader.systemd-boot.enable = lib.mkDefault true;
  boot.loader.systemd-boot.configurationLimit = 2;
  
  boot.loader.efi.canTouchEfiVariables = true;
}
