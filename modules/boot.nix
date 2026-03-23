{ pkgs, lib, ... }:
let
  lanzaboote-src = fetchTarball "https://github.com/nix-community/lanzaboote/archive/master.tar.gz";
  lanzaboote-lib = import lanzaboote-src { inherit pkgs; };
in
{
  imports = [ lanzaboote-lib.nixosModules.lanzaboote ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.systemd-boot.configurationLimit = 2;
  
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };

  boot.loader.efi.canTouchEfiVariables = true;
}
