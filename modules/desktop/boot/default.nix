{ lib, ... }: {

  imports = [
    ./grub.nix
    ./systemd.nix
    ./landaboote.nix
  ];

  options.my.desktop.boot = {
    type = lib.mkOption {
      type = lib.types.enum [
        "grub"
        "systemd"
        "landaboote"
        "none"
      ];
      default = "none";
      description = "Desktop Environment/Window Manager implementation to enable.";
    };
  };
}
