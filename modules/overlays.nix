{ ... }:
let
  unstableSmall = import (fetchTarball {
    url =
      "https://github.com/NixOS/nixpkgs/archive/nixos-unstable-small.tar.gz";
  }) { config = { allowUnfree = true; }; };
  unstable = import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
  }) { config = { allowUnfree = true; }; };
in {
  nixpkgs.config.allowUnfree = true;

  # Exponer canales como `pkgs.unstable` y `pkgs.unstableSmall`
  nixpkgs.overlays = [
    (final: prev: {
      unstable = unstable;
      unstableSmall = unstableSmall;
    })
  ];
}

