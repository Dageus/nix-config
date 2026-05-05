{
  self,
  inputs,
  lib,
  ...
}:
let
  # Inject global context here
  specialArgs = {
    inherit self inputs;
  };

  mkSystem =
    name:
    {
      system ? "x86_64-linux",
      ...
    }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = { inherit self inputs; };

      modules = modules ++ [
        ./${name}

        inputs.disko.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
        inputs.stylix.nixosModules.stylix
        inputs.silentSDDM.nixosModules.default

        self.nixosModules.options # my.* namespace
        self.nixosModules.hmConnector # sets up hm alias + useGlobalPkgs
        self.nixosModules.user # creates users.users.<name>
      ];
    };

  mapConfigurationsBySystem' =
    fn: set:
    let
      getSystem = name: set.${name}._module.args.pkgs.stdenv.hostPlatform.system;
      namesToAttrs =
        names:
        lib.pipe names [
          (map (name: fn name set.${name}))
          builtins.listToAttrs
        ];
    in
    lib.pipe set [
      builtins.attrNames
      (builtins.groupBy getSystem)
      (builtins.mapAttrs (_: namesToAttrs))
    ];
in
{
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  flake = {
    nixosConfigurations = builtins.mapAttrs mkSystem {
      laptop = { };
      desktop = { };
    };

    # my custom options
    nixosModules = self.nixosModules.*

    checks = lib.mkMerge [
      (mapConfigurationsBySystem' (name: configuration: {
        name = "nixos-${name}";
        value = configuration.config.system.build.toplevel;
      }) self.nixosConfigurations)

      (mapConfigurationsBySystem' (name: configuration: {
        name = "hm-${name}";
        value = configuration.config.home.activationPackage;
      }) self.homeConfigurations)
    ];
  };
}
