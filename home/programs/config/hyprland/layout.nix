{...}: 
{
  wayland.windowManager.hyprland.extraConfig = ''
    input {
      kb_layout = de 
      kb_variant = nodeadkeys
      kb_model =
      kb_options =
      kb_rules =

      follow_mouse = 1

      touchpad {
          natural_scroll = no
      }

      sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
    }
    '';
}
