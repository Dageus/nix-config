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
    defaultSopsFile = lib.mkOption {
      type = lib.types.path;
      default = ../../secrets + "/${config.my.system.hostName}/secrets.yaml";
      description = "Path to the default secrets file for this host.";
    };
  };

  config = mkIf cfg.enable {
    sops = {
      defaultSopsFile = cfg.defaultSopsFile;
      defaultSopsFormat = "yaml";

      # age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      age.keyFile = "/var/lib/sops-nix/key.txt";
      age.generateKey = true;

      # NOTE: should the global common secrets be declared here?
    };
  };
}
