{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rpcs3
  ];

  home.file = {
    "Games/Emulation/PS3/Firmware/.keep".text = "";
    "Games/Emulation/PS3/Games/.keep".text = "";
  };
}
