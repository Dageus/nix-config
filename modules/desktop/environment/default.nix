{ lib, ... }: {

  imports = [
    ./gnome.nix
    ./kde.nix
    ./niri.nix
  ];

  options.my.desktop.environment = {
    type = lib.mkOption {
      type = lib.types.enum [
        "gnome"
        "kde"
        "niri"
        "none"
      ];
      default = "none";
      description = "Desktop Environment/Window Manager implementation to enable.";
    };
  };
}
