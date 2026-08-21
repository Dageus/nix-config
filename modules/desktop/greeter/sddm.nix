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
  config = lib.mkIf (cfg.type == "sddm") {
    # sddm specific settings
  };
}
