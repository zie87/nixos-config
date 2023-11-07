{ config, pkgs, hyprland, lib, ... }:
with lib;
with builtins; let
  cfg = config.desktop;
in {
  config = mkIf (cfg.environment == "hyprland") {
    programs = {
      hyprland = {                            # Window Manager
        enable = true;
        xwayland = { 
          enable = true;
        };
      };
    };

    # Set session variables
    environment = {
      variables = {
        # If cursor is not visible, try to set this to "on".
        XDG_CURRENT_DESKTOP = "Hyprland";
        XDG_SESSION_TYPE = "wayland";
        XDG_SESSION_DESKTOP = "Hyprland";
      };
      sessionVariables = {
        QT_QPA_PLATFORM = "wayland";
        GDK_BACKEND = "wayland";
        WLR_NO_HARDWARE_CURSORS = "1";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";                     # Hint electron apps to use wayland
      };
    };

    services.xserver = {
      enable = true;
      layout = "de";
      xkbVariant = "nodeadkeys";
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gnome
      ];
    };

    security = {
      polkit.enable = true;
    };

    environment.systemPackages = with pkgs; [
        wofi
        dunst
        libnotify
        wl-clipboard    # Clipboard
        wlr-randr       # Monitor Settings
    ];

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
        };
      };
    };
  };
}
