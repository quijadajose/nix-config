{
  description = "Sistema NixOS con múltiples perfiles (Docker y Podman)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: {
    nixosConfigurations = {
      dockerSystem = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hardware-configuration.nix
          ./common.nix
          ./systems/docker.nix
        ];
      };

      podmanSystem = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hardware-configuration.nix
          ./common.nix
          ./systems/podman.nix
        ];
      };
    };
  };
}
