{ config, pkgs, ... }: {
  imports = [
    ./networking/doh.nix
    ./networking/vpn.nix
  ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
}