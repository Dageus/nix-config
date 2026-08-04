{ pkgs, ... }:
{
  hm.home.packages = with pkgs; [
    pcsx2
  ];
}
