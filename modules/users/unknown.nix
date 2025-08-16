{ pkgs, ... }: {
  users.users.unknown = {
    shell = pkgs.nushell;
    isNormalUser = true;
    description = "unknown";
    extraGroups =
      [ "lp" "lpadmin" "networkmanager" "wheel" "docker" "vboxusers" "audio" ];
    packages = with pkgs; [
      oh-my-posh
      unstable.helix
      pkgs.nixpkgs-fmt
      nixfmt
      direnv
      docker
      docker-compose
      unstable.obsidian
      unstable.spotify
      git
      unstable.discord
      unstable.telegram-desktop
      unstableSmall.code-cursor
      sqlitebrowser
      tree
      unstable.vscode
      unstable.postman
    ];
  };
}

