{config, lib,  pkgs, ... }:
{
  hm.stylix.targets.kitty.enable = false;

  hm.programs.kitty = {
    enable = true;
    theme = "Rosé Pine";

    keybindings = {
      "ctrl+c" = "copy_and_clear_or_interrupt";
      "ctrl+shift+c" = "copy_to_clipboard";
    };

    settings = {
      background = lib.mkForce "#171717";
      background_opacity = lib.mkDefault (toString config.stylix.opacity.terminal);

      shell = lib.getExe (pkgs.zsh);
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
}
