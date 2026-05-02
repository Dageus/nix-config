{ ... }:
{
  config = {
    programs.git = {
      enable = true;
      signing = {
        key = "ED1A8299";
        signByDefault = false;
      };
      settings = {
        user.name = "Dageus";
        user.email = "jomouzio@gmail.com";
        format.signoff = true;
        merge.conflictstyle = "zdiff3";
        init.defaultBranch = "main";
        pull.ff = true;
        pull.rebase = true;
        rebase.autosquash = true;
        help.autoCorrect = "prompt";
        color.ui = "auto";
      };
    };

    programs.gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };

    programs.lazygit = {
      enable = true;
      settings = { };
    };

    programs.delta = {
      enable = true;
      enableGitIntegration = true;
    };
  };
}
