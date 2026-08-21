{ lib, ... }: {

  imports = [
    ./greetd.nix
    ./gdm.nix
    ./sddm.nix
    ./lightdm.nix
  ];

  options.my.desktop.greeter = {
    type = lib.mkOption {
      type = lib.types.enum [
        "greetd"
        "gdm"
        "sddm"
        "lightdm"
        "none"
      ];
      default = "none";
      description = "Greeter implementation to enable.";
    };
  };
}
