{ config, ... }:
{
  hm.programs.nh = {
    enable = true;

    # Automated garbage collection
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep-since 5d --keep 5";
    };

    flake = "/home/${config.my.user.name}/nix-config";
  };
}
