{
  self,
  inputs,
  lib,
  ...
}:
let
  customLib = import ../lib { inherit lib; };

  profiles = customLib.rakeLeaves ../profiles;

  baseModules = with self.nixosModules; [
    nixConfig
    options
    hmConnector
    user
  ];

  featureModules = with self.nixosModules; [
    power
    sops
    gpu
    desktop-environment
    greeter
    boot
    theme
  ];

  mkSystem =
    name:
    {
      system ? "x86_64-linux",
      ...
    }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit self inputs profiles; };
      modules = [
        ./${name}
        inputs.disko.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
        inputs.stylix.nixosModules.stylix
        inputs.silentSDDM.nixosModules.default
      ]
      ++ baseModules
      ++ featureModules;
    };
in
{
  flake = {
    nixosConfigurations = builtins.mapAttrs mkSystem {
      laptop = { };
      desktop = { };
    };

    checks =
      let
        nixosChecks = lib.mapAttrsToList (name: cfg: {
          system = cfg.pkgs.system;
          name = "nixos-${name}";
          drv = cfg.config.system.build.toplevel;
        }) self.nixosConfigurations;

        bySystem = lib.groupBy (c: c.system) nixosChecks;
      in
      lib.mapAttrs (
        system: checks: lib.listToAttrs (map (c: lib.nameValuePair c.name c.drv) checks)
      ) bySystem;
  };
}
