{ config, lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  options.my = {
    user = {
      name = mkOption {
        type = types.str;
        default = "jomouzio";
        description = "Primary username";
      };
      fullName = mkOption {
        type = types.str;
        default = "Jomouzio";
      };
      email = mkOption {
        type = types.str;
        default = "jomouzio@example.com";
      };
      # Needed for XDG path resolution across modules
      homeDirectory = mkOption {
        type = types.str;
        default = "/home/${config.my.user.name}";
        description = "Absolute path to user home directory";
      };
    };

    system = {
      hostName = mkOption {
        type = types.str;
        description = "Network hostname";
      };
      type = mkOption {
        type = types.enum [
          "laptop"
          "desktop"
          "server"
          "vm"
        ];
        description = "System form factor";
      };
      # Feature flags: keeps profiles clean without hardcoding hostnames
      isGaming = mkOption {
        type = types.bool;
        default = false;
        description = "Enable steam, high-performance power profiles, and dedicated GPU tweaks";
      };
      isWork = mkOption {
        type = types.bool;
        default = false;
        description = "Enable work VPNs, strict security rules, and dev tools";
      };
      wallpaper = mkOption {
        type = types.path;
        description = "Global path to the active system wallpaper";
        default = ../../config/wallpapers/Elden_Ring_Castle.png;
      };

      profile = mkOption {
        type = types.path;
        description = "Global path to the active system profile picture";
        default = ../../config/profile/kisuke_urahara.jpg;
      };
    };

    # Hardware profile options
    hardware = {
      cpu = {
        vendor = mkOption {
          type = types.enum [
            "intel"
            "amd"
          ];
          description = "CPU vendor";
          default = "intel";
        };
      };

      nvidia = {
        enable = mkOption {
          type = types.bool;
          default = false;
          description = "Enable NVIDIA proprietary drivers";
        };

        busIds = mkOption {
          type = types.nullOr (
            types.submodule {
              options = {
                igpu = mkOption {
                  type = types.str;
                  description = "iGPU Bus ID (Intel or AMD)";
                };
                nvidia = mkOption {
                  type = types.str;
                  description = "NVIDIA dGPU Bus ID";
                };
                type = mkOption {
                  type = types.enum [
                    "intel"
                    "amd"
                  ];
                  default = "intel";
                };
              };
            }
          );
          default = null;
          description = "PRIME Bus IDs for hybrid laptops";
        };
      };

      screen = {
        width = mkOption {
          type = types.int;
          default = 1920;
        };
        height = mkOption {
          type = types.int;
          default = 1080;
        };
      };
    };
  };
}
