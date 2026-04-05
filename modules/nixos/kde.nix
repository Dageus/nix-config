{
  config,
  lib,
  pkgs,
  ...
}: {
  options.custom.desktop.kde = lib.mkEnableOption "KDE Plasma";

  config = lib.mkIf config.custom.desktop.kde {
    services.desktopManager.plasma6.enable = true;
    # KDE-specific packages
  };
}
