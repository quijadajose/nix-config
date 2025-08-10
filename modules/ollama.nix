{ pkgs, ... }: {
  services.ollama = {
    enable = true;
    package = pkgs.unstableSmall.ollama;
  };
}
