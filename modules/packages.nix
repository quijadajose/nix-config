{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    unstableSmall.ollama
  ];
}

