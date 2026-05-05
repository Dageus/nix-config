{ inputs, ... }:
{
  # new ===========================================================

  # imports = [
  #   ./hardware-configuration.nix
  #   ./disks.nix
  # ];

  my.user.name = "jomouzio";
  my.user.fullName = "Jomouzio";
  my.system.hostName = "laptop";

  # old ===========================================================

  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    "${inputs.hardware}/common/cpu/intel/kaby-lake"
    inputs.hardware.nixosModules.common-pc-laptop-ssd
    ./hardware-configuration.nix
    ./disks.nix

    ../../profiles/laptop/sleep.nix

    ../../profiles/hardware/bluetooth.nix
    ../../profiles/hardware/battery.nix
    ../../profiles/hardware/zram.nix

    ../../profiles/editors/nvim.nix

    ../../profiles/system/nix.nix
    ../../profiles/system/audio.nix
    ../../profiles/system/locales.nix
    ../../profiles/system/swappiness.nix
    # ../../profiles/system/nix-helper.nix
    ../../profiles/system/boot/systemd.nix

    ../../profiles/graphical/niri

    ../../profiles/graphical/xdg.nix
    ../../profiles/graphical/stylix.nix
    ../../profiles/graphical/noctalia.nix
    ../../profiles/graphical/file-explorer.nix
    ../../profiles/graphical/vicinae.nix
    ../../profiles/graphical/kitty.nix
    ../../profiles/graphical/firefox.nix

    ../../profiles/greeter/sddm.nix

    ../../profiles/shell/zsh.nix
    ../../profiles/shell/git.nix
    ../../profiles/shell/tmux.nix
    ../../profiles/shell/zoxide.nix
    ../../profiles/shell/utils.nix

    ../../profiles/virtualization/docker.nix
  ];

  boot.initrd.availableKernelModules = [
    "usb_storage"
    "sd_mod"
  ];


  # These are small enough to keep inline, but you could easily
  # move them to a `profiles/hardware/laptop-basics.nix` later.
  networking.networkmanager.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  # DO NOT CHANGE: https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";

  hm.home.stateVersion = "23.05";
}
