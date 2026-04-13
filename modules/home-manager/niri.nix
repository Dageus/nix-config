{ pkgs, ...}:
{
home.packages = with pkgs; [
fuzzel

# Hardcoding for nvim for now
go
nodejs
python3
cargo
gcc
gnumake

# some other tools
unzip
tree-sitter
wget
curl
gzip
gnutar
];
}
