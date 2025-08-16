{ pkgs, ... }: {
  users.users.gaming = {
    shell = pkgs.bash;
    isNormalUser = true;
    description = "Gaming User";

    extraGroups =
      [ "lp" "lpadmin" "networkmanager" "audio" "video" "games" "input" ];

    home = "/home/gaming";
    createHome = true;
    homeMode = "750";

    packages = with pkgs; [
      prismlauncher
      mcpelauncher-ui-qt
      gamemode
      mangohud
      goverlay
      radeontop
      nvtopPackages.full
      lutris
      wine
      winetricks
      vulkan-tools
      vulkan-loader
      vulkan-validation-layers
      mesa-demos
      vscode
      unstableSmall.code-cursor
      git
      firefox
      discord
      telegram-desktop
    ];
  };

  systemd.user.services."gaming@" = {
    serviceConfig = {
      CPUQuota = "200%";
      MemoryMax = "8G";
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

  security.apparmor.policies = {
    "gaming" = {
      enable = true;
      profile = ''
        #include <tunables/global>

        profile gaming flags=(attach_disconnected) {
          #include <abstractions/base>
          #include <abstractions/audio>
          #include <abstractions/games>

          /home/gaming/** rw,
          /tmp/** rw,
          /var/tmp/** rw,

          # solo lectura en sistema
          /etc/** r,
          /usr/lib/** r,
          /usr/share/** r,

          # acceso necesario para juegos
          /dev/dri/* rw,
          /dev/snd/* rw,

          # binarios específicos
          /bin/bash rix,
          /usr/bin/lutris rix,
          /usr/bin/wine* rix,
          /usr/bin/prismlauncher rix,
          /usr/bin/discord rix,
          /usr/bin/telegram-desktop rix,
          /usr/bin/firefox rix,
        }
      '';
    };
  };
}
