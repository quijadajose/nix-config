{ config, pkgs, ... }:
let
  # Importamos sops-nix de forma dinámica para no depender de canales globales
  sops-nix = import (pkgs.fetchTarball {
    url = "https://github.com/Mic92/sops-nix/archive/master.tar.gz";
  });
in {
  imports = [
    sops-nix.nixosModules.sops
  ];

  sops = {
    # El archivo donde guardaremos nuestros secretos (encriptados)
    defaultSopsFile = ../secrets.yaml;
    
    # Usaremos la llave SSH del host para desencriptar. ¡Súper práctico!
    gnupg.sshKeyPaths = [ ]; # Desactivamos GPG para usar SSH pura
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    
    # Definimos el secreto que queremos usar
    secrets.doh_url = {
      # Esto hace que el secreto no sea legible para todos los usuarios
      # owner = "systemd-network"; 
    };

    # Nuevo archivo de WireGuard cifrado por separado
    secrets.pc_conf = {
      sopsFile = ../pc.sops.conf;
      format = "binary";
    };

    # Contraseñas de usuario
    secrets.gaming_password.neededForUsers = true;
    secrets.minimal_password.neededForUsers = true;
  };

  # Agregamos 'sops' a los paquetes del sistema para que puedas editar el archivo
  environment.systemPackages = [ pkgs.sops ];
}
