{ config, pkgs, lib, ... }:

{
  imports = [
    ./waydroid-networking.nix
  ];
  
  options.waydroid = {
    enable = lib.mkEnableOption "Enable Waydroid (Android in a container)";
    seamless = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Waydroid seamless mode (windowed Android apps)";
    };
    autostartChrome = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Autostart Chrome in Waydroid on login.";
    };
  };

  config = lib.mkIf config.waydroid.enable {
    environment.systemPackages = with pkgs; [ waydroid ];
    
    systemd.services.waydroid-container = {
      description = "Waydroid Android Container";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.waydroid}/bin/waydroid container start";
        Restart = "on-failure";
      };
    };

    # Seamless mode setup
    systemd.services.waydroid-seamless = lib.mkIf config.waydroid.seamless {
      description = "Waydroid Seamless Mode";
      after = [ "waydroid-container.service" ];
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.waydroid}/bin/waydroid session start -s";
        Restart = "on-failure";
      };
    };

    # Autostart Chrome
    systemd.user.services.waydroid-chrome = lib.mkIf config.waydroid.autostartChrome {
      description = "Waydroid Chrome Autostart";
      after = [ "graphical-session.target" ];
      wantedBy = [ "default.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.waydroid}/bin/waydroid app launch com.android.chrome";
        Restart = "on-failure";
      };
    };
  };
}
