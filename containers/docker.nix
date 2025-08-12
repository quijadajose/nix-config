{ config, pkgs, ... }: {
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless.enable = true;

  # Asegura que podman no esté activo cuando usas docker
  virtualisation.podman.enable = false;
}


