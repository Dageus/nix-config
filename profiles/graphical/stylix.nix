{
  pkgs,
  lib,
  config,
  ...
}:
let
  colors = config.lib.stylix.colors;
in
{
  stylix = {
    enable = true;

    image = ../../config/wallpapers/izakaya.jpg;

    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";

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

}
