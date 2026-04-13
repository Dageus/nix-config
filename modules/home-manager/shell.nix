{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.custom.shell;
in {
  options.custom.shell = {
    zsh = mkEnableOption "Zsh shell";
  };

  config = {
    # home-manager needs to manage bash in order for sessionVariables
    # to be added to ~/.profile
    programs.bash.enable = true;

    # Enable zsh shell
    programs.zsh = {
      enable = true;
      enableCompletion = true;

      autocd = true;

      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch --flake ~/nix-config#laptop";
      };

      # Oh-My-Zsh
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" ];
        theme = "robbyrussell";
      };

      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };

    # Enable zoxide
    programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
    };

    home.sessionVariables = {
        GOPATH = "$HOME/go";
    };
  };
}
