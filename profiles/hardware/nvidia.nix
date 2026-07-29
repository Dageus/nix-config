{ config, ... }:
let
  cfg = config.system;
  isLaptop = cfg.type == "laptop";
in
{
  hardware.graphics.enable = true;
  services.xserver.videoDrivers =
    if isLaptop then
      [
        "modesetting"
        "nvidia"
      ]
    else
      [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;

    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0@0:2:0";
      nvidiaBusId = "PCI:1@0:0:0";
    };
  };

}
