{ config, pkgs, ... }: {
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless.enable = true;

  # asegúrate de que podman no tenga dockerCompat
  virtualisation.podman.enable = false;
}

