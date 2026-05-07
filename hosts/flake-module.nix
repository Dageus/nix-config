{
  self,
  inputs,
  lib,
  ...
}:
let
  customLib = import ../lib { inherit lib; };

  profiles = customLib.rakeLeaves ../profiles;

  # TODO: next step
  # allHosts = customLib.rakeLeaves ./.;
  #
  # validHosts = lib.filterAttrs (name: _: name != "flake-module") allHosts;

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

        self.nixosModules.options # my.* namespace
        self.nixosModules.hmConnector # sets up hm alias + useGlobalPkgs
        self.nixosModules.user # creates users.users.<name>

        inputs.disko.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
        inputs.stylix.nixosModules.stylix
        inputs.silentSDDM.nixosModules.default
      ];
    };

  mkHome =
    name:
    {
      system,
      username,
      homeFile,
    }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      extraSpecialArgs = { inherit self inputs; };
      modules = [
        homeFile
        self.homeModules.common
      ];
    };
in
{
  flake = {
    nixosConfigurations = builtins.mapAttrs mkSystem {
      laptop = { };
      desktop = { };
    };

    # TODO: next step
    # nixosConfigurations = extendedLib.mapAttrs (name: _: mkSystem name { }) validHosts;

    homeConfigurations = {
      "jomouzio@work" = mkHome "work" {
        system = "x86_64-linux";
        username = "jomouzio";
        homeFile = ./hosts/work/home.nix;
      };
    };

    checks =
      let
        nixosChecks = lib.mapAttrsToList (name: cfg: {
          system = cfg.pkgs.system;
          name = "nixos-${name}";
          drv = cfg.config.system.build.toplevel;
        }) self.nixosConfigurations;

        hmChecks = lib.mapAttrsToList (name: cfg: {
          system = cfg.pkgs.system;
          name = "hm-${name}";
          drv = cfg.config.home.activationPackage;
        }) self.homeConfigurations;

        allChecks = nixosChecks ++ hmChecks;
        bySystem = lib.groupBy (c: c.system) allChecks;
      in
      lib.mapAttrs (
        system: checks: lib.listToAttrs (map (c: lib.nameValuePair c.name c.drv) checks)
      ) bySystem;
  };
}
