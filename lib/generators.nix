{
  inputs,
  lib,
  nixosConfigurations,
  pkgs,
  profiles,
  secrets,
  ...
}@args:
let
  inherit (lib.my) rakeLeaves;
  /*
    Synopsis: mkProfiles profilesDir

    Generate profiles from the Nix expressions found in the specified directory.

    Inputs:
    - profilesDir: The path to the directory containing Nix expressions.

    Output Format:
    An attribute set representing profiles.
    The function uses the `rakeLeaves` function to recursively collect Nix files
    and directories within the `profilesDir` directory.
    The result is an attribute set mapping Nix files and directories
    to their corresponding keys.
  */
  mkProfiles = profilesDir: rakeLeaves profilesDir;
in
{
  inherit
    mkPkgs
    mkOverlays
    mkProfiles
    mkSecrets
    mkHosts
    mkStaticConfigs
    ;
}
