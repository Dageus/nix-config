{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    go
    cargo
    rustc
    nodejs_20
    python3
    gcc
    gnumake

    ripgrep
    fd
    htop
    fzf
    bat
    unzip
    gzip
    gnutar
    tree-sitter
    curl

    # spotify
    spotify
  ];
}
