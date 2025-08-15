{ pkgs, ... }: {
  users.users.unknown = {
    shell = pkgs.nushell;
    isNormalUser = true;
    description = "unknown";
    extraGroups =
      [ "lp" "lpadmin" "networkmanager" "wheel" "docker" "vboxusers" "audio" ];
    packages = with pkgs; [
      asciinema
      oh-my-posh
      unstable.helix
      pkgs.nixpkgs-fmt
      nixfmt
      direnv
      docker
      docker-compose
      unstable.obsidian
      openjdk17
      openjdk21
      unstable.spotify
      git
      unstable.discord
      unstable.telegram-desktop
      unstableSmall.code-cursor
      prismlauncher
      cloudflare-warp
      sqlitebrowser
      tree
      unstable.vscode
      unstable.postman
    ];
  };
}

