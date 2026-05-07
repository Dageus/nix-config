{ pkgs, lib, config, ... }:
let
  colors = config.lib.stylix.colors;
in
{
  stylix = {
    enable = true;

    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/9o/wallhaven-9o8v98.jpg";
      hash = "sha256-Nr6+9gSj3v2ivgk3aE23vK25dZkRR8YrcM2I9zq/n30=";
    };

    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

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

  hm.programs.noctalia-shell.settings = {
    # You will need to check Noctalia's docs for their exact config keys,
    # but the injection looks like this:
    theme = {
      primary_color = "#${colors.base0D}"; # Blue/Accent
      background_color = "#${colors.base00}"; # Main background
      text_color = "#${colors.base05}"; # Main text
    };
  };
}
