{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pcsx2
  ];

  home.file = {
    "Games/Emulation/PS2/BIOS/.keep".text = "";
    "Games/Emulation/PS2/ROMs/.keep".text = "";
  };

  # 3. Pre-configure PCSX2 path targets so you don't have to hunt for them
  xdg.configFile."PCSX2/config/inis/PCSX2.ini".text = ''
    [Folders]
    Bios = ~/Games/Emulation/PS2/BIOS
    Snapshots = ~/Games/Emulation/PS2/Snapshots
    Savestates = ~/Games/Emulation/PS2/Savestates
    Cheats = ~/Games/Emulation/PS2/Cheats
    Games = ~/Games/Emulation/PS2/ROMs

    [EmuCore]
    EnableCheats = true
    EnableWideScreenPatches = true
  '';
}
