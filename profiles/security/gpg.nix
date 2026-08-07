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
    # pinentry-curses fights lazygit for the terminal. no good
    pinentryPackage = pkgs.pinentry-gtk2;
    settings = {
      default-cache-ttl = 8 * h;
      default-cache-ttl-ssh = 8 * h;
      max-cache-ttl = 128 * y;
      max-cache-ttl-ssh = 128 * y;
    };
  };

  hm.programs.gpg = {
    enable = true;
    # settings = {
    #   default-key = "25F9 30DB 5C01 0438 636B  471A 5590 CFAB 184A 8968";
    # };
  };
}
