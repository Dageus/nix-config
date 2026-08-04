# Nix Guide

## Useful commands

### Clean up cache/garbage

Deletes anything in `/nix/store` that isn't reachable from a GC root (a current generation, a pinned profile, etc.).

This is the single most useful command for reclaiming disk space.

```bash
nix-collect-garbage
```

Also delete old **user** profile generations while collecting garbage 
(without this, old generations stay around as GC roots, so nothing they reference gets freed):

```bash
nix-collect-garbage -d
```

System-wide (NixOS) garbage collection, including old **system** generations (needs root):

```bash
sudo nix-collect-garbage -d
```

Check how much space `/nix/store` is actually using, before/after cleaning:

```bash
du -sh /nix/store
```

### Prune previous generations

Delete generations older than a given age (works for both `nix-collect-garbage` and profile-scoped commands):

```bash
sudo nix-collect-garbage --delete-older-than 14d
```

or, for the new unified CLI (requires `nix-command` + `flakes` experimental features):

```bash
nix profile wipe-history --older-than 14d
```

List your NixOS system generations (useful before deciding what to prune, or to find a generation to roll back to):

```bash
sudo nix-env -p /nix/var/nix/profiles/system --list-generations
```

Delete all generations except the current one:

```bash
sudo nix-env -p /nix/var/nix/profiles/system --delete-generations old
```

Keep only the last N generations (e.g. keep 5, delete the rest):

```bash
sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +5
```

If you use **home-manager**, it keeps its own separate set of generations:

```bash
home-manager generations
home-manager expire-generations "-14 days"
```

> ⚠️ After deleting generations, the store paths they referenced are only actually removed once you run `nix-collect-garbage` (or `nix store gc`) again — deleting a generation just removes it as a GC root.

### Roll back to a previous generation

If a rebuild breaks something and you haven't rebooted yet:

```bash
sudo nixos-rebuild switch --rollback
```

Or switch to a specific past generation directly:

```bash
sudo /nix/var/nix/profiles/system-<N>-link/bin/switch-to-configuration switch
```

(You can also just reboot and pick an older generation from the boot menu — NixOS adds one entry per generation automatically.)

### Optimise the store (deduplicate identical files)

Nix store paths are content-addressed but not automatically deduplicated at the filesystem level. `optimise` hard-links identical files across different store paths, which can save a meaningful amount of space:

```bash
nix-store --optimise
```

or, with the newer CLI:

```bash
nix store optimise
```

You can also make this automatic so you never have to think about it (add to your NixOS configuration):

```nix
nix.settings.auto-optimise-store = true;
```

### Automate garbage collection

Instead of remembering to run cleanup commands manually, let NixOS do it on a schedule:

```nix
nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 14d";
};
```

### Inspect what's taking up space

See the closure size of a specific derivation or the current system (`-S` shows size, `-h` makes it human-readable):

```bash
nix path-info -S -h /run/current-system
```

List everything a package/derivation depends on (its full closure):

```bash
nix-store --query --requisites /run/current-system
```

Find out *why* something depends on something else (great for tracking down an unexpectedly large dependency):

```bash
nix why-depends /run/current-system nixpkgs#ffmpeg
```

For a more visual, browsable breakdown, `ncdu` works fine directly on the store:

```bash
ncdu /nix/store
```

### Verify and repair the store

Check the store for corruption (e.g. after a crash or disk issue), and re-fetch/rebuild anything broken:

```bash
sudo nix-store --verify --check-contents --repair
```

## Flakes

Update all flake inputs to their latest revisions (rewrites `flake.lock`):

```bash
nix flake update
```

Update just one input, leaving the rest pinned:

```bash
nix flake lock --update-input nixpkgs
```

Show what a flake outputs (packages, NixOS configurations, dev shells, etc.):

```bash
nix flake show
```

Run the flake's checks (build tests, formatting checks, etc., if defined):

```bash
nix flake check
```

Show input revisions/metadata for the current lockfile:

```bash
nix flake metadata
```

## Rebuilding your system

```bash
sudo nixos-rebuild switch --flake .#<hostname>
```

Other useful subcommands in place of `switch`:

| Subcommand | Effect |
|---|---|
| `boot` | Builds and sets as default boot entry, but doesn't activate until reboot |
| `test` | Activates immediately, but won't persist after reboot |
| `build` | Just builds, doesn't activate or change the boot menu at all |
| `dry-build` | Shows what *would* be built/downloaded, without doing it |

## Searching for packages

```bash
nix search nixpkgs <name>
```

Or browse interactively at [search.nixos.org](https://search.nixos.org/packages).

## Temporary environments (without installing anything permanently)

Drop into a shell with a package available just for that session:

```bash
nix shell nixpkgs#<package>
```

Enter a flake's declared development shell (if the project defines one via `devShells`):

```bash
nix develop
```

Older-style equivalent, useful for one-off ad-hoc packages:

```bash
nix-shell -p <package>
```

## System info & debugging

Current NixOS version:

```bash
nixos-version
```

Dump general Nix environment info (useful when asking for help / filing issues):

```bash
nix-info -m
```

Show effective Nix configuration (all settings currently in force):

```bash
nix show-config
```

Look up the value/description of a specific NixOS option:

```bash
nixos-option <option.path>
```
