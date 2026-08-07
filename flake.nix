{
  description = "Dageus nix config";

  inputs = {
    systems.url = "path:./systems.nix";
    systems.flake = false;

    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    # NOTE: update every 6 months
    nixpkgs-stable = {
      url = "github:NixOS/nixpkgs/nixos-25.11";
    };

    "nixpkgs-24.11" = {
      # fprintd
      url = "github:NixOS/nixpkgs/nixos-24.11";
    };

    nixpkgs-master = {
      url = "github:NixOS/nixpkgs/master";
    };

    flake-compat.url = "github:NixOS/flake-compat";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # nix-github-actions = {
    #   url = "github:nix-community/nix-github-actions";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
    };

    # NOTE: too early for this
    # impermanence.url = "github:nix-community/impermanence";

    vicinae-extensions = {
      url = "github:vicinaehq/extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    delta = {
      url = "github:dandavison/delta";
      flake = false;
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tmux-which-key = {
      url = "github:alexwforsythe/tmux-which-key";
      flake = false;
    };

    umu-launcher = {
      url = "github:Open-Wine-Components/umu-launcher?dir=packaging/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    commit-lock-file-summary = "chore(flake): update inputs";
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://noctalia.cachix.org"
      "https://niri.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    ];
    # just for testing
    allow-import-from-derivation = true;
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      imports = [
        ./modules/flake-module.nix
        ./devshell/flake-module.nix
        ./hosts/flake-module.nix
        ./isos/flake-module.nix
      ];

      # Output a build matrix for CI
      # NOTE: later
      # flake.githubActions = inputs.nix-github-actions.lib.mkGithubMatrix {
      #   inherit (inputs.self) checks;
      # };

      # Allow inspecting flake-parts config in the repl
      # Adds the outputs debug.options, debug.config, etc
      debug = true;
    };
}
