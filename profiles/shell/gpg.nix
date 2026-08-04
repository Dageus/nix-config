{ pkgs, ... }:
let
  # Time units
  m = 60;
  h = 60 * m;
  d = 24 * h;
  y = 365 * d;
in
{
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
    settings = {
      default-cache-ttl = 8 * h;
      default-cache-ttl-ssh = 8 * h;
      max-cache-ttl = 128 * y;
      max-cache-ttl-ssh = 128 * y;
      grab = true; # Replaces grabKeyboardAndMouse
    };
  };

  hm.programs.gpg = {
    enable = true;
    # settings = {
    #   default-key = "7082 22EA 1808 E39A 83AC  8B18 4F91 844C ED1A 8299";
    # };
  };
}
