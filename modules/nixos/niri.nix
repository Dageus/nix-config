{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  enabled = config.custom.desktop.niri;
in {
  options.custom.desktop.niri = lib.mkEnableOption "Niri desktop";

  config = mkIf enabled {
    programs.niri.enable = true;
  };
}
