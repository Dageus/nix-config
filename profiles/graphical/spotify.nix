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

  networking.firewall.allowedUDPPorts = [ lib.my.ports.mdnsGoogleCast ];

  home-manager.users.jomouzio.programs.spicetify = {
    enable = true;
    spotifyPackage = pkgs.spotify;

    theme = pkgs.spicetify.themes.comfy;
    colorScheme = "Comfy";

    enabledExtensions = with pkgs.spicetify.extensions; [
      fullAppDisplay
      autoSkipVideo
      shuffle # shuffle+
      hidePodcasts
    ];

    enabledCustomApps = with pkgs.spicetify.apps; [ lyricsPlus ];
  };
}
