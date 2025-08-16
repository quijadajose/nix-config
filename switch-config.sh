#!/bin/bash

# Script para cambiar entre configuraciones de NixOS

CONFIG=$1

case "$CONFIG" in
  full|work)
    echo "💼 Cambiando a configuración de Trabajo (Completa)..."
    sudo nixos-rebuild switch -p full -I nixos-config=/etc/nixos/configuration.nix
    echo "💼 ¡Configuración de Trabajo aplicada!"
    ;;
  minimal)
    echo "📦 Cambiando a configuración Minimal..."
    sudo nixos-rebuild switch -p minimal -I nixos-config=/etc/nixos/configuration-minimal.nix
    echo "📦 ¡Configuración Minimal aplicada!"
    ;;
  gaming)
    echo "🕹 Cambiando a configuración de Gaming..."
    sudo nixos-rebuild switch -p gaming -I nixos-config=/etc/nixos/configuration-gaming.nix
    echo "🎮 ¡Configuración de Gaming aplicada!"
    ;;
  *)
    echo "❌ Configuración no reconocida: '$CONFIG'"
    echo "ℹ️ Usa: $0 [full | minimal | gaming]"
    ;;
esac

echo "💡 Puedes cambiar entre configuraciones con:"
echo "   $0 full     → configuración de trabajo (completa)"
echo "   $0 minimal  → configuración minimal"
echo "   $0 gaming   → configuración de gaming"
