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
}
