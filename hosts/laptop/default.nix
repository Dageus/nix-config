{
  inputs,
  profiles,
  pkgs,
  ...
}:
{
  # === Configuration of host ==================================================

  my = {
    user.name = "jomouzio";
    user.fullName = "Jomouzio";
    system.hostName = "laptop";

    system.type = "laptop";
    system.wallpaper = ../../config/wallpapers/Sekiro.png;
    system.profile = ../../config/profile/kisuke_urahara.jpg;

    hardware.cpu.vendor = "intel";

    power.backend = "power-profiles-daemon";

    # DE/WM definition is now a module, not a toggle profile
    # my.desktop.environment = "niri";

    # my.desktop.greeter = {
    # type = "sddm";
    # theme = "silentSDDM";
    # image = config.my.system.wallpaper;
    # };

    # my.desktop.boot = {
    # type = "grub";
    # theme = "yorha";
    # };

    secrets.sops = {
      enable = true;
    };

    # theme
    theme = {
      enable = true;
    };
  };

  # === Features of host =======================================================

  services.power-profiles-daemon.enable = true;

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
    hardware.zram

    editors.nvim

    system.boot.grub

    system.nix-ld
    system.nix-helper
    system.audio
    system.locales
    system.swappiness

    services.ssh
    services.syncthing

    graphical.xdg
    graphical.file-explorer.thunar
    graphical.niri
    graphical.noctalia
    graphical.vicinae
    graphical.kitty
    graphical.firefox
    graphical.spotify
    graphical.discord
    graphical.mpv
    graphical.obs
    graphical.obsidian

    greeter.sddm

    security.gpg

    shell.direnv
    shell.fastfetch
    shell.git
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
    claude-code
  ];

  boot.initrd.availableKernelModules = [
    "usb_storage"
    "sd_mod"
  ];

  # DO NOT CHANGE: https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
