{ lib, ... }:
{
  # TODO only do this on intel:
  services.thermald.enable = true;

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

  # Conflicts with auto-cpufreq
  services.power-profiles-daemon.enable = lib.mkForce false;
}
