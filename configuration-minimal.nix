{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./modules/overlays.nix
    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/locale.nix
    ./modules/users/minimal.nix
    # Elige uno Docker o Podman (como comparten el mismo servicio no se pueden usar ambos):
    # ./containers/docker.nix
    ./containers/podman.nix
  ];
  system.nixos.label = "Minimal";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";
}