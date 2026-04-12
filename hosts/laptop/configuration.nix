{
  inputs,
  pkgs,
  ...
}:
{
  custom = {
    desktop.niri = true;
    docker.enable = true;
    battery.optimise = true;
    flatpak.enable = true;
    login.manager = "sddm";
    # NOTE: too early for this
    # impermanence.enable = true;
    # impermanence.wipeOnBoot = true;
  };

  imports = with inputs.hardware.nixosModules; [
    # Hardware
    common-cpu-intel
    # NOTE: this module is deprecated, planned to be upstreamed to nixpkgs
    # See https://github.com/NixOS/nixos-hardware/issues/992
    "${inputs.hardware}/common/cpu/intel/kaby-lake"
    common-pc-laptop-ssd
    ./hardware-configuration.nix
    ./disks.nix
  ];

  boot.initrd.availableKernelModules = [
    "usb_storage"
    "sd_mod"
  ];

  networking.networkmanager.enable = true;

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
