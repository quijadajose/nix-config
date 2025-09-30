{ config, lib, ... }:
{
  options.waydroid.networking.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable Waydroid networking and firewall rules.";
  };

  config = lib.mkIf config.waydroid.networking.enable {
    networking.firewall = {
      enable = true;
      allowedUDPPorts = [ 53 67 8000];
      trustedInterfaces = [ "waydroid0" ];
    };
    networking.firewall.extraCommands = ''
      iptables -P FORWARD ACCEPT
    '';
  };
}
