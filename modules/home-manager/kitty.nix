{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib)
    types
    mkIf
    mkOption
    getExe
    ;

  cfg = config.custom.terminal.kitty;
in
{
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
    # disable stylix for now
    stylix.targets.kitty.enable = false;

    programs.kitty = {
      enable = true;
      theme = "Rosé Pine";

      keybindings = {
        "ctrl+c" = "copy_and_clear_or_interrupt";
        "ctrl+shift+c" = "copy_to_clipboard";
      };

      settings = {
        background = lib.mkForce "#171717";
        background_opacity = lib.mkDefault (toString config.stylix.opacity.terminal);

        shell = getExe (config.programs.zsh.package);
        # system, background, #hex, or color name
        confirm_os_window_close = 0;
        background_blur = "1";
        wayland_titlebar_color = "background";
        dynamic_background_opacity = true;
        enable_audio_bell = false;
        cursor_shape = lib.mkForce "block";
        cursor_blink_interval = 0;
        shell_integration = "no-cursor";
        clipboard_control = "write-clipboard write-primary read-clipboard read-primary";
      };

      font = {
        name = config.stylix.fonts.monospace.name;
        package = config.stylix.fonts.monospace.package;
        size = config.stylix.fonts.sizes.terminal;
      };
    };
  };
}
