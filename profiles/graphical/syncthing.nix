{ ... }:
{
  services.syncthing = {
    enable = true;
    settings = {
      options = {
        urAccepted = -1; # Disable usage reporting prompt
        defaultFolderPath = ""; # Optional: set where new folders go by default
      };
      folders = { };
    };
  };
}
