{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.desktop.environment;
in
{
  config = lib.mkIf (cfg.type == "kde") {
    # kde specific settings
  };
}
