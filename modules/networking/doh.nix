{ config, ... }: {
  # Habilitamos systemd-resolved para el manejo de DNS over HTTPS
  services.resolved = {
    enable = true;
  };

  # Vinculamos NetworkManager con resolved
  networking.networkmanager.dns = "systemd-resolved";

  # Inyectamos el secreto en la configuración de resolved de forma segura
  sops.templates."resolved-doh.conf" = {
    content = ''
      [Resolve]
      DNS=${config.sops.placeholder.doh_url}
      DNSOverHTTPS=yes
    '';
  };

  # Hacemos que resolved use nuestro fragmento generado por sops
  environment.etc."systemd/resolved.conf.d/sops-dns.conf".source = config.sops.templates."resolved-doh.conf".path;
}
