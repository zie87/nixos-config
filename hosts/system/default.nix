{ lib, pkgs, ...}:
with lib; 
{
  # Core pakages for system
  environment = with pkgs; {
    systemPackages = with pkgs; [           # System-Wide Packages
      coreutils         # GNU Utilities
      git               # Version Control
      killall           # Process Killer
      usbutils          # Manage USB
      wget              # Retriever
      curl              # Retriever
      file              # Show file types
    ];
  };

  imports = [
    ./desktop
    ./fonts.nix
  ];
}
