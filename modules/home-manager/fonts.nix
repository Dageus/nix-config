{ pkgs, ... }:
{
  config = {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      # "Code" fonts
      nerd-fonts.iosevka-term
      fira-code
      jetbrains-mono
      intel-one-mono

      # Nerd Font Symbols (Powerline, FontAwesome, MaterialIcons, etc)
      # https://www.nerdfonts.com/#features
      #  
      nerd-fonts.symbols-only

      # Emoji font 😀🙋🌟🎉
      noto-fonts-color-emoji
    ];
  };
}
