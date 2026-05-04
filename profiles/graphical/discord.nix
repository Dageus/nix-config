{
  pkgs,
  ...
}:
{
  home-manager.users.jomouzio.home.packages = with pkgs; [
    # Discord
    discord-openasar
  ];
}
