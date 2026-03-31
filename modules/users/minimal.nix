{ config, pkgs, ... }: {
  users.users.minimal = {
    hashedPasswordFile = config.sops.secrets.minimal_password.path;
    isNormalUser = true;
    description = "minimal user";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.nushell;
    packages = with pkgs; [
      nushell
    ];
  };
}


