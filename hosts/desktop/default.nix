#
#  Specific system configuration settings forthreadripper 
#
#  flake.nix
#   ├─ ./hosts
#   │   ├─ default.nix
#   │   └─ ./desktop
#   │        ├─ default.nix *
#   │        └─ hardware-configuration.nix
#   └─ ./modules
#       └─ ./desktops
#           ├─ hyprland.nix
#           └─ ./virtualisation
#               └─ default.nix
#
#  NOTE: Dual booted with windows 11. Disable fast-boot in power plan and bios and turn off hibernate to get wifi and bluetooth working. This only works once but on reboot is borked again. So using the old school BLT dongle.
#

{ pkgs, unstable, ... }:

{
  imports = [ ./hardware-configuration.nix ] ++
            ( import ../../modules/desktops/virtualisation );

  boot = {                                      # Boot Options
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi = {
        canTouchEfiVariables = true;
      };
      timeout = 5;
    };
  };

  hardware = {
    opengl = {                                  # Hardware Accelerated Video
      enable = true;
    };
  };

  #hyprland.enable = true;                       # Window Manager

  environment = {
    sessionVariables = {
      # WLR_NO_HARDWARE_CURSORS = "1";          # If your cursor becomes invisible
      NIXOS_OZONE_WL = "1";                     # Hint electron apps to use wayland
    };
    systemPackages = with pkgs; [               # System-Wide Packages
      kitty
    ];
  };
}
