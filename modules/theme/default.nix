{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkOption types;
in
{
  imports = [ ./stylix.nix ];

  options.my.theme = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable centralized system theming.";
    };

    mode = mkOption {
      type = types.enum [
        "dark"
        "light"
      ];
      default = "dark";
      description = "Theme polarity.";
    };

    scheme = mkOption {
      type = types.either types.str (types.either types.path types.attrs);
      default = "gruvbox-dark-medium";
      example = "kanagawa-dragon";
      description = "Base16 scheme name from base16-schemes, or a direct file path / attrset.";
    };

    cursor = {
      package = mkOption {
        type = types.package;
        default = pkgs.bibata-cursors;
        description = "Cursor theme package.";
      };
      name = mkOption {
        type = types.str;
        default = "Bibata-Modern-Ice";
        description = "Cursor theme name.";
      };
      size = mkOption {
        type = types.int;
        default = 20;
        description = "Cursor size in pixels.";
      };
    };

    icons = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Whether to manage icon themes via stylix.";
      };
      package = mkOption {
        type = types.package;
        default = pkgs.papirus-icon-theme;
        description = "Icon theme package.";
      };
      dark = mkOption {
        type = types.str;
        default = "Papirus-Dark";
      };
      light = mkOption {
        type = types.str;
        default = "Papirus-Light";
      };
    };
  };
}
