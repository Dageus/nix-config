{ config, ... }:
{

  hm.programs.mpv = {
    enable = true;
    config = {
      hwdec = if config.my.hardware.nvidia.enable then "nvdec" else "auto";
    };
  };
}
