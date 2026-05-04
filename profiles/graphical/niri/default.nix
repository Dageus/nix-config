{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [ inputs.niri.nixosModules.niri ];

  programs.niri = {
    enable = true;
    package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable;
  };

  programs.xwayland.enable = true;

  # BUG: we need a better way to do this
  hm.programs.niri = {
    settings = {
      includes = lib.mkAfter [
        (./blur.kdl)
      ];

      # General Settings =========================================================
      prefer-no-csd = true;
      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      # Input ====================================================================
      input = {
        keyboard.xkb.layout = "pt";
        keyboard.numlock = true;
        touchpad = {
          tap = true;
          natural-scroll = true;
        };
        # mouse = { };
        # trackpoint = { };
        focus-follows-mouse.max-scroll-amount = "0%";
      };

      # Outputs ==================================================================
      outputs."eDP-1".scale = 1.0;

      # Layout ===================================================================
      layout = {
        gaps = 6;
        center-focused-column = "never";

        preset-column-widths = [
          { proportion = 1.0 / 3.0; }
          { proportion = 1.0 / 2.0; }
          { proportion = 2.0 / 3.0; }
        ];

        default-column-width.proportion = 0.5;

        focus-ring.width = 1;
        border.width = 1;

        shadow = {
          softness = 10;
          spread = 4;
          offset = {
            x = 0;
            y = 0;
          };
        };
      };

      # Startup Apps =============================================================
      spawn-at-startup = [
        { command = [ "noctalia-shell" ]; }
        {
          command = [
            "vicinae"
            "server"
          ];
        }
      ];

      # Window Rules =============================================================
      window-rules = [
        {
          matches = [
            { app-id = "kitty-float"; }
          ];
          open-floating = true;
          default-column-width.proportion = 0.5;
          default-window-height.proportion = 0.5;
        }
        {
          matches = [
            { app-id = "firefox$"; }
            { title = "^Picture-in-Picture$"; }
          ];
          open-floating = true;
        }
        {
          matches = [
            { app-id = "kitty"; }
          ];
          clip-to-geometry = true;
          # background-effect = {
          #   blur = true;
          #   xray = true;
          # };
        }
        {
          matches = [
            { app-id = "firefox"; }
          ];
          draw-border-with-background = false;
          # background-effect = {
          #   blur = true;
          #   xray = true;
          # };
        }
        {
          matches = [
            { is-focused = false; }
          ];
          opacity = 0.7;
        }
      ];

      # Key Bindings =============================================================
      binds = {
        "Mod+Shift+Slash".action.show-hotkey-overlay = [ ];

        "Mod+Space" = {
          action.spawn = [
            "vicinae"
            "toggle"
          ];
          repeat = false;
        };

        # Terminal
        "Mod+Return" = {
          action.spawn = [ "kitty" ];
          hotkey-overlay.title = "Open Terminal: kitty";
        };
        "Mod+Shift+Return" = {
          action.spawn = [
            "sh"
            "-c"
            "kitty --class kitty-float"
          ];
          hotkey-overlay.title = "Floating Terminal";
        };

        # App shortcuts
        "Mod+B" = {
          action.spawn = [ "firefox" ];
          hotkey-overlay.title = "Open a Browser: Firefox";
        };
        "Mod+E" = {
          action.spawn = [
            "sh"
            "-c"
            "kitty zsh -i -c yazi"
          ];
          hotkey-overlay.title = "Open File Manager: yazi";
        };
        "Mod+S" = {
          action.spawn = [ "spotify" ];
          hotkey-overlay.title = "Open Spotify";
        };
        "Mod+Q".action.close-window = [ ];
        "Mod+TAB".action.toggle-overview = [ ];

        # Noctalia general actions
        "Mod+Alt+L" = {
          action.spawn = [
            "sh"
            "-c"
            "noctalia-shell ipc call lockScreen lock"
          ];
          hotkey-overlay.title = "Lock the Screen: noctalia-shell";
        };
        "Mod+Shift+W" = {
          action.spawn = [
            "sh"
            "-c"
            "noctalia-shell ipc call wallpaper toggle"
          ];
          hotkey-overlay.title = "Change Wallpaper: noctalia-shell";
        };
        "Mod+Alt+P" = {
          action.spawn = [
            "sh"
            "-c"
            "noctalia-shell ipc call sessionMenu toggle"
          ];
          hotkey-overlay.title = "Session Menu";
        };

        "Ctrl+Shift+Escape" = {
          action.spawn = [
            "sh"
            "-c"
            "kitty zsh -i -c btop"
          ];
          hotkey-overlay.title = "Open System Monitor: btop";
        };

        # Audio Control
        "XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          action.spawn = [
            "sh"
            "-c"
            "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0"
          ];
        };
        "XF86AudioLowerVolume" = {
          allow-when-locked = true;
          action.spawn = [
            "sh"
            "-c"
            "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"
          ];
        };
        "XF86AudioMute" = {
          allow-when-locked = true;
          action.spawn = [
            "sh"
            "-c"
            "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ];
        };
        "XF86AudioMicMute" = {
          allow-when-locked = true;
          action.spawn = [
            "sh"
            "-c"
            "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ];
        };
        "XF86AudioPlay" = {
          allow-when-locked = true;
          action.spawn = [
            "sh"
            "-c"
            "playerctl play-pause"
          ];
        };
        "XF86AudioNext" = {
          allow-when-locked = true;
          action.spawn = [
            "sh"
            "-c"
            "playerctl next"
          ];
        };
        "XF86AudioPrev" = {
          allow-when-locked = true;
          action.spawn = [
            "sh"
            "-c"
            "playerctl previous"
          ];
        };
        "XF86AudioStop" = {
          allow-when-locked = true;
          action.spawn = [
            "sh"
            "-c"
            "playerctl stop"
          ];
        };

        # Brightness control
        "XF86MonBrightnessUp" = {
          allow-when-locked = true;
          action.spawn = [
            "brightnessctl"
            "--class=backlight"
            "set"
            "+10%"
          ];
        };
        "XF86MonBrightnessDown" = {
          allow-when-locked = true;
          action.spawn = [
            "brightnessctl"
            "--class=backlight"
            "set"
            "10%-"
          ];
        };

        # Directional Focus
        "Mod+Left".action.focus-column-left = [ ];
        "Mod+H".action.focus-column-left = [ ];
        "Mod+Right".action.focus-column-right = [ ];
        "Mod+L".action.focus-column-right = [ ];
        "Mod+Down".action.focus-window-or-workspace-down = [ ];
        "Mod+U".action.focus-window-down = [ ];
        "Mod+Up".action.focus-window-or-workspace-up = [ ];
        "Mod+I".action.focus-window-up = [ ];

        # Moving windows
        "Mod+Ctrl+Left".action.move-column-left = [ ];
        "Mod+Ctrl+H".action.move-column-left = [ ];
        "Mod+Ctrl+Right".action.move-column-right = [ ];
        "Mod+Ctrl+L".action.move-column-right = [ ];
        "Mod+Ctrl+Down".action.move-window-down = [ ];
        "Mod+Ctrl+J".action.move-window-down = [ ];
        "Mod+Ctrl+Up".action.move-window-up = [ ];
        "Mod+Ctrl+K".action.move-window-up = [ ];

        # Monitors
        "Mod+Shift+H".action.focus-monitor-left = [ ];
        "Mod+Shift+Left".action.focus-monitor-left = [ ];
        "Mod+Shift+L".action.focus-monitor-right = [ ];
        "Mod+Shift+Right".action.focus-monitor-right = [ ];
        "Mod+Shift+J".action.focus-monitor-down = [ ];
        "Mod+Shift+Down".action.focus-monitor-down = [ ];
        "Mod+Shift+K".action.focus-monitor-up = [ ];
        "Mod+Shift+Up".action.focus-monitor-up = [ ];

        # Workspace
        "Mod+Page_Down".action.focus-workspace-down = [ ];
        "Mod+Page_Up".action.focus-workspace-up = [ ];
        "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = [ ];
        "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = [ ];

        "Mod+WheelScrollDown" = {
          action.focus-workspace-down = [ ];
          cooldown-ms = 150;
        };
        "Mod+WheelScrollUp" = {
          action.focus-workspace-up = [ ];
          cooldown-ms = 150;
        };
        "Mod+Ctrl+WheelScrollDown" = {
          action.move-column-to-workspace-down = [ ];
          cooldown-ms = 150;
        };
        "Mod+Ctrl+WheelScrollUp" = {
          action.move-column-to-workspace-up = [ ];
          cooldown-ms = 150;
        };

        # Workspace Navigation
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;

        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;
        "Mod+Shift+6".action.move-column-to-workspace = 6;
        "Mod+Shift+7".action.move-column-to-workspace = 7;
        "Mod+Shift+8".action.move-column-to-workspace = 8;
        "Mod+Shift+9".action.move-column-to-workspace = 9;

        # Layout & Sizing
        "Mod+BracketLeft".action.consume-or-expel-window-left = [ ];
        "Mod+BracketRight".action.consume-or-expel-window-right = [ ];
        "Mod+Comma".action.consume-window-into-column = [ ];
        "Mod+Period".action.expel-window-from-column = [ ];
        "Mod+R".action.switch-preset-column-width = [ ];
        "Mod+F".action.maximize-column = [ ];
        "Mod+Shift+F".action.fullscreen-window = [ ];
        "Mod+C".action.center-column = [ ];
        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Plus".action.set-column-width = "+10%";
        "Mod+V" = {
          action.toggle-window-floating = [ ];
          hotkey-overlay.title = "Switch to floating";
        };
        "Mod+W".action.toggle-column-tabbed-display = [ ];

        # Screenshots
        "Print".action.screenshot = [ ];
        "Ctrl+Print".action.screenshot-screen = [ ];
        "Alt+Print".action.screenshot-window = [ ];
      };

      # Noctalia Debug Compatibility
      debug.honor-xdg-activation-with-invalid-serial = true;
    };
  };
}
