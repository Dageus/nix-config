{
  options,
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkAliasDefinitions mkOption types;
  cfg = config.my;
in
{
  options.usr = lib.mkOption {
    type = lib.types.attrs;
    default = { };
    description = "User configuration alias";
  };

  config = {
    users.users.${cfg.user.name} = mkAliasDefinitions options.usr;

    users.mutableUsers = false;

    usr = {
      isNormalUser = true;
      description = cfg.user.fullName;
      extraGroups = [
        "wheel"
        "networkmanager"
        "video"
      ];
      shell = pkgs.zsh;
      initialPassword = "init";
    };

    networking.hostName = cfg.system.hostName;

    home-manager.users.${cfg.user.name} = {
      home.file.".face".source = cfg.system.profile;
      home.file.".face.icon".source = cfg.system.profile;

      home.file."pictures/wallpapers" = {
        source = ../../config/wallpapers;
        recursive = true;
      };
    };
  };
}
