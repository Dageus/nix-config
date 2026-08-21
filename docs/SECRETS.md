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

Paste this public key into `.sops.yaml` under `keys:`, tagged with an anchor for the host (`&desktop`, `&laptop`, etc.) — see below.

## Common vs. host-specific secrets

Secrets live in `secrets/`:

```
secrets/
├── common.yaml           # readable by every host
├── desktop/secrets.yaml  # readable only by the `desktop` host
└── laptop/secrets.yaml   # readable only by the `laptop` host
```

Which key can decrypt which file is controlled by `.sops.yaml`'s `creation_rules`, matched by path:

```yaml
keys:
  - &laptop  age1...
  - &desktop age1...
creation_rules:
  - path_regex: secrets/[^/]+\.(yaml|json|env|ini)$   # secrets/common.yaml
    key_groups:
      - age: [*laptop, *desktop]
  - path_regex: secrets/laptop/[^/]+\.(yaml|json|env|ini)$
    key_groups:
      - age: [*laptop]
  - path_regex: secrets/desktop/[^/]+\.(yaml|json|env|ini)$
    key_groups:
      - age: [*desktop]
```

The desktop's key genuinely cannot decrypt `secrets/laptop/secrets.yaml`, and vice versa. `secrets/common.yaml` is decryptable by both.

## The `sops` module (`modules/nixos/sops.nix`)

Enabling `my.secrets.sops.enable = true` on a host wires up sops-nix and sets two things:

- `defaultSopsFile` — automatically points at that host's own `secrets/<hostname>/secrets.yaml`. Any secret declared without an explicit `sopsFile` goes here by default.
- `commonSopsFile` — a stable reference to `secrets/common.yaml`, exposed so profiles never have to hand-write a relative path like `../../secrets/common.yaml` (which breaks if the profile using it ever moves to a different directory depth).

Enable it once per host:

```nix
# hosts/desktop/default.nix
my.secrets.sops.enable = true;
```

## Declaring a secret where it's used

Secrets are declared directly in the profile that consumes them, not centralized in one big file. Most secrets are host-specific and need no `sopsFile` override at all:

```nix
# profiles/networking/networkmanager.nix
{ config, ... }:
{
  sops.secrets."wifi_password" = { };
  # -> decrypted from this host's own secrets/<hostname>/secrets.yaml
  # -> available at runtime as config.sops.secrets.wifi_password.path
}
```

For a secret shared across every host (an API token, a shared service password), point at the common file explicitly:

```nix
# profiles/services/some-service.nix
{ config, ... }:
{
  sops.secrets."shared_api_token" = {
    sopsFile = config.my.secrets.sops.commonSopsFile;
  };
}
```

### Useful per-secret options

```nix
sops.secrets."wifi_password" = {
  owner = "root";          # defaults to root
  group = "root";
  mode = "0400";
  restartUnits = [ "NetworkManager.service" ]; # restart this unit when the secret changes
};
```

### Referencing a secret's decrypted value

Secrets are decrypted to `/run/secrets/<name>` at activation. Reference the path (never the value directly, since Nix store paths are world-readable) via `config.sops.secrets.<name>.path`:

```nix
{ config, ... }:
{
  services.someService.passwordFile = config.sops.secrets."shared_api_token".path;
}
```

## Editing secrets

```bash
sops secrets/desktop/secrets.yaml   # opens $EDITOR, encrypts on save
sops secrets/common.yaml
```

If the file doesn't exist yet, `sops` creates it fresh (as long as `.sops.yaml` has a matching `creation_rules` entry for its path).

## Adding a new host

1. Generate an age key on the new host (or via SSH host key, if using `age.sshKeyPaths` instead).

2. Add its public key to `.sops.yaml` under `keys:`, and reference it in a `creation_rules` entry scoped to its own `secrets/<hostname>/` path.

3. If it should also read `secrets/common.yaml`, add it to that rule's `key_groups` too.

4. Re-encrypt existing files for the new key:

   ```bash
   sops updatekeys secrets/common.yaml
   ```
