# Secrets

## sops-nix

I created my default keys in `~/.config/sops/age/keys.txt`.

But this depends on my user space. For it to exist on the system itself, independent of user, run:

```bash
sudo mkdir -p /var/lib/sops-nix
sudo cp ~/.config/sops/age/keys.txt /var/lib/sops-nix/key.txt
sudo chmod 600 /var/lib/sops-nix/key.txt
```


