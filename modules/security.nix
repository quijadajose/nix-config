{ config, pkgs, ... }: {
  security = {
    apparmor.enable = true;
    auditd.enable = true;

    limits.limits = [
      {
        domain = "gaming";
        type = "hard";
        item = "nproc";
        value = "1000";
      }
      {
        domain = "gaming";
        type = "hard";
        item = "nofile";
        value = "4096";
      }
      {
        domain = "gaming";
        type = "hard";
        item = "memlock";
        value = "67108864";
      }
    ];
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 25565 25575 ];
    allowedUDPPorts = [ 25565 25575 ];
  };

  users.users.gaming.extraGroups =
    [ "lp" "lpadmin" "networkmanager" "audio" "video" "games" "input" ];

  programs.sudo = {
    enable = true;
    wheelNeedsPassword = true;
    extraRules = [ ];
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
}
