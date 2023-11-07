{lib, ...}:
with lib;
with builtins; {
  imports = [
    ./hyprland.nix
  ];
  options.desktop = {
    environment = mkOption {
      type = types.enum [
        "hyprland"
        "none"
      ];
      default = "none";
      description = "Desktop environment to use.";
    };
  };
}
