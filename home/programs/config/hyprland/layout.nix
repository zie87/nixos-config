{...}: 
{
  wayland.windowManager.hyprland.extraConfig = ''
    input {
      kb_layout = us 
      #kb_variant = nodeadkeys
      kb_model =
      kb_options = caps:escape;
      kb_rules =

      follow_mouse = 1

      touchpad {
          natural_scroll = no
      }

      sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
    }
    '';
}
