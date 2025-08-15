{ config, pkgs, ... }:

let
  # CAD/CAE utilities
  cadPackages = with pkgs; [
    # Core FreeCAD
    freecad
    
    # FEM solvers
    calculix-ccx
    elmerfem
    
    # Meshing tools
    gmsh
    netgen
    
    # Visualization
    paraview
    
    # Additional tools
    opencascade-occt
    coin3d
  ];
  
in {
  environment.systemPackages = cadPackages;
  
  # Hardware acceleration for graphics
  hardware.graphics.enable = true;
}
