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
  config = lib.mkIf (cfg.type == "lightdm") {
    # lightdm specific settings
  };
}
