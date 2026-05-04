{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    protontricks.enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  environment.systemPackages = with pkgs; [
    heroic # TODO: override extraLibraries ?
    steam-run
    inputs.umu-launcher.packages.${system}.default
    mangohud
    goverlay # mangohud config GUI
  ];
}
