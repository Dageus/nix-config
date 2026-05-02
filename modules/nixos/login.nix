{
  config,
  lib,
  inputs,
  pkgs,
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

      backgrounds = {
        jomouzio = config.stylix.image;
      };

      profileIcons = {
        jomouzio = pkgs.fetchurl {
            url = "https://static.wikia.nocookie.net/bleach/images/e/e7/Ep386KenpachiProfile.png/revision/latest/scale-to-width-down/1200?cb=20230921204006&path-prefix=en";
            hash = "sha256-BVuMPdMKfsDxvjC9NdlToMNG0jbWX263Bc6pTqlbehU=";
          };
      };

      settings = {
        "LoginScreen" = {
          background = "${builtins.baseNameOf config.stylix.image}";
        };
        "LockScreen" = {
          background = "${builtins.baseNameOf config.stylix.image}";
        };
      };
    };

  };
}
