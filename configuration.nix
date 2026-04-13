{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./modules/overlays.nix
    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/locale.nix
    ./modules/japanese.nix
    ./modules/printing.nix
    ./modules/audio.nix
    ./modules/desktop/plasma.nix
    ./modules/hardware-graphics.nix
    ./modules/packages.nix
    ./modules/programs.nix
    ./modules/ollama.nix
    #./modules/freecad.nix
     ./modules/virtualbox.nix
     ./modules/virtualbox-compat.nix
    ./modules/users/unknown.nix
    ./containers/docker.nix
    #./modules/waydroid.nix
    ./modules/bluetooth.nix
    ./modules/security.nix
    ./modules/secrets.nix
    ./modules/spectacle-ocr.nix
    ./modules/fastfetch.nix
  ];
  system.nixos.label = "Full";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11";
}

