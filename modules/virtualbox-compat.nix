{ ... }: {
  # Evita conflicto "VERR_VMX_IN_VMX_ROOT_MODE" (KVM vs VirtualBox)
  boot.blacklistedKernelModules =
    [ "kvm" "kvm_intel" "kvm-amd" "kvm_amd" "kvm-intel" ];
}

