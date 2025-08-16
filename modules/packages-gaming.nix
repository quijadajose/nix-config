{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    firefox
    discord
    telegram-desktop
    # Minecraft Java Edition
    prismlauncher

    # Minecraft Bedrock Edition
    mcpelauncher-ui-qt

    # Herramientas de gaming
    gamemode
    mangohud
    goverlay
    radeontop
    nvtopPackages.full

    # Gestores de juegos y compatibilidad
    lutris
    wine
    winetricks

    # Utilidades
    vulkan-tools
    vulkan-loader
    vulkan-validation-layers
    mesa-demos
  ];
}
