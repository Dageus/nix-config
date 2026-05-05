{
  options,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkAliasDefinitions mkOption types;
  cfg = config.my.user;
in
{
  options = {
    my.user.name = mkOption {
      type = types.str;
      default = "jomouzio";
    };
    my.user.fullName = mkOption {
      type = types.str;
      default = "Jomouzio";
    };
    my.user.email = mkOption {
      type = types.str;
      default = "";
    };
    my.system.hostName = mkOption { type = types.str; };

    # Load-bearing: mkAliasDefinitions recursively re-declares hm.* as real
    # options so profiles can define hm.programs.*, hm.home.*, etc. from
    # separate modules and they deep-merge correctly.
    hm = mkOption {
      type = types.attrs;
      default = { };
    };
    usr = mkOption {
      type = types.attrs;
      default = { };
    };
  };

  config = {
    # Wire hm.* into home-manager.users.<name>.*
    home-manager.users.${cfg.name} = mkAliasDefinitions options.hm;

    # Wire usr.* into users.users.<name>.*
    users.users.${cfg.name} = mkAliasDefinitions options.usr;

    users.mutableUsers = false;

    # Bootstrap HM basics through the alias
    hm.programs.home-manager.enable = true;
    hm.home.username = cfg.name;
    hm.home.homeDirectory = "/home/${cfg.name}";
    hm.systemd.user.startServices = "sd-switch";

    # Bootstrap system user basics through the alias
    usr.isNormalUser = true;
    usr.createHome = true;
    usr.description = cfg.fullName;
    usr.extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "podman"
    ];
    
    usr.initialPassword = "init";
  };
}
