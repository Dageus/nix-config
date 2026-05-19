{ inputs, profiles, ... }:
{
  my.user.name = "jomouzio";
  my.user.fullName = "Jomouzio";
  my.system.hostName = "laptop";

  imports = with profiles; [

    # TODO: we should do something about this being here
    inputs.hardware.nixosModules.common-cpu-intel
    "${inputs.hardware}/common/cpu/intel/kaby-lake"
    inputs.hardware.nixosModules.common-pc-laptop-ssd
    ./hardware-configuration.nix
    ./disks.nix

    laptop.sleep

    hardware.bluetooth
    hardware.battery
    hardware.zram

    editors.nvim

    system.boot.systemd

    system.nix-config
    system.nix-ld
    system.nix-helper
    system.audio
    system.locales
    system.swappiness

    graphical.niri
    graphical.xdg
    graphical.stylix
    graphical.noctalia
    graphical.file-explorer
    graphical.vicinae
    graphical.kitty
    graphical.firefox
    graphical.spotify
    graphical.syncthing
    graphical.discord

    greeter.sddm

    shell.direnv
    shell.git
    shell.nix-index
    shell.tmux
    shell.utils
    shell.zoxide
    shell.zsh

    virtualization.docker

    networking.tailscale
    networking.trust-lan
    networking.networkmanager
  ];

  boot.initrd.availableKernelModules = [
    "usb_storage"
    "sd_mod"
  ];

  # DO NOT CHANGE: https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";

  hm.home.stateVersion = "23.11";
}
