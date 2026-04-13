{ pkgs, lib, ... }:

let
  # Definimos el tesseract con los idiomas necesarios
  tesseractCustom = pkgs.tesseract.override {
    enableLanguages = [ "eng" "spa" "jpn" ];
  };
in
{
  nixpkgs.overlays = [
    (final: prev: {
      kdePackages = prev.kdePackages.overrideScope (kdeFinal: kdePrev: {
        spectacle = kdePrev.spectacle.overrideAttrs (oldAttrs: {
          # Agregamos tesseract a las dependencias
          buildInputs = (oldAttrs.buildInputs or [ ]) ++ [ tesseractCustom ];
          
          # Forzamos que Spectacle encuentre la librería libtesseract en tiempo de ejecución
          # usando LD_LIBRARY_PATH en el wrapper de Qt
          qtWrapperArgs = (oldAttrs.qtWrapperArgs or [ ]) ++ [
            "--prefix" "LD_LIBRARY_PATH" ":" "${lib.makeLibraryPath [ tesseractCustom ]}"
          ];
        });
      });
    })
  ];

  # Agregamos tesseract al sistema para que el binario y las librerías estén disponibles
  environment.systemPackages = [ tesseractCustom ];

  # Variable necesaria para que Tesseract encuentre sus archivos de datos de idiomas
  environment.variables.TESSDATA_PREFIX = "${tesseractCustom}/share/tessdata";
}
