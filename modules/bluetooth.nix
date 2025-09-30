{ config, pkgs, lib, ... }:
{
  options.bluetooth.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable Bluetooth support.";
  };

  config = lib.mkIf config.bluetooth.enable {
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
    environment.systemPackages = with pkgs; [ blueman ];
  };
}
