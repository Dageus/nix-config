{
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (lib) types mkOption mkIf;
  cfg = config.custom.login;
in
{

  imports = [ inputs.silentSDDM.nixosModules.default ];

  options.custom.login = {
    manager = mkOption {
      type = types.enum [
        "none"
        "sddm"
      ];
      default = "sddm";
      description = "Enable Login Greeter";
    };
  };
  config = mkIf (cfg.manager == "sddm") {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      settings = {
        General = {
          inputMethod = "";
        };
      };
    };

    programs.silentSDDM = {
      enable = true;
      theme = "rei";
      # settings = { ... }; see example in module
    };

  };
}
