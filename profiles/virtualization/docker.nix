{ pkgs, config, ... }:
{
  users.users.${config.my.user.name}.extraGroups = [
    "docker"
    "podman"
  ];

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;

      # prune images and containers periodically
      autoPrune = {
        enable = true;
        flags = [ "--all" ];
        dates = "weekly";
      };

      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  environment.systemPackages = [
    pkgs.podman-compose
  ];
}
