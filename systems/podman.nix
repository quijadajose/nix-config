
{ config, pkgs, ... }: {
  virtualisation.docker.enable = false;

environment.systemPackages = with pkgs; [ podman-compose ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
}
