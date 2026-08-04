{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.tree-sitter
    pkgs.gcc
    pkgs.unzip
    pkgs.go
    pkgs.nodejs
    pkgs.python3
  ];

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
