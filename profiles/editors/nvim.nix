{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  hm.home.packages = [ pkgs.neovim ];
  hm.home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
