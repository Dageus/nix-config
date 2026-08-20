{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.boot;
in
{
  options.my.boot = {
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
