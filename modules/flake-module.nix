{ ... }:
{
  flake = {
    nixosModules = {
      nixConfig = ./nixos/config.nix;
      options = ./nixos/options.nix;
      hmConnector = ./nixos/hm-connector.nix;
      user = ./nixos/user.nix;

      sops = ./secrets/sops.nix;

      power = ./hardware/power.nix;

      gpu = ./hardware/gpu.nix;
      desktop = ./desktop/environment.nix;
      greeter = ./desktop/greeter.nix;
      theme = ./theme/default.nix;
    };
  };
}
