{ config, ... }: {
  # Configuración de WireGuard usando el archivo cifrado via SOPS
  networking.wg-quick.interfaces.personal = {
    autostart = true;
    configFile = config.sops.secrets.pc_conf.path;
  };
}
