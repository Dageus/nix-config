{ pkgs, ... }:
{
  config = {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      nerd-fonts.iosevka-term
      fira-code
      jetbrains-mono
      intel-one-mono

      nerd-fonts.symbols-only

      # Emoji font 😀🙋🌟🎉
      noto-fonts-color-emoji
    ];
  };
}
