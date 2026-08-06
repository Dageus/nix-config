{ pkgs, ... }: {
  hm.home.packages = with pkgs; [
    duckstation
  ];
}
