{ config, pkgs, ... }: {
  # Configuración de Fcitx5 para japonés en Wayland (KDE Plasma 6)
  # Fcitx5 es la solución recomendada para Wayland, especialmente con KDE
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      # Mozc - IME japonés moderno y preciso (Google Japanese Input)
      fcitx5-mozc
      # Interfaz gráfica de configuración
      fcitx5-configtool
      # Tema GTK
      fcitx5-gtk
    ];
  };

  # Variables de entorno para Fcitx5
  # IMPORTANTE: En Wayland con KDE Plasma 6, NO usar GTK_IM_MODULE ni QT_IM_MODULE
  # KDE Plasma 6 maneja Fcitx5 nativamente a través de la configuración de "Virtual Keyboard"
  environment.sessionVariables = {
    # Solo configurar estas variables si es necesario para aplicaciones específicas
    # En Wayland, KDE Plasma 6 las maneja automáticamente
    XMODIFIERS = "@im=fcitx";
  };

  # Configuración declarativa de Fcitx5 para todos los usuarios
  # Esto hace que la configuración sea reproducible y no requiera configuración manual
  environment.etc."xdg/fcitx5/profile".text = ''
    [Groups/0]
    # Group Name
    Name=Default
    # Layout
    Default Layout=us
    # Default Input Method
    DefaultIM=keyboard-us

    [Groups/0/Items/0]
    # Name
    Name=keyboard-us
    # Layout
    Layout=

    [Groups/0/Items/1]
    # Name
    Name=mozc
    # Layout
    Layout=

    [GroupOrder]
    0=Default
  '';

  # Configuración de atajos de teclado para Fcitx5
  environment.etc."xdg/fcitx5/config".text = ''
    [Hotkey]
    # Enumerate when press trigger key repeatedly
    EnumerateWithTriggerKeys=True
    # Temporally switch between first and current Input Method
    AltTriggerKeys=
    # Enumerate Input Method Forward
    EnumerateForwardKeys=
    # Enumerate Input Method Backward
    EnumerateBackwardKeys=
    # Skip first input method while enumerating
    EnumerateSkipFirst=False
    # Enumerate Input Method Group Forward
    EnumerateGroupForwardKeys=
    # Enumerate Input Method Group Backward
    EnumerateGroupBackwardKeys=
    # Activate Input Method
    ActivateKeys=
    # Deactivate Input Method
    DeactivateKeys=
    # Toggle embedded preedit
    PreeditEnabledByDefault=True

    [Hotkey/TriggerKeys]
    0=Control+space
    1=Zenkaku_Hankaku
    2=Hangul

    [Behavior]
    # Active By Default
    ActiveByDefault=False
    # Share Input State
    ShareInputState=No
    # Show preedit in application
    PreeditEnabledByDefault=True
    # Show Input Method Information when switch input method
    ShowInputMethodInformation=True
    # Show Input Method Information when changing focus
    showInputMethodInformationWhenFocusIn=False
    # Show compact input method information
    CompactInputMethodInformation=True
    # Show first input method information
    ShowFirstInputMethodInformation=True
    # Default page size
    DefaultPageSize=5
    # Override Xkb Option
    OverrideXkbOption=False
    # Custom Xkb Option
    CustomXkbOption=
    # Force Enabled Addons
    EnabledAddons=
    # Force Disabled Addons
    DisabledAddons=
    # Preload input method to be used by default
    PreloadInputMethod=True
  '';

  # Paquetes necesarios para japonés
  environment.systemPackages = with pkgs; [
    # Fuentes japonesas
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    ipafont
    kochi-substitute
    
    # Los paquetes de Fcitx5 se instalan automáticamente con i18n.inputMethod
  ];

  # Configuración de fuentes para mejor soporte de caracteres japoneses
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      ipafont
      kochi-substitute
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif CJK JP" "DejaVu Serif" ];
        sansSerif = [ "Noto Sans CJK JP" "DejaVu Sans" ];
        monospace = [ "Noto Sans Mono CJK JP" "DejaVu Sans Mono" ];
      };
    };
  };
}
