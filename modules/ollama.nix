{ pkgs, ... }:
{
  services.ollama = {
    enable = true;
    package = pkgs.unstableSmall.ollama;
    loadModels = [ "gpt-oss:20b" ];
  };
}

