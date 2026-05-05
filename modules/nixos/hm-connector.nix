{ lib, config, options, ... }:
{
  options.hm = lib.mkOption {
    type = lib.types.attrs;
    default = { };
    description = "Home-manager configuration alias";
  };

  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
    };

    home-manager.users.${config.my.user.name} = lib.mkAliasDefinitions options.hm;
  };
}
