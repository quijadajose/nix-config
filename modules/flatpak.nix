{ config, pkgs, ... }:

{
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  systemd.services.flatpak-install = {
    wantedBy = [ "multi-user.target" ];
    after = [ "flatpak-repo.service" ];
    path = [ pkgs.flatpak ];
    script = ''
      sleep 5
      # Sober (Roblox launcher)
      flatpak install --noninteractive --assumeyes flathub org.vinegarhq.Sober || true
    '';
  };
}
