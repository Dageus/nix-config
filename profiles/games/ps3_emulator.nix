{ pkgs, ... }:
{
  hm.home.packages = with pkgs; [
    rpcs3
  ];
}
