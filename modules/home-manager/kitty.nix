{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit
    (lib)
    types
    mkIf
    mkOption
    getExe
    ;

  cfg = config.custom.terminal.kitty;
in {
  options.custom.terminal.kitty = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Kitty terminal";
    };
    lightTheme = mkOption {
      type = types.str;
      default = "rose-pine";
      description = ''
        Light theme filename. Follows system theme.

        This option takes the file name of a theme in `kitty-themes`, without the `.conf` suffix.
        See <https://github.com/kovidgoyal/kitty-themes/tree/master/themes> for a list of themes.
      '';
    };
    darkTheme = mkOption {
      type = types.str;
      default = "rose-pine";
      description = ''
        Dark theme filename. Follows system theme.

        This option takes the file name of a theme in `kitty-themes`, without the `.conf` suffix.
        See <https://github.com/kovidgoyal/kitty-themes/tree/master/themes> for a list of themes.
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;

      # Enable shell completions (etc) for kitty command
      shellIntegration.enableBashIntegration = true;
      shellIntegration.enableZshIntegration = true;

      keybindings = {
        "ctrl+c" = "copy_and_clear_or_interrupt";
        "ctrl+shift+c" = "copy_to_clipboard";
      };

      settings = {
        # Use tmux if enabled, otherwise zsh
        shell = getExe (
          if config.programs.tmux.enable
          then config.programs.tmux.package
          else config.programs.zsh.package
        );
        # system, background, #hex, or color name
        confirm_os_window_close = 0;
        background_opacity = "0.95";
        wayland_titlebar_color = "background";
        dynamic_background_opacity = true;
        enable_audio_bell = false;
        cursor_shape = "block";
        clipboard_control = "write-clipboard write-primary read-clipboard read-primary";
      };

      # TODO use fonts defined in nix config
      font = {
        name = "Iosevka Term";
        size = 12;
      };
    };

    # TODO: upstream kitty auto-theme configs to home-manager:
    #       home-manager has a `programs.kitty.themeFile` option.
    #
    # NOTE: Some desktops, like GNOME, claim "no preference" when light mode is enabled.
    xdg.configFile."kitty/dark-theme.auto.conf".source = "${pkgs.kitty-themes}/share/kitty-themes/themes/${cfg.darkTheme}.conf";
    xdg.configFile."kitty/light-theme.auto.conf".source = "${pkgs.kitty-themes}/share/kitty-themes/themes/${cfg.lightTheme}.conf";
    xdg.configFile."kitty/no-preference-theme.auto.conf".source = "${pkgs.kitty-themes}/share/kitty-themes/themes/${cfg.lightTheme}.conf";
  };
}
