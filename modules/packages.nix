{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ 
    unstableSmall.ollama
    qjackctl
    pipewire
    pkgs.pipewire.jack
   ];
}
