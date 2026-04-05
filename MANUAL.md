# NixOS Configuration

This is where I'll store my learning experience of Nix and all resources I'll need to learn it.

My Nix bible will be [https://nixos-and-flakes.thiscute.world/](https://nixos-and-flakes.thiscute.world/).

## Nix Language Guides

[nix.dev - Nix basics](https://nix.dev/tutorials/nix-language)

[NixCloud - A tour of Nix](https://nixcloud.io/tour/?id=introduction/nix)

[The official Nix language Manual](https://nix.dev/manual/nix/2.28/language/)

[Noogle - find Nix API references](https://noogle.dev/)

## Installation

[https://nixos.org/manual/nixos/stable/](https://nixos.org/manual/nixos/stable/)

In this house we opt for the minimal installation because we don't have infinite space on our computers or USBs.

### Partitioning the disk

parted /dev/sda -- mklabel gpt
parted /dev/sda -- mkpart primary 512MiB 100%
parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB
parted /dev/sda -- set 2 esp on


mkfs.ext4 /dev/sda1
mkfs.fat -F 32 /dev/sda2

mount /dev/sda1 /mnt
mkdir -p /mnt/boot
mount /dev/sda2 /mnt/boot


nixos-generate-config --root /mnt

## Configuration

The default configuration file for NixOS is located at `/etc/nixos/configuration.nix`. This includes ALL the settings for NixOS, including Time Zone, language, keyboard layout, etc.
