{
  config,
  lib,
  pkgs,
  ...
}:
let
  busIds = config.my.hardware.nvidia.busIds;
in
{
  hardware.graphics = {
    enable = true;
    extraPackages = lib.optionals (busIds != null && busIds.type == "intel") [
      pkgs.intel-media-driver
    ];
  };

  services.xserver.videoDrivers = [
    "modesetting"
  ]
  ++ lib.optionals (config.my.hardware.nvidia.enable) [ "nvidia" ];

  hardware.nvidia = lib.mkIf config.my.hardware.nvidia.enable {
    modesetting.enable = true;
    open = false;
    powerManagement = {
      enable = true;
      # WARNING: with legacy_580, this can cause issues, comment if something happens
      finegrained = true;
    };

    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;

    prime = lib.mkIf (busIds != null) {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = lib.mkIf (busIds.type == "intel") busIds.igpu;
      amdgpuBusId = lib.mkIf (busIds.type == "amd") busIds.igpu;
      nvidiaBusId = busIds.nvidia;
    };
  };
}
