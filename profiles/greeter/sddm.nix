{
  config,
  lib,
  inputs,
  pkgs,
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
    theme = "silvia";

    backgrounds = {
      "${config.my.user.name}" = config.stylix.image;
    };

    profileIcons = {
      "${config.my.user.name}" = ../../config/profile/kisuke_urahara.jpg;
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
