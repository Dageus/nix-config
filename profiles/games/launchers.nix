
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lutris
    heroic
    faugus-launcher
  ];
}
