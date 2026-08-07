{ pkgs, config, ... }:
{
  hm.xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
      setSessionVariables = true;

      desktop = "${config.my.user.homeDirectory}/.desktop";
      documents = "${config.my.user.homeDirectory}/documents";
      download = "${config.my.user.homeDirectory}/downloads";
      music = "${config.my.user.homeDirectory}/music";
      pictures = "${config.my.user.homeDirectory}/pictures";
      publicShare = "${config.my.user.homeDirectory}/.public";
      templates = "${config.my.user.homeDirectory}/.templates";
      videos = "${config.my.user.homeDirectory}/videos";

    };
    # TODO: figure out what to do with this
    # configFile."mimeapps.list".force = true;
  };
}
