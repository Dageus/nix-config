{
  options,
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkAliasDefinitions mkOption types;
  cfg = config.my.user;
in
{
  options.usr = lib.mkOption {
    type = lib.types.attrs;
    default = { };
    description = "User configuration alias";
  };

  config = {
    users.users.${cfg.name} = mkAliasDefinitions options.usr;

    users.mutableUsers = false;

    usr = {
      isNormalUser = true;
      description = cfg.fullName;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
      shell = pkgs.zsh;
      initialPassword = "init";
    };
  };
}
