{ lib, ... }:
{
  options.hm = lib.mkOption {
    type = lib.types.attrsOf lib.types.raw;
    default = { };
    description = "Home-manager configuration for the primary user, automatically wired.";
  };

  config.home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    # Alias so that every module can write hm.programs.xxx instead of
    # home-manager.users.<username>.programs.xxx
    users.${config.my.user.name} = config.hm;
  };
}
