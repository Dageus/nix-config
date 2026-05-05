{ lib, ... }:
{
  time.timeZone = "Europe/Lisbon";

  console.keyMap = "pt-latin1";

  i18n = {
    defaultLocale = lib.mkDefault "en_GB.UTF-8";
    supportedLocales = lib.mkDefault [
      "en_GB.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "pt_PT.UTF-8/UTF-8"
    ];

      extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "pt_PT.UTF-8";
    };
  };
}
