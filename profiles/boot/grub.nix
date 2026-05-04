{ ... }:
{
  boot.loader = {
    grub = {
      enable = true;
      configurationLimit = 8;
    };

    # Disable boot timeout.
    # Spam "almost any key" to show the menu (<space> works well).
    # Or run: systemctl reboot --boot-loader-menu=0
    timeout = 0;

    efi.canTouchEfiVariables = true;
  };
}
