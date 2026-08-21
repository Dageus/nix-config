# Dageus' Nix Configuration

### Inspirations

- [MattSturgeon](https://github.com/MattSturgeon/nix-config)

- [diogotcorreia](https://github.com/diogotcorreia/dotfiles/)

## Roadmap

- Look into [Impermanence](https://nixos.wiki/wiki/Impermanence).

- Configure GPG Keys automatically in `modules/home-manager/gpg.nix`.

- Configure secrets using `agenix`.


## Installation

```
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./hosts/laptop/disks.nix

sudo nixos-install --flake .#laptop
```

### Dump hardware-configuration

```
nixos-generate-config --show-hardware-config > hosts/laptop/hardware-configuration.nix
```

## Rebuilding system

### Basic nix switch

```bash
sudo nixos-rebuild switch --flake .#<host>
```

### Booting

```bash
sudo nixos-rebuild boot --flake .#<host>
```
