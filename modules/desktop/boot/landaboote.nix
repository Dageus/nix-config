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
  config = lib.mkIf (cfg.type == "landaboote") {
    # landaboote specific settings
  };
}
