#!/bin/bash

# Script para cambiar entre configuraciones de NixOS

CONFIG=$1
CURRENT_USER=$(whoami)

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

if [ -z "$CONFIG" ]; then
    print_message $RED "❌ Error: Debes especificar una configuración"
    echo "ℹ️  Uso: $0 [full | minimal | gaming]"
    echo ""
    echo "💡 Configuraciones disponibles:"
    echo "   $0 full     → configuración de trabajo (completa)"
    echo "   $0 minimal  → configuración minimal"
    echo "   $0 gaming   → configuración de gaming"
    exit 1
fi

check_permissions() {
    if sudo -n true 2>/dev/null; then
        return 0
    else
        print_message $YELLOW "⚠️  Verificando permisos de sudo..."
        if sudo -l | grep -q "nixos-rebuild switch"; then
            print_message $GREEN "✅ Permisos verificados correctamente"
            return 0
        else
            print_message $RED "❌ No tienes permisos para cambiar configuraciones de NixOS"
            print_message $YELLOW "💡 Contacta al administrador del sistema"
            exit 1
        fi
    fi
}

# Verificar permisos antes de continuar
check_permissions

print_message $BLUE "🔄 Cambiando configuración de NixOS..."
print_message $YELLOW "👤 Usuario actual: $CURRENT_USER"
print_message $YELLOW "🎯 Configuración objetivo: $CONFIG"

case "$CONFIG" in
  full|work)
    print_message $BLUE "💼 Cambiando a configuración de Trabajo (Completa)..."
    if sudo nixos-rebuild switch -p full -I nixos-config=/etc/nixos/configuration.nix; then
        print_message $GREEN "💼 ¡Configuración de Trabajo aplicada exitosamente!"
    else
        print_message $RED "❌ Error al aplicar la configuración de trabajo"
        exit 1
    fi
    ;;
  minimal)
    print_message $BLUE "📦 Cambiando a configuración Minimal..."
    if sudo nixos-rebuild switch -p minimal -I nixos-config=/etc/nixos/configuration-minimal.nix; then
        print_message $GREEN "📦 ¡Configuración Minimal aplicada exitosamente!"
    else
        print_message $RED "❌ Error al aplicar la configuración minimal"
        exit 1
    fi
    ;;
  gaming)
    print_message $BLUE "🕹 Cambiando a configuración de Gaming..."
    if sudo nixos-rebuild switch -p gaming -I nixos-config=/etc/nixos/configuration-gaming.nix; then
        print_message $GREEN "🎮 ¡Configuración de Gaming aplicada exitosamente!"
    else
        print_message $RED "❌ Error al aplicar la configuración de gaming"
        exit 1
    fi
    ;;
  *)
    print_message $RED "❌ Configuración no reconocida: '$CONFIG'"
    echo "ℹ️  Usa: $0 [full | minimal | gaming]"
    exit 1
    ;;
esac

echo ""
print_message $GREEN "✅ ¡Cambio de configuración completado!"
print_message $BLUE "💡 Puedes cambiar entre configuraciones con:"
echo "   $0 full     → configuración de trabajo (completa)"
echo "   $0 minimal  → configuración minimal"
echo "   $0 gaming   → configuración de gaming"
echo ""
print_message $YELLOW "⚠️  Nota: Algunos cambios pueden requerir reinicio del sistema"
