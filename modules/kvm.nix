{ config, pkgs, ... }:

{
  # Enable KVM virtualization
  virtualisation.libvirtd.enable = true;

  # Enable KVM kernel modules
  boot.kernelModules = [ "kvm-intel" "kvm-amd" ];

  # Add user to libvirt and kvm groups for KVM access
  users.groups.libvirtd.members = [ "unknown" ];
  users.groups.kvm.members = [ "unknown" ];

  # Enable nested virtualization if supported
  boot.extraModprobeConfig = ''
    options kvm_intel nested=1
    options kvm_amd nested=1
  '';
}
