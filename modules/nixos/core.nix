{ pkgs, ... }:
{
  # Core packages/apps for all systems
  # TODO add options to toggle some if needed
  config = {
    environment.systemPackages = with pkgs; [
      tree
      wget
    ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    # Allow users to mount removable drives
    services.udisks2.enable = true;

    # VPN for home access
    services.tailscale.enable = true;

    # Mark admins as trusted users
    nix.settings.trusted-users = [
      "@wheel"
    ];
  };
}
