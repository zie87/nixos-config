{
  wayland.windowManager.hyprland.extraConfig = ''
    # Window rules
    windowrule = float, ^(pavucontrol)$
    windowrule = float, ^(xdg-desktop-portal)$
    windowrule = float, ^(xdg-desktop-portal-gnome)$

    windowrule = float, title:^(ranger)$
    windowrule = float, title:^(btop)$
  '';
}
