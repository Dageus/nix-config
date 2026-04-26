{
  config,
  lib,
  ...
}:
{
  xdg.configFile."noctalia/colors.json".source = ./noctalia/colors.json;
  xdg.configFile."noctalia/settings.json".source = ./noctalia/settings.json;
}
