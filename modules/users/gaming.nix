{ pkgs, ... }: {
  users.users.gaming = {
    shell = pkgs.nushell;
    isNormalUser = true;
    description = "Gaming User";
    extraGroups = [
      "lp"
      "lpadmin"
      "networkmanager"
      "wheel"
      "audio"
      "video"
      "games"
      "input"
    ];

    packages = with pkgs; [
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

      # Utilidades de sistema
      vulkan-tools
      vulkan-loader
      vulkan-validation-layers
      mesa-demos

      # Herramientas adicionales
      vscode
      unstableSmall.code-cursor
      git

      # Navegador y comunicación
      firefox
      discord
      telegram-desktop
    ];
  };
}
