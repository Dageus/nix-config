{ lib, ... }:
let
  /**
    List the children of `dir`.

    # Inputs
    `dir`: Directory to read

    # Type
    ```
    children :: path -> [path]
    ```
  */
  children =
    dir:
    let
      contents = builtins.readDir dir;

      # Helper to decide if a file/folder is actually a valid Nix module
      isValidModule =
        name: type:
        (type == "regular" && lib.hasSuffix ".nix" name)
        || (type == "directory" && builtins.pathExists (dir + "/${name}/default.nix"));
    in
    lib.pipe contents [
      (lib.filterAttrs isValidModule)
      builtins.attrNames
      (map (name: dir + "/${name}"))
    ];

  /**
    Wrap all files in `dir` as submodule imports.
    # Inputs
    `dir`: Directory to package as a module

    # Type
    ```
    wrap :: path -> AttrSet
    ```
  */
  wrap = dir: { imports = children dir; };
in
{
  flake = {
    nixosModules = {
      common = wrap ./common;
      nixos = wrap ./nixos;
    };

    homeModules = {
      common = wrap ./common;
      home = wrap ./home-manager;
    };
  };
}
