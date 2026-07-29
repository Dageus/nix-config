{
  inputs,
  pkgs,
  config,
  ...
}:
{
  # Extension Configuration ==================================================
  sops.secrets."github_access_token" = {
    owner = config.my.user.name;
  };

  sops.templates."vicinae-secrets.json" = {
    content = builtins.toJSON {
      providers = {
        "@knoopx/vicinae-extension-github-0" = {
          preferences = {
            personalAccessToken = config.sops.placeholder."github_access_token";
            numberOfResults = "50";
            defaultIssueFilter = "my";
            defaultRepositoryFilter = "my";
          };
        };
      };
    };
    owner = config.my.user.name;
    mode = "0400";
  };

  hm.programs.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
    };

    # General Configuration ==================================================
    settings = {
      # Import extension configs
      imports = [ config.sops.templates."vicinae-secrets.json".path ];

      close_on_focus_loss = true;
      consider_preedit = true;
      pop_to_root_on_close = true;
      favicon_service = "google";
      search_files_in_root = true;
    };
    extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
      # bluetooth
      fuzzy-files
      github
      firefox
      nix
      niri
      noctalia-shell-wallpaper-selector
      power-profile
      process-manager
      wallhaven
    ];
  };
}
