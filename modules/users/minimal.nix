{ pkgs, ... }: {
  users.users.minimal = {
    isNormalUser = true;
    description = "minimal user";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.nushell;
    packages = with pkgs; [
      nushell
    ];
  };
}


