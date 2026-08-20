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
  options.my.desktop = {
    environment = lib.mkOption {
      type = lib.types.enum [
        "niri"
        "kde"
        "none"
      ];
      default = "none";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf (cfg.environment == "niri") {
      # TODO:
    })
    (lib.mkIf (cfg.environment == "kde") {
      # TODO:
    })
  ];
}
