{
  perSystem =
    { config, pkgs, ... }:
    {
      formatter = pkgs.nixfmt;

      devShells.default = pkgs.callPackage ./. {
        inherit (config) formatter;
      };
    };
}
