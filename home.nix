{ config, pkgs, ... }:

{
  home.username = "unknown";
  home.homeDirectory = "/home/unknown";
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [ "discord" ];
  };
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
    firefox
    vscode
    postman
    rofi
    obconf
    tint2
    lxappearance
    picom
    feh
    xterm
    flameshot
  ];

  programs.bash.enable = true;

  xsession.enable = true;
  home.stateVersion = "24.05";
}
