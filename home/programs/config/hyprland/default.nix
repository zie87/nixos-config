{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./binds.nix
    ./hyprland.nix
    ./layout.nix
    ./monitors.nix
    ./rules.nix
    ./systemd-fixes.nix
  ];
  # Enable hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    systemd.enable = true;
  };

  # Fake a tray, so apps can start
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
    };
  };
}
