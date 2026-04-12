{
  config,
  lib,
  ...
}:
let
  inherit (lib) types mkOption mkIf;
  cfg = config.custom.login;
in
{
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
  };
}
