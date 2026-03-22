{ pkgs, lib, ... }:
let
  # Importamos lanzaboote desde GitHub
  lanzaboote = import (fetchTarball "https://github.com/nix-community/lanzaboote/archive/v0.4.2.tar.gz");
in
{
  imports = [ lanzaboote.nixosModules.lanzaboote ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # IMPORTANTE: Desactivamos el systemd-boot normal
  boot.loader.systemd-boot.enable = lib.mkForce false;
  
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };

  boot.loader.efi.canTouchEfiVariables = true;
}


