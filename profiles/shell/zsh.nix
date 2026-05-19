{ ... }:
{
  hm.programs.bash.enable = true;

  programs.zsh.enable = true;

  # Enable zsh shell
  hm.programs.zsh = {
    enable = true;
    enableCompletion = true;

    autocd = true;

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake ~/nix-config#$HOST";
      # update = "nh os switch";
    };

    # Oh-My-Zsh
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
      ];
      theme = "robbyrussell";
    };

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  hm.home.sessionVariables = {
    GOPATH = "$HOME/go";
  };
}
