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

    system.nix
    system.audio
    system.locales
    system.swappiness
    networking.tailscale
    system.boot.systemd # Notice how rakeLeaves handles sub-folders perfectly!

    graphical.niri
    graphical.xdg
    graphical.stylix
    graphical.noctalia
    graphical.file-explorer
    graphical.vicinae
    graphical.kitty
    graphical.firefox

    greeter.sddm

    shell.zsh
    shell.git
    shell.tmux
    shell.zoxide
    shell.utils

    virtualization.docker
  ];

  boot.initrd.availableKernelModules = [
    "usb_storage"
    "sd_mod"
  ];

  # TODO: these should be in a common profile or somewhere NOT here
  networking.networkmanager.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  # DO NOT CHANGE: https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";

  hm.home.stateVersion = "23.05";
}
