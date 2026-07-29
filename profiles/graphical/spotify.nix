{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  home-manager.sharedModules = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  networking.firewall.allowedUDPPorts = [ 5353 ]; # mDNS for Google Cast

  hm.programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      enable = true;
      spotifyPackage = pkgs.spotify;

      theme = lib.mkForce spicePkgs.themes.sleek;
      colorScheme = lib.mkForce "BladeRunner";

      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        autoSkipVideo
        shuffle
        hidePodcasts
      ];

      enabledSnippets = with spicePkgs.snippets; [
        rotatingCoverart
        pointer
      ];

      enabledCustomApps = with spicePkgs.apps; [
        lyricsPlus
        ncsVisualizer
      ];
    };
}
