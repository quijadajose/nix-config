{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    (import <home-manager/nixos>)
  ];
  home-manager.users.unknown = import ./home.nix;
}
