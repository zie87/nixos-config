{pkgs, ...}: let
  # Dependencies
  waybar = "${pkgs.waybar}/bin/waybar";
in {
  wayland.windowManager.hyprland.extraConfig = ''
    general {    
      gaps_in = 5
      gaps_out = 10
      border_size = 2
      col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
      col.inactive_border = rgba(595959aa)

      layout = dwindle
      resize_on_border = true
    }

    misc {
      force_default_wallpaper = 0 # Set to 0 to disable the anime mascot wallpapers
    }

    binds {
      allow_workspace_cycles = true
    }

    dwindle {
      pseudotile = yes
      preserve_split = yes
    }

    master {
      new_is_master = false
    }

    gestures {
      workspace_swipe = on
    }

    exec-once = ${waybar}
    exec-once = "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    exec-once = "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

    decoration {
      rounding = 10
      
      blur {
          enabled = true
          size = 3
          passes = 1
      }

      drop_shadow = yes
      shadow_range = 4
      shadow_render_power = 3
      col.shadow = rgba(1a1a1aee)
    }

    animations {
      enabled = yes
      bezier = myBezier, 0.05, 0.9, 0.1, 1.05
      
      animation = windows, 1, 7, myBezier
      animation = windowsOut, 1, 7, default, popin 80%
      animation = border, 1, 10, default
      animation = borderangle, 1, 8, default
      animation = fade, 1, 7, default
      animation = workspaces, 1, 6, default
    }
  '';
}
