{ config, pkgs, ... }: {
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  
  # Habilitamos systemd-resolved para el manejo de DNS over HTTPS
  services.resolved = {
    enable = true;
    # No ponemos la URL aquí, la inyectaremos vía secreto más abajo
  };

  # Vinculamos NetworkManager con resolved
  networking.networkmanager.dns = "systemd-resolved";

  # Inyectamos el secreto en la configuración de resolved de forma segura
  # Esto crea un fragmento de configuración que solo existe en tiempo de ejecución
  sops.templates."resolved-doh.conf" = {
    content = ''
      [Resolve]
      DNS=${config.sops.placeholder.doh_url}
      DNSOverHTTPS=yes
    '';
  };

  # Hacemos que resolved use nuestro fragmento generado por sops
  environment.etc."systemd/resolved.conf.d/sops-dns.conf".source = config.sops.templates."resolved-doh.conf".path;

  # Configuración de WireGuard usando el archivo cifrado
  networking.wg-quick.interfaces.personal = {
    autostart = true;
    configFile = config.sops.secrets.pc_conf.path;
  };
}