{ config, pkgs, ... }: {
  security = {
    apparmor.enable = true;
    auditd.enable = true;
  };

  # AppArmor habilitado para seguridad básica
  # Las políticas personalizadas se pueden configurar manualmente después

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 25565 25575 ];
    allowedUDPPorts = [ 25565 25575 ];
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };

  services.journald.extraConfig = ''
    Storage=persistent
    Compress=yes
    MaxRetentionSec=1month
  '';

  services.rsyslogd = {
    enable = true;
    extraConfig = ''
      auth,authpriv.*   /var/log/auth.log
      local0.*          /var/log/system.log
      local1.*          /var/log/security.log
    '';
  };

  # Configuración de seguridad para el servicio gaming
  systemd.user.services."gaming@" = {
    serviceConfig = {
      CPUQuota = "800%";
      MemoryMax = "32G";
      LimitNPROC = 1000;
      LimitNOFILE = 4096;

      DeviceAllow = [
        "/dev/dri/* rw" # video
        "/dev/snd/* rw" # audio
      ];

      CapabilityBoundingSet = [ ];

      ProtectSystem = "strict";
      ProtectHome = "read-only";
      ProtectProc = "invisible";
      ProtectKernelTunables = true;
      ProtectKernelModules = true;
      ProtectKernelLogs = true;
      ProtectControlGroups = true;

      ReadWritePaths = [ "/home/gaming" "/tmp" "/var/tmp" "/run/user/1000" ];

      InaccessiblePaths = [
        "/etc"
        "/var/lib"
        "/usr/lib"
        "/usr/share"
        "/opt"
        "/root"
        "/home/unknown"
        "/home/minimal"
      ];

      PrivateNetwork = false;
      PrivateUsers = true;
      PrivateTmp = true;

      StandardOutput = "journal";
      StandardError = "journal";
      LogLevelMax = "info";
    };
  };

  # Global security measures for Node.js environments
  environment.variables = {
    # Blocks npm and pnpm from executing scripts during installation
    NPM_CONFIG_IGNORE_SCRIPTS = "true";
    # Blocks Yarn Berry (v2+) from executing scripts
    YARN_ENABLE_SCRIPTS = "false";
  };
}
