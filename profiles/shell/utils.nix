{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tree
    wget
  ];
}
