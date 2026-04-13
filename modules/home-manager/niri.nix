{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fuzzel
    waybar
  ];

  xdg.configFile."niri/config.kdl".source = ./niri/config.kdl;
  xdg.configFile."swaylock/config".source = ./niri/swaylock.conf;
  xdg.configFile."waybar/config".source = ./waybar/waybar.conf;
  xdg.configFile."waybar/style.css".source = ./waybar/waybar.css;
}
