{ pkgs, ... }:
{
  hm.stylix.targets.yazi.enable = true;

  hm.programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      manager = {
        show_hidden = true;
        sort_by = "natural";
      };
    };

    plugins = with pkgs.yaziPlugins; {
      smart-enter.package = smart-enter;
      chmod.package = chmod;

      relative-motions.package = relative-motions;

      yatline.package = yatline;

      git.package = git;

      mime-ext.package = mime-ext;
    };

    # Auto-initialize the status bar plugin when Yazi opens
    initLua = ''
      require("yatline"):setup()
    '';
  };
}
