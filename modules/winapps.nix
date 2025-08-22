{ config, pkgs, lib, ... }:

let cfg = config.modules.winapps;
in {
  options.modules.winapps = {
    enable =
      lib.mkEnableOption "Enable WinApps for running Windows applications";
    enableLauncher = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable WinApps Launcher (optional system tray menu)";
    };
  };

  config = lib.mkIf cfg.enable {
    # Add WinApps binary cache for faster downloads
    nix.settings = {
      substituters = [ "https://winapps.cachix.org/" ];
      trusted-public-keys =
        [ "winapps.cachix.org-1:HI82jWrXZsQRar/PChgIx1unmuEsiQMQq+zt05CD36g=" ];
    };

    # Add WinApps to system packages
    environment.systemPackages = with pkgs;
      [
        # WinApps main package
        (import (builtins.fetchTarball
          "https://github.com/winapps-org/winapps/archive/main.tar.gz")).packages."${pkgs.system}".winapps
        # Required dependencies
        curl
        dialog
        freerdp
        git
        iproute2
        libnotify
        netcat-openbsd
        docker-compose
        # Additional dependencies for launcher
        xdg-utils
        adwaita-icon-theme
      ] ++ lib.optionals cfg.enableLauncher [
        # WinApps Launcher (optional)
        (import (builtins.fetchTarball
          "https://github.com/winapps-org/winapps/archive/main.tar.gz")).packages."${pkgs.system}".winapps-launcher
      ];

    # Create WinApps configuration file
    environment.etc."winapps/winapps.conf" = {
      source = pkgs.writeText "winapps.conf" ''
        # WinApps Configuration File
        # Edit this file with your Windows credentials and settings

        # Windows username
        RDP_USER=MyWindowsUser

        # Windows password (required for FreeRDP v3.9.0+)
        RDP_PASS=MyWindowsPassword

        # Windows domain (leave empty for local accounts)
        RDP_DOMAIN=

        # Windows IP address (127.0.0.1 for Docker/Podman)
        RDP_IP=127.0.0.1
        RDP_PORT=3389
        
        # VM name (for libvirt backend)
        VM_NAME=RDPWindows

        # WinApps backend (docker, podman, libvirt, manual)
        WAFLAVOR=docker

        # Display scaling (100, 140, 180)
        RDP_SCALE=100

        # Removable media path
        REMOVABLE_MEDIA=/run/media

        # FreeRDP flags
        RDP_FLAGS=/cert:tofu /sound /microphone +clipboard +home-drive

        # Debug mode
        DEBUG=true

        # Auto-pause Windows (incompatible with docker/manual)
        AUTOPAUSE=off

        # Auto-pause timeout (seconds)
        AUTOPAUSE_TIME=300

        # FreeRDP command (auto-detected if empty)
        FREERDP_COMMAND=

        # Timeouts
        PORT_TIMEOUT=5
        RDP_TIMEOUT=30
        APP_SCAN_TIMEOUT=180
        BOOT_TIMEOUT=120
      '';
      mode = "0600";
    };

    # Create Docker Compose file for WinApps
    environment.etc."winapps/docker-compose.yml" = {
      source = pkgs.writeText "docker-compose.yml" ''
        services:
          winapps:
            image: dockurr/windows
            container_name: WinApps
            environment:
              USERNAME: "MyWindowsUser"
              PASSWORD: "MyWindowsPassword"
              VERSION: "ltsc10"
              RAM_SIZE: "8G"
              CPU_CORES: "4"
              DISK_SIZE: "20G"
            devices:
              - /dev/kvm
            cap_add:
              - NET_ADMIN
            ports:
              - "8006:8006"
              - "3389:3389/tcp"
              - "3389:3389/udp"
            volumes:
              - /home/unknown/shared:/home
              - /media:/media
              - /mnt:/mnt
              - ./data:/storage  
            stop_grace_period: 2m
            restart: on-failure
            shm_size: 2g
      '';
      mode = "0644";
    };

    # Configure systemd user services for WinApps Launcher
    systemd.user.services = lib.mkIf cfg.enableLauncher {
      winapps-launcher = {
        description = "WinApps Launcher";
        wantedBy = [ "graphical-session.target" ];
        partOf = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        environment = {
          DISPLAY = ":0";
          XDG_RUNTIME_DIR = "/run/user/1000";
          XDG_DATA_DIRS = "${pkgs.adwaita-icon-theme}/share:${pkgs.gtk3}/share";
        };
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.lib.getBin (import (builtins.fetchTarball "https://github.com/winapps-org/winapps/archive/main.tar.gz")).packages."${pkgs.system}".winapps-launcher}/bin/winapps-launcher";
          Restart = "on-failure";
          RestartSec = 5;
          StandardOutput = "journal";
          StandardError = "journal";
        };
      };
    };

    # Create autostart entry for WinApps Launcher
    system.activationScripts.winapps-autostart = lib.mkIf cfg.enableLauncher ''
      # Create autostart directory
      mkdir -p /home/unknown/.config/autostart
      chown unknown:users /home/unknown/.config/autostart

      # Create autostart desktop file for WinApps Launcher
      cat > /home/unknown/.config/autostart/winapps-launcher.desktop << 'EOF'
      [Desktop Entry]
      Type=Application
      Name=WinApps Launcher
      Comment=WinApps System Tray Launcher
      Exec=winapps-launcher
      Icon=applications-windows
      Terminal=false
      Categories=System;
      StartupNotify=false
      X-GNOME-Autostart-enabled=true
      EOF

      chown unknown:users /home/unknown/.config/autostart/winapps-launcher.desktop
      chmod 644 /home/unknown/.config/autostart/winapps-launcher.desktop
    '';

    # Create WinApps configuration directory and copy config files
    system.activationScripts.winapps-config = ''
      # Create WinApps config directory and set ownership
      mkdir -p /home/unknown/.config/winapps
      chown unknown:users /home/unknown/.config/winapps

      # Copy config file if it doesn't exist, preserving user changes
      if [ ! -f /home/unknown/.config/winapps/winapps.conf ]; then
        cp /etc/winapps/winapps.conf /home/unknown/.config/winapps/winapps.conf
      fi
      # Always ensure the config file has the correct ownership and permissions
      chown unknown:users /home/unknown/.config/winapps/winapps.conf
      chmod 600 /home/unknown/.config/winapps/winapps.conf

      # Copy docker-compose file if it doesn't exist, preserving user changes
      if [ ! -f /home/unknown/.config/winapps/docker-compose.yml ]; then
        cp /etc/winapps/docker-compose.yml /home/unknown/.config/winapps/docker-compose.yml
      fi
      # Always ensure the docker-compose file has the correct ownership and permissions
      chown unknown:users /home/unknown/.config/winapps/docker-compose.yml
      chmod 644 /home/unknown/.config/winapps/docker-compose.yml

      # Create shared directory for Windows container
      mkdir -p /home/unknown/shared
      chown unknown:users /home/unknown/shared
      chmod 755 /home/unknown/shared

      # Create WinApps data directory
      mkdir -p /home/unknown/.config/winapps/data
      chown unknown:users /home/unknown/.config/winapps/data
      chmod 755 /home/unknown/.config/winapps/data
    '';

  };
}
