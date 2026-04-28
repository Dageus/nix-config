{ pkgs, lib, ... }:
{
  stylix = {
    enable = true;

    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/9o/wallhaven-9o8v98.jpg";
      hash = "sha256-Nr6+9gSj3v2ivgk3aE23vK25dZkRR8YrcM2I9zq/n30=";
    };

    polarity = "dark";

    # base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";

    opacity = {
      applications = 0.8; # This usually affects Fuzzel
      terminal = 0.9;
      popups = 0.8;
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
