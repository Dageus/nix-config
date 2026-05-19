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
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in
    {
      enable = true;
      spotifyPackage = pkgs.spotify;

      theme = lib.mkForce spicePkgs.themes.comfy;
      colorScheme = lib.mkForce "Comfy";

      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        autoSkipVideo
        shuffle # shuffle+
        hidePodcasts
      ];

      enabledCustomApps = with spicePkgs.apps; [ lyricsPlus ];
    };
}
