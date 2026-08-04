# Secrets

## sops-nix

### Create age key

I created my default keys in `~/.config/sops/age/keys.txt` using:

```bash
mkdir -p ~/.config/sops/age
age-keygen -o ~/.config/sops/age/keys.txt
```

### Make age key available to system

```bash
sudo mkdir -p /var/lib/sops-nix
sudo cp ~/.config/sops/age/keys.txt /var/lib/sops-nix/key.txt
sudo chmod 600 /var/lib/sops-nix/key.txt
```

### Print public key from age key

```bash
age-keygen -y ~/.config/sops/age/keys.txt
```
