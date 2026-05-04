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

  guessUsername =
    name:
    let
      parts = lib.splitString "@" name;
      len = builtins.length parts;
    in
    if len == 2 then builtins.head parts else name;

  guessHostname =
    name:
    let
      parts = lib.splitString "@" name;
      len = builtins.length parts;
    in
    lib.optionalString (len == 2) (builtins.elemAt parts 1);

  mkSystem =
    name:
    {
      system ? "x86_64-linux",
      username ? "jomouzio",
      fullname ? "Jomouzio",
      modules ? [ ],
      ...
    }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = specialArgs // {
        user = username;
        userFullName = fullname;
      };

      modules = modules ++ [
        ./${name}

        inputs.disko.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
        inputs.stylix.nixosModules.stylix
        inputs.silentSDDM.nixosModules.default
      ];
    };

  mkHome =
    name:
    {
      system ? null,
      username ? guessUsername name,
      hostname ? guessHostname name,
      modules ? [ ],
      ...
    }:
    inputs.home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = specialArgs;
      modules =
        modules
        ++ [
          ./${hostname}/home.nix
          self.homeModules.common
          self.homeModules.home
          {
            home.username = username;
            home.homeDirectory = "/home/${username}";
          }
        ]
        ++ lib.optional (system != null) {
          nixpkgs.hostPlatform = system;
        };
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

    homeConfigurations = builtins.mapAttrs mkHome { };

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
