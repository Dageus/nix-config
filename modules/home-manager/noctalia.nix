{
  inputs,
  config,
  lib,
  ...
}:
{
imports = [ inputs.noctalia.homeModules.default ]; #

  programs.noctalia-shell = {
    enable = true;
    # Paste your ENTIRE settings.json content here as a Nix attribute set
    settings = {
      bar = {
        position = "top";
        frameRadius = 0; # Sharp corners
        # ... rest of your bar settings
      };
      general = {
        radiusRatio = 0; # Global sharp corners
        # ... rest of your general settings
      };
    };
  };
}
