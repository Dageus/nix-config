{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkOption types mkIf;
  cfg = config.my.theme;
in
{
  options.my.theme = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
    mode = mkOption {
      type = types.enum [
        "dark"
        "light"
      ];
      default = "dark";
    };
    # TODO: make it so the user doesn't have to write
    # pkgs.base16-schemes in the future in the host config
    scheme = lib.mkOption {
      type = lib.types.str;
      default = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    };
  };

  config = mkIf cfg.enable {
    stylix.enable = true;
    stylix.polarity = cfg.mode;
    stylix.image = config.my.system.wallpaper;
  };
}
