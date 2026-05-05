{ lib, config, ... }:
{
  imports = [
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" config.my.user.name ])
  ];

  config.home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    # Alias so that every module can write hm.programs.xxx instead of
    # home-manager.users.<username>.programs.xxx
    users.${config.my.user.name} = config.hm;
  };
}
