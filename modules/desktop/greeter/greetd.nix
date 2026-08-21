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
  config = lib.mkIf (cfg.type == "greetd") {
    # greetd specific settings
  };
}
