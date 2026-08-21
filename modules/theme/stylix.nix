{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.my.theme;

  resolvedScheme =
    if lib.isString cfg.scheme then
      "${pkgs.base16-schemes}/share/themes/${cfg.scheme}.yaml"
    else
      cfg.scheme;
  colors = config.lib.stylix.colors;
in
{
  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      image = config.my.system.wallpaper;
      polarity = cfg.mode;
      base16Scheme = resolvedScheme;

      icons = {
        enable = cfg.icons.enable;
        package = cfg.icons.package;
        dark = cfg.icons.dark;
        light = cfg.icons.light;
      };

      opacity = {
        applications = 0.8;
        terminal = 0.7;
        popups = 0.8;
      };

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 20;
      };

      fonts = {
        serif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Serif";
        };
        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans";
        };
        monospace = {
          package = pkgs.nerd-fonts.iosevka-term;
          name = "IosevkaTerm Nerd Font Mono";
        };
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
        sizes = {
          terminal = 12;
          applications = 11;
        };
      };
    };
  };
}
