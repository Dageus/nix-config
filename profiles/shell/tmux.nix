{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  inherit (lib)
    types
    mkOption
    mkIf
    getExe
    ;

  # Package Kanagawa directly from GitHub
  tmux-kanagawa = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-kanagawa";
    version = "master";
    src = pkgs.fetchFromGitHub {
      owner = "Nybkox";
      repo = "tmux-kanagawa";
      rev = "master"; # You can pin this to a specific commit hash later!
      hash = "sha256-jOcGNKb8QrIgT7l3D3RiJOPIC9JU1rOy8tk0x5ULrdc=";
    };
  };

  # Make a tmux plugin, with optional extraConfig
  mkPlugin =
    attrs:
    let
      plugin = pkgs.tmuxPlugins.mkTmuxPlugin attrs;
    in
    if (lib.hasAttr "extraConfig" attrs) then
      {
        inherit plugin;
        inherit (attrs) extraConfig;
      }
    else
      plugin;

  extraPlugins = map mkPlugin [
    {
      pluginName = "tmux-which-key";
      version = inputs.tmux-which-key.shortRev;
      src = inputs.tmux-which-key;
      rtpFilePath = "plugin.sh.tmux";
      extraConfig = ''
        # Use XDG config file for which-key plugin
        set -g @tmux-which-key-xdg-enable 1;
      '';
    }
  ];
in
{
  hm.programs.tmux = {
    enable = true;

    prefix = "C-Space";
    baseIndex = 1;
    escapeTime = 10; # Prevent Esc delay
    mouse = true;
    clock24 = true;
    keyMode = "vi";
    newSession = true; # Spawn when failing to attach
    historyLimit = 10000;

    shell = getExe pkgs.zsh; # Use zsh
    terminal = "tmux-256color"; # Enable 256bit color

    extraConfig = ''
      set-option -sa terminal-features ',xterm-256color:RGB'
      set-option -g focus-events on
      set-option -g status-position bottom
    '';

    plugins =
      with pkgs.tmuxPlugins;
      [
        sensible
        yank
        continuum
        copycat
        open
        vim-tmux-navigator

        # Resurrect plugin with its specific config attached
        {
          plugin = resurrect;
          extraConfig = ''
            set -g @resurrect-strategy-vim 'session'
            set -g @resurrect-strategy-nvim 'session'
          '';
        }

        # Your custom Kanagawa theme!
        {
          plugin = tmux-kanagawa;
          extraConfig = ''
            set -g @kanagawa-theme 'wave'
            set -g @kanagawa-ignore-window-colors true
            set -g @kanagawa-show-powerline true
            set -g @kanagawa-show-left-icon smiley
            set -g @kanagawa-border-contrast true
            set -g @kanagawa-show-empty-plugins false
            set -g @kanagawa-synchronize-panes-label "Sync"
            set -g @kanagawa-show-ssh-session-port true
            set -g @kanagawa-network-bandwidth "wlp2s0"
            set -g @kanagawa-git-disable-status false
            set -g @kanagawa-git-show-current-symbol ✓
            set -g @kanagawa-git-show-diff-symbol !
            set -g @kanagawa-day-month true
            set -g @kanagawa-show-timezone false
            set -g @kanagawa-military-time true
            set -g @kanagawa-ram-usage-label "RAM"
          '';
        }
      ]
      ++ extraPlugins;
  };

  hm.xdg.configFile = {
    "tmux/plugins/tmux-which-key/config.yaml".source = pkgs.writers.writeYAML "tmux-which-key-config" {
      command_alias_start_index = 200;
    };
  };
}
