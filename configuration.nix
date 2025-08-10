{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./modules/overlays.nix
    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/locale.nix
    ./modules/printing.nix
    ./modules/audio.nix
    ./modules/desktop/plasma.nix
    ./modules/programs.nix
    ./modules/hardware-graphics.nix
    ./modules/packages.nix
    ./modules/ollama.nix
    ./modules/virtualbox.nix
    ./modules/virtualbox-compat.nix
    ./modules/users/unknown.nix
    ./systems/docker.nix
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";
}

