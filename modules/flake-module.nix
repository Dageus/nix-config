{ ... }:
{
  flake = {
    nixosModules = {
      options = ./nixos/options.nix;
      hmConnector = ./nixos/hm-connector.nix;
      user = ./nixos/user.nix;
      sops = ./nixos/sops.nix;
    };
    homeModules = {
      common = ./home-manager/common.nix;
    };
  };
}
