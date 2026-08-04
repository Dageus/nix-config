{
  inputs,
  profiles,
  pkgs,
  ...
}:
{
  my.user.name = "jomouzio";
  my.user.fullName = "Jomouzio";
  my.system.hostName = "desktop";

  my.secrets.sops = {
    enable = true;
  };

  imports = with profiles; [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-laptop-ssd
    "${inputs.hardware}/common/cpu/intel/kaby-lake"
    ./hardware-configuration.nix
    ./disks.nix
    ./home.nix

    # Profiles =================================================================

    laptop.sleep

    hardware.bluetooth
    hardware.battery
    hardware.zram

    editors.nvim

    system.boot.grub

    system.nix-config
    system.nix-ld
    system.nix-helper
    system.audio
    system.locales
    system.swappiness

    services.ssh

    games.steam
    games.launchers
    games.emulators

    graphical.niri
    graphical.xdg
    graphical.stylix
    graphical.file-explorer
    graphical.noctalia
    graphical.vicinae
    graphical.kitty
    graphical.firefox
    graphical.spotify
    # graphical.syncthing
    graphical.discord
    graphical.mpv
    graphical.obs

    greeter.sddm

    shell.direnv
    shell.fastfetch
    shell.git
    shell.gpg
    shell.nix-index
    shell.tmux
    shell.utils
    shell.yazi
    shell.zoxide
    shell.zsh

    virtualization.docker

    networking.tailscale
    networking.trust-lan
    networking.networkmanager
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
  ];

  hm.home.packages = with pkgs; [
    arandr
    ani-cli
    stremio-linux-shell
  ];

  boot.initrd.availableKernelModules = [
    "usb_storage"
    "sd_mod"
  ];

  # DO NOT CHANGE: https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
