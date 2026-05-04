{ self, inputs, ... }:
let
  inherit (inputs.nixos-generators) nixosGenerate;
in
{
  perSystem =
    { system, pkgs, ... }:
    {
      packages = {
        installer = nixosGenerate {
          inherit system;
          specialArgs = { inherit self inputs; };

          format = "install-iso";

          modules = [
            {
              isoImage.squashfsCompression = "gzip -Xcompression-level 1";

              boot.kernelParams = [ "copytoram" ];

              nix.settings.experimental-features = "nix-command flakes";

              environment.systemPackages = with pkgs; [
                git
                disko
                neovim
              ];
            }
          ];
        };
      };
    };
}
