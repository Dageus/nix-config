{ pkgs, inputs, ... }:
let
  noctaliaPkg = inputs.noctalia.packages.${pkgs.system}.default;
in
{
  home.packages = with pkgs; [
    vicinae
    yazi
  ];

  xdg.configFile."niri/config.kdl".source = ./niri/config.kdl;
  xdg.configFile."niri/noctalia.kdl".source = ./niri/noctalia.kdl;

}
