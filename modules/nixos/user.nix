{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.user;
in
{
  config = {
    users.users.${cfg.name} = {
      isNormalUser = true;
      description = cfg.fullName;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
      shell = pkgs.zsh;
    };
  };
}
