# 🚀 NixOS Multi-Configuration Setup

Este repositorio contiene tres configuraciones diferentes de NixOS para diferentes casos de uso, permitiéndote cambiar dinámicamente entre ellas según tus necesidades.

## 📋 Configuraciones Disponibles

### 🏢 **Full (Completa)** - `configuration.nix`
**Propósito:** Configuración completa para proyectos diarios y trabajo
- **Desktop Environment:** Plasma (KDE)
- **Características:**
  - Herramientas de desarrollo
  - Ollama para LLMs
  - FreeCAD
  - VirtualBox
  - Docker

### ⚡ **Minimal** - `configuration-minimal.nix`
**Propósito:** Configuración minimalista para máximo rendimiento y pruebas de LLMs
- **Características:**
  - Sin entorno de escritorio
  - Solo servicios esenciales
  - Podman para contenedores
  - Configuración optimizada para rendimiento
  - Ideal para servidores o pruebas

### 🎮 **Gaming** - `configuration-gaming.nix`
**Propósito:** Configuración optimizada para gaming con aislamiento
- **Características:**
  - Plasma (KDE)
  - Gobernador de CPU en modo "performance"
  - Flatpak para aplicaciones de gaming
  - Usuario dedicado para gaming

## 🔐 Sistema de Permisos y Usuarios

### 👥 **Usuarios del Sistema:**

#### **👤 Usuario `unknown`**
- **Grupo:** `wheel` (acceso completo a sudo)
- **Puede:** Todo, incluyendo editar archivos de configuración
- **Uso:** Administrador principal del sistema

#### **👤 Usuario `minimal`**
- **Grupo:** `wheel` (acceso completo a sudo)
- **Puede:** Todo, incluyendo editar archivos de configuración
- **Uso:** Usuario para pruebas y desarrollo

#### **🎮 Usuario `gaming`**
- **Grupo:** NO tiene `wheel`
- **Puede:** Solo cambiar configuraciones de NixOS (sin contraseña)
- **NO puede:** Editar archivos de configuración
- **Uso:** Usuario para gaming con aislamiento

### 🔒 **Configuración de Seguridad:**
- **AppArmor** habilitado para aislamiento
- **Firewall** con puertos específicos para gaming
- **Permisos específicos** para usuario gaming
- **Auditoría completa** de cambios

## 🇯🇵 Soporte de Japonés (IME)

Esta configuración incluye **soporte completo para escribir en japonés** con Fcitx5 + Mozc (Google Japanese Input).

### 🎯 **Sistema Instalado:**
- **Fcitx5** - Framework de métodos de entrada (optimizado para KDE Plasma 6 + Wayland)
- **Mozc** - Motor IME japonés (Google Japanese Input)
- **Fuentes japonesas** - Noto Sans/Serif CJK JP, IPA Fonts, Kochi Substitute
- **Locale japonés** - ja_JP.UTF-8 habilitado

### ⌨️ **Atajos de Teclado Útiles:**

#### Activación
- **Ctrl + Space** - Activar/desactivar el modo japonés

#### Conversión
- **Enter** - Confirmar la conversión
- **Escape** - Cancelar y volver al romaji
- **Space** - Siguiente candidato de conversión
- **Shift + Space** - Candidato anterior

#### Transformación de Texto
- **F6** - Convertir a hiragana (ひらがな)
- **F7** - Convertir a katakana (カタカナ)
- **F8** - Convertir a medio-ancho
- **F9** - Convertir a ancho completo romaji
- **F10** - Convertir a medio-ancho romaji

### 📝 **Cómo Usar:**

1. Presiona **Ctrl + Space** para activar el modo japonés
2. Escribe en **romaji**: `konnichiwa`
3. Se convertirá automáticamente a: `こんにちは`
4. Presiona **Enter** para confirmar

## 🔄 Cómo Cambiar Entre Configuraciones

### Método 1: Script Automatizado (Recomendado)

Usa el script `switch-config.sh` que ya tienes configurado:

```bash
# Cambiar a configuración completa (trabajo)
sudo ./switch-config.sh full

# Cambiar a configuración minimal
sudo ./switch-config.sh minimal

# Cambiar a configuración de gaming
sudo ./switch-config.sh gaming
```

**Nota:** Los usuarios `unknown` y `minimal` necesitan contraseña, mientras que `gaming` puede cambiar sin contraseña.

### Método 2: Comandos Manuales

Si prefieres hacerlo manualmente:

```bash
# Configuración Full
sudo nixos-rebuild switch -p full -I nixos-config=/etc/nixos/configuration.nix

# Configuración Minimal
sudo nixos-rebuild switch -p minimal -I nixos-config=/etc/nixos/configuration-minimal.nix

# Configuración Gaming
sudo nixos-rebuild switch -p gaming -I nixos-config=/etc/nixos/configuration-gaming.nix
```

## 📁 Estructura del Proyecto

```
/etc/nixos/
├── configuration.nix          # Configuración Full (trabajo)
├── configuration-minimal.nix  # Configuración Minimal
├── configuration-gaming.nix   # Configuración Gaming
├── hardware-configuration.nix # Configuración de hardware común
├── switch-config.sh          # Script para cambiar configuraciones
├── modules/                  # Módulos reutilizables
│   ├── audio.nix
│   ├── boot.nix
│   ├── desktop/
│   │   └── plasma.nix
│   ├── hardware-graphics.nix
│   ├── networking.nix
│   ├── packages.nix
│   ├── packages-gaming.nix
│   ├── programs.nix
│   ├── programs-gaming.nix
│   ├── security.nix         # Configuración de seguridad centralizada
│   └── users/
│       ├── gaming.nix
│       ├── minimal.nix
│       └── unknown.nix
└── containers/
    ├── docker.nix
    └── podman.nix
```

## 🎯 Casos de Uso Recomendados

### 💼 **Usar Full cuando:**
- Trabajas en proyectos diarios
- Necesitas un entorno de desarrollo completo
- Quieres usar aplicaciones de escritorio
- Necesitas herramientas como FreeCAD, VirtualBox

### ⚡ **Usar Minimal cuando:**
- Quieres máximo rendimiento
- Estás probando LLMs o modelos de IA
- Necesitas un servidor ligero
- Quieres aislar servicios específicos

### 🎮 **Usar Gaming cuando:**
- Quieres jugar videojuegos
- Necesitas aislamiento del entorno de trabajo
- Quieres optimización gráfica
- Necesitas soporte para aplicaciones de gaming


## 🔧 Personalización

Para personalizar cada configuración:

1. **Edita el archivo específico** (`configuration.nix`, `configuration-minimal.nix`, o `configuration-gaming.nix`)
2. **Modifica los módulos** en la carpeta `modules/`
3. **Añade nuevos módulos** según tus necesidades

## 📚 Recursos Adicionales

- [Documentación oficial de NixOS](https://nixos.org/learn.html)
- [NixOS Wiki](https://nixos.wiki/)
- [NixOS Manual](https://nixos.org/manual/nixos/stable)
- [NixOs Pakages](https://search.nixos.org)

---

**💡 Tip:** Usa `nixos-rebuild dry-activate` antes de `switch` para ver qué cambios se aplicarán sin hacerlos efectivos.

**🔒 Seguridad:** El usuario `gaming` está diseñado para aislamiento completo, permitiendo cambios de configuración sin comprometer la integridad del sistema.
