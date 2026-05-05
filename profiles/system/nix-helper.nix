{ config, ... }:
{
  programs.nh = {
    enable = true;

    # Automated garbage collection
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep-since 10d --keep 10";
    };

    flake = "/home/${config.my.user.name}/nix-config";
  };
}
