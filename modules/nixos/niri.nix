{
  config,
  lib,
  pkgs,
  inputs,
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

    programs.niri = {
      enable = true;
      package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };

    # installing Noctalia here
    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
