{ lib, config, ... }:
let
  cfg = config.my.power;
  inherit (lib) mkOption mkMerge mkForce mkIf types;
in
{
  options.my.power = {
    backend = mkOption {
      type = types.enum [
        "none"
        "power-profiles-daemon"
        "auto-cpufreq"
      ];
      default = "none";
      description = ''
        CPU power/governor management strategy. These are mutually
        exclusive — both manage the same governor/turbo state and
        will fight each other if both enabled.

        - power-profiles-daemon: DBus-native, integrates with desktop
          shells / bars (e.g. noctalia profile cycling). Coarser presets.
        - auto-cpufreq: fine-grained battery/charger-aware governor and
          turbo rules. No DBus/UI integration.
      '';
    };
  };

  config = mkMerge [
    (mkIf (cfg.backend != "none") {
      services.upower.enable = true;
    })

    (mkIf (cfg.backend == "power-profiles-daemon") {
      services.auto-cpufreq.enable = mkForce false;
      services.power-profiles-daemon.enable = true;
    })

    (mkIf (cfg.backend == "auto-cpufreq") {
      services.power-profiles-daemon.enable = mkForce false;
      services.auto-cpufreq = {
        enable = true;
        settings = {
          battery = {
            governor = "powersave";
            turbo = "never";
          };
          charger = {
            governor = "performance";
            turbo = "auto";
          };
        };
      };
    })
  ];
}
