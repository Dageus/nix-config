{
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia-shell = {
    enable = true;

    settings = {
      general = {
        radiusRatio = 1;
      };

      colors = {
        mOnPrimary = lib.mkForce config.lib.stylix.colors.withHashtag.base01;
      };

      location = {
        autoLocate = true;
      };

      ui = {
        boxBorderEnabled = false;
        panelBackgroundOpacity = lib.mkForce 0.55;
        panelsAttachedToBar = true;
        scrollbarAlwaysVisible = true;
        settingsPanelMode = "centered";
        settingsPanelSideBarCardStyle = false;
        tooltipsEnabled = true;
        translucentWidgets = true;
      };

      dock = {
        enabled = false;
        dockType = "attached";
        groupApps = true;
        indicatorOpacity = 0.6;
        indicatorThickness = 3;
        deadOpacity = 0.6;
        floatingRatio = 1;
        displayMode = "always_visible";
        pinnedApps = [ "kitty" ];
        position = "bottom";
        showDockIndicator = true;
        showLauncherIcon = true;
        sitOnFrame = false;
        size = 1.1;
      };

      audio = {
        visualizerType = "linear";
        volumeStep = 5;
        volumeOverdrive = true;
        volumeFeedback = false;
      };

      brightness = {
        backlightDeviceMappings = [ ];
        brightnessStep = 5;
        enableDdcSupport = false;
        enforceMinimum = true;
      };

      calendar = {
        cards = [
          {
            id = "calender-header-card";
            enabled = true;
          }
          {
            id = "calender-month-card";
            enabled = true;
          }
          {
            id = "weather-card";
            enabled = true;
          }
        ];
      };

      controlCenter = {
        cards = [
          {
            id = "profile-card";
            enabled = true;
          }
          {
            id = "shortcuts-card";
            enabled = true;
          }
          {
            id = "audio-card";
            enabled = true;
          }
          {
            id = "brightness-card";
            enabled = true;
          }
          {
            id = "weather-card";
            enabled = true;
          }
          {
            id = "media-sysmon-card";
            enabled = true;
          }
        ];

        diskPath = "/";
        position = "close_to_bar_button";
        shortcuts = [
          {
            left = [
              {
                id = "Network";
              }
              {
                id = "Bluetooth";
              }
              {
                id = "WallpaperSelector";
              }
            ];
            right = [
              {
                id = "Notifications";
              }
              {
                id = "PowerProfile";
              }
              {
                id = "KeepAwake";
              }
              {
                id = "NightLight";
              }
            ];
          }
        ];
      };

      appLauncher = {
        position = "center";
        sortByMostUsed = true;
        autoPasteClipboard = false;
        density = "default";
        viewMode = "list";
        enableClipPreview = true;
        enableClipboardChips = true;
        enableClipboardHistory = true;
        enableClipboardSmartIcons = true;
        enableSessionSearch = true;
        enableSettingsSearch = true;
        enableWindowsSearch = true;
        iconMode = "native";
        showCategories = true;
        showIconBackground = true;
        terminalCommand = "xterm -e";
      };

      bar = {
        # general
        position = "top";
        barType = "simple";
        frameRadius = 0;
        autoHideDelay = 500;
        autoShowDelay = 150;
        backgroundOpacity = lib.mkForce 0.0;
        # ---
        density = "default";
        showOnWorkspaceSwitch = true;
        showOutline = false;
        useSeparateOpacity = false;
        # capsules
        showCapsule = false;
        capsuleColorKey = "none";
        capsuleOpacity = lib.mkForce 0.65;
        contentPadding = 2;
        # mouse actions
        rightClickAction = "controlCenter";
        rightClickCommand = "";
        rightClickFollowMouse = true;
        mouseWheelAction = "none";
        mouseWheelWrap = true;
        middleClickAction = "none";
        middleClickCommand = "";
        middleClickFollowMouse = true;
        reverseScroll = false;
        # widgets
        widgetSpacing = 6;
        widgets = {
          left = [
            {
              id = "Workspace";
            }
            {
              id = "SystemMonitor";
            }
          ];
          center = [
            {
              id = "Clock";
            }
          ];
          right = [
            {
              id = "Tray";
            }
            {
              id = "Battery";
            }
            {
              id = "Volume";
            }
            {
              id = "NotificationHistory";
            }
          ];
        };
      };
    };
  };
}
