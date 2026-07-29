{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  hm.imports = [
    inputs.noctalia.homeModules.default
  ];

  environment.systemPackages = [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  hm.stylix.targets.noctalia-shell.enable = true;

  hm.programs.noctalia = {
    package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;

    enable = true;

    settings = {
      theme = {
        source = "community";
        community_palette = "GruvboxAlt";
        mode = "dark";
        templates = {
          bultin_ids = [
            "btop"
            "niri"
          ];
          community_ids = [
            "obsidian"
            "vicinae"
            "lazygit"
            "steam"
            "yazi"
            "zathura"
          ];
          enable_builtin_templates = true;
          enable_community_templates = true;
        };
      };

      shell = {
        time_format = "{:%H:%M}";
        font_family = "IosevkaTerm NF";
        app_icon_colorize = true;
        telemetry_enabled = false;
        clipboard_enabled = true;
        clipboard_auto_paste = "off";
        clipboard_history_max_entries = 50;
        # TODO:
        # avatar_path = "${self}/files/icons/swarsel.png";
        settings_show_advanced = true;
        screenshot.directory = "~/Pictures/Screenshots";
        animation = {
          enabled = true;
          speed = 4.0;
        };
        shadow.direction = "center";
        screen_corners.enabled = false;
        panel = {
          transparency_mode = "solid";
          launcher_placement = "floating";
          wallpaper_placement = "floating";
          session_placement = "centered";
          control_center_placement = "floating";
          open_near_click_control_center = true;
          launcher_categories = false;
          launcher_compact = true;
          launcher_show_icons = true;
        };
        session.actions = [
          {
            action = "lock";
            shortcut = "l";
          }
          {
            action = "suspend";
            shortcut = "s";
          }
          {
            action = "command";
            command = "systemctl hibernate";
            label = "Hibernate";
            glyph = "suspend";
            shortcut = "h";
          }
          {
            action = "reboot";
            shortcut = "r";
          }
          {
            action = "logout";
            shortcut = "u";
          }
          {
            action = "shutdown";
            shortcut = "p";
          }
          {
            action = "command";
            command = "systemctl reboot --firmware-setup";
            label = "Reboot to UEFI";
            glyph = "reboot";
            shortcut = "b";
          }
        ];
      };

      widget = {
        workspaces = {
          display = "name";
          max_label_chars = 4;
          labels_only_when_occupied = false;
          hide_when_empty = true;
        };
        active_window = {
          max_length = 300;
          # WARNING: what setting is this?
          # title_scroll = true;
          display = "icon_and_text";
        };
        tray = {
          hidden = [ "bluetooth" ];
          drawer = true;
        };
        volume = {
          show_label = true;
          scroll_step = 5;
          device = "output";
        };
        notifications.hide_when_no_unread = false;
        network.show_label = false;
        battery = {
          device = "auto";
          display_mode = "graphic";
          show_label = true;
        };
        clock = {
          format = "{:%a %d. %b %H:%M:%S}";
          tooltip_format = "{:%a %d. %b %H:%M:%S}";
        };
        "control-center" = {
          glyph = "noctalia";
          # TODO:
          # custom_image = "${self}/files/icons/swarsel.png";
          custom_image_colorize = true;
        };
      };

      weather = {
        enabled = true;
        unit = "celsius";
        effects = false;
      };

      location = {
        auto_locate = false;
        address = "Lisboa, Portugal";
      };

      idle = {
        behavior_order = [
          "lock"
          "suspend"
        ];
        pre_action_fade_seconds = 0.0;
        behavior = {
          lock = {
            enabled = true;
            timeout = 300;
            action = "lock";
          };
          suspend = {
            enabled = true;
            timeout = 600;
            action = "lock_and_suspend";
          };
        };
      };

      wallpaper = {
        enabled = true;
        directory = "/home/jomouzio/Pictures/Wallpapers";
        fill_mode = "crop";
        transition = [
          "fade"
          "wipe"
          "disc"
          "stripes"
          "zoom"
          "honeycomb"
        ];
        transition_duration = 500.0;
        edge_smoothness = 0.05;
        automation = {
          enabled = true;
          interval_seconds = 300;
          order = "random";
          recursive = true;
        };
      };

      bar.default = {
        position = "bottom";
        color = "on_surface";
        background_opacity = 0.8;
        padding = 14;
        border_width = 0.0;
        radius = 0;
        widget_spacing = 8;
        margin_ends = 6;
        margin_edge = 6;
        reserve_space = true;
        thickness = 34;
        auto_hide = false;
        capsule = false;
        start = [
          "launcher"
          "workspaces"
          "noctalia/screen_recorder:recorder"
        ];
        center = [
          "media"
        ];
        end = [
          "tray"
          "network"
          "volume"
          "brightness"
          "bluetooth"
          "battery"
          "clock"
          "session"
        ];
      };

      control_center = {
        sidebar = "compact";
        sidebar_section = "compact";
        shortcuts = [
          { type = "wifi"; }
          { type = "bluetooth"; }
          { type = "notification"; }
          { type = "caffeine"; }
          { type = "clipboard"; }
          { type = "power_profile"; }
        ];
      };

      nightlight = {
        enabled = true;
        force = false;
        temperature_day = 5500;
        temperature_night = 3700;
      };

      calendar = {
        enabled = true;
      };

      lockscreen = {
        blurred_desktop = true;
      };

      lockscreen_widgets = {
        enabled = true;
        schema_version = 2;
        widget_order = [
          "lockscreen-login-box@eDP-1"
          "lockscreen-widget-0000000000000001"
          "lockscreen-widget-0000000000000002"
        ];
        grid = {
          cell_size = 64;
          major_interval = 4;
          visible = true; # Set to false once you finish positioning items so you don't see the grid lines
        };
        widget = {
          "lockscreen-login-box@eDP-1" = {
            type = "login_box";
            output = "eDP-1"; # Corrected target
            cx = 853.5;
            cy = 981.5;
            box_width = 0.0;
            box_height = 0.0;
            rotation = 0.0;
            enabled = true;
          };
          lockscreen-widget-0000000000000001 = {
            type = "fancy_audio_visualizer";
            output = "eDP-1";
            cx = 853.5;
            cy = 789.5;
            box_width = 192.0;
            box_height = 192.0;
            rotation = 0.0;
            enabled = true;
            settings.background = false;
          };
          lockscreen-widget-0000000000000002 = {
            type = "sticker";
            output = "eDP-1";
            cx = 853.5;
            cy = 533.5;
            box_width = 0.0;
            box_height = 0.0;
            rotation = 0.0;
            enabled = true;
            settings = {
              background = false;
              # image_path = "${self}/Pictures/Wallpapers/Elden_Ring_Logo.png";
              opacity = 1.0;
            };
          };
        };
      };

      notification = {
        enable_daemon = true;
        position = "top_right";
        layer = "overlay";
        background_opacity = 0.5;
      };

      osd = {
        position = "center_right";
        orientation = "vertical";
        background_opacity = 0.5;
      };

      audio = {
        enable_overdrive = false;
        enable_sounds = false;
      };

      system.monitor = {
        enabled = true;
        cpu_poll_seconds = 1.0;
        gpu_poll_seconds = 3.0;
        memory_poll_seconds = 1.0;
        network_poll_seconds = 1.0;
        disk_poll_seconds = 30.0;
        cpu_usage_activity_threshold = 80.0;
        cpu_usage_critical_threshold = 90.0;
        cpu_temp_activity_threshold = 80.0;
        cpu_temp_critical_threshold = 90.0;
        gpu_temp_activity_threshold = 80.0;
        gpu_temp_critical_threshold = 90.0;
        gpu_usage_activity_threshold = 80.0;
        gpu_usage_critical_threshold = 90.0;
        ram_pct_activity_threshold = 80.0;
        ram_pct_critical_threshold = 90.0;
        swap_pct_activity_threshold = 80.0;
        swap_pct_critical_threshold = 90.0;
        disk_pct_activity_threshold = 80.0;
        disk_pct_critical_threshold = 90.0;
      };

      desktop_widgets.enabled = false;

      plugins.enabled = [ "noctalia/screen_recorder" ];

      plugin_settings."noctalia/screen_recorder" = {
        video_source = "portal";
        filename_pattern = "recording_%Y%m%d_%H%M%S";
        frame_rate = 60;
        video_codec = "h264";
        quality = "very_high";
        resolution = "original";
        audio_source = "default_output";
        audio_codec = "opus";
        show_cursor = true;
        color_range = "limited";
        copy_to_clipboard = true;
        hide_inactive = true;
      };
    };
  };
}
