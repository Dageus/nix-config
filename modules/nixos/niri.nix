{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  enabled = config.custom.desktop.niri;
in
{
  options.custom.desktop.niri = lib.mkEnableOption "Niri desktop";

  config = mkIf enabled {
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;

    programs.niri.enable = true;
    programs.waybar.enable = true;
  };
}
