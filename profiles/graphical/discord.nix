{
  pkgs,
  ...
}:
let
  settings = {
    openasar = {
      setup = true;
      quickstart = true;
    };
    SKIP_HOST_UPDATE = true;
    MINIMIZE_TO_TRAY = false;
    OPEN_ON_STARTUP = false;
  };
in
{
  hm.home.packages = [
    pkgs.discord
  ];

  hm.xdg.configFile."discord/settings.json".text = builtins.toJSON settings;
}
