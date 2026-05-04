{
  config,
  lib,
  inputs,
  pkgs,
  user,
  ...
}:
{
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
      "${user}" = config.stylix.image;
    };

    profileIcons = {
      "${user}" = pkgs.fetchurl {
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
}
