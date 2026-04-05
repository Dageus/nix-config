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
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };

    # Use the starship prompt
    programs.starship = {
      enable = true;
      enableTransience = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      # See https://starship.rs/config
      settings = {
        add_newline = true;
        character = {
          success_symbol = "➜(bold green)";
          error_symbol = "➜(bold red)";
        };
      };
    };
  };
}
