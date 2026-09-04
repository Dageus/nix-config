{ ... }:
{
  hm.programs.git = {
    enable = true;
    signing = {
      key = "FCD98E04F6DA3009";
      signByDefault = true;
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
    extraConfig = {
      gpg.format = "openpgp";
    };
  };

  hm.programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };

  hm.programs.lazygit = {
    enable = true;
    settings = { };
  };

  hm.programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
