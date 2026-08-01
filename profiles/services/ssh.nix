{ ... }:
{
  services.openssh = {
    enable = true;
    openFirewall = true; # Automatically opens port 22 in the NixOS firewall

    settings = {
      # Security best practices
      # PasswordAuthentication = false; # Forces you to use secure SSH Keys
      PermitRootLogin = "no"; # Never log in as root directly
    };
  };
}
