{ pkgs, ... }:
{
  hm.xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  hm.xdg.portal = {
    enable = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];

    config.common.default = "*";
  };
}
