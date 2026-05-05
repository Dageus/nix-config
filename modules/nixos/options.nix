{ lib, ... }:
with lib;
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
        description = "System form factor / role";
      };
    };
  };
}
