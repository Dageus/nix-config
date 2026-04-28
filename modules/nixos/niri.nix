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
  imports = [ inputs.niri.nixosModules.niri ];

  disabledModules = [ "programs/niri.nix" ];

  options.custom.desktop.niri = lib.mkEnableOption "Niri desktop";

  config = mkIf enabled {
    programs.niri = {
      enable = true;
      package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable;
    };
  };
}
