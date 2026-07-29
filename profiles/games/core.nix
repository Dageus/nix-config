{ ... }:
{
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        softrealtime = "auto";
        renice = 10;
      };
    };
  };

  programs.gamescope.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
  };

  environment.systemPackages = with pkgs; [
    mangohud
    goverlay
  ];

  # For steam
  hardware.graphics.enable32Bit = true;
}
