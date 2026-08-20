{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.desktop.greeter;
in
{
  options.my.desktop.greeter = {
    environment = lib.mkOption {
      type = lib.types.enum [
        "grub"
        "systemd"
        "lanzaboote"
      ];
      default = "grub";
    };
  };
}
