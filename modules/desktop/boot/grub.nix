{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.desktop.boot;
in
{
  config = lib.mkIf (cfg.type == "grub") {
    # grub specific settings
  };
}
