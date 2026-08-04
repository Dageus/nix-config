{ pkgs, ... }:
{
  stylix.targets.grub.enable = false;

  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      configurationLimit = 8;
      efiSupport = true;
      useOSProber = true;

      theme = "${
        pkgs.fetchFromGitHub {
          owner = "OliveThePuffin";
          repo = "yorha-grub-theme";
          rev = "master";
          sha256 = "sha256-XVzYDwJM7Q9DvdF4ZOqayjiYpasUeMhAWWcXtnhJ0WQ=";
        }
      }/yorha-1920x1080";
    };

    # Disable boot timeout.
    # Spam "almost any key" to show the menu (<space> works well).
    # Or run: systemctl reboot --boot-loader-menu=0
    timeout = 5;

    efi.canTouchEfiVariables = true;
  };
}
