{ pkgs, lib, ... }: 
let
  lanzaboote-src = fetchTarball "https://github.com/nix-community/lanzaboote/archive/master.tar.gz";
  lanzaboote-lib = import lanzaboote-src { inherit pkgs; };
in
{
  imports = [ lanzaboote-lib.nixosModules.lanzaboote ];

  # Lanzaboote requiere que systemd-boot esté desactivado
  boot.loader.systemd-boot.enable = lib.mkForce false;
  
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
}
