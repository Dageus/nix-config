{
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkOption
    mkIf
    types
    ;
  cfg = config.my.secrets.sops;
in
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  options.my.secrets.sops = {
    enable = mkEnableOption "Global SOPS secret management";
    defaultSopsFile = mkOption {
      type = types.path;
      default = ../../secrets + "/${config.my.system.hostName}/secrets.yaml";
      description = "Path to the default (host-specific) secrets file for this host.";
    };
    commonSopsFile = mkOption {
      type = types.path;
      default = ../../secrets/common.yaml;
      description = "Path to the shared secrets file, usable by any profile regardless of nesting depth.";
    };
  };

  config = mkIf cfg.enable {
    sops = {
      defaultSopsFile = cfg.defaultSopsFile;
      defaultSopsFormat = "yaml";

      age.keyFile = "/var/lib/sops-nix/key.txt";
      age.generateKey = true;
    };
  };
}
