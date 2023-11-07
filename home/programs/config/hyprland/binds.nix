{pkgs, ...}: let
  mainMod = "SUPER";

  # Dependencies
  wofi = "${pkgs.wofi}/bin/wofi";
  terminal = "${pkgs.alacritty}/bin/alacritty";
in {
  wayland.windowManager.hyprland.extraConfig = ''
    # Launchers
    bind = ${mainMod}, Return, exec, ${terminal}
    bind = ${mainMod}, D, exec, ${wofi} --show drun
    bind = ${mainMod}, R, exec, ${terminal} -t ranger -e ranger
    bind = ${mainMod}, B, exec, ${terminal} -t btop -e btm

    # Scratchpads
    bind = ${mainMod}, SPACE, togglespecialworkspace
    bind = ${mainMod} SHIFT, SPACE, movetoworkspace, special

    # Bindings
    bind = ${mainMod} SHIFT, Q, exit
    bind = ${mainMod}, F4, killactive
    bind = ${mainMod}, TAB, togglesplit
    bind = ${mainMod}, F, togglefloating
    bind = ${mainMod}, G, fullscreen
    bind = ${mainMod}, O, fakefullscreen

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = ${mainMod}, mouse:272, movewindow
    bindm = ${mainMod}, mouse:273, resizewindow

    # Move focus with mainMod + arrow keys
    bind = ${mainMod}, k, movefocus, u
    bind = ${mainMod}, j, movefocus, d
    bind = ${mainMod}, l, movefocus, r
    bind = ${mainMod}, h, movefocus, l

    # Switch workspaces with mainMod + [0-9]
    bind = ${mainMod}, left,  workspace, e-1
    bind = ${mainMod}, right, workspace, e+1
    bind = ${mainMod}, 1, workspace, 1
    bind = ${mainMod}, 2, workspace, 2
    bind = ${mainMod}, 3, workspace, 3
    bind = ${mainMod}, 4, workspace, 4
    bind = ${mainMod}, 5, workspace, 5
    bind = ${mainMod}, 6, workspace, 6
    bind = ${mainMod}, 7, workspace, 7
    bind = ${mainMod}, 8, workspace, 8
    bind = ${mainMod}, 9, workspace, 9
    bind = ${mainMod}, 0, workspace, 10

    # Window
    binde = ${mainMod} CTRL, k, resizeactive, 0 -20
    binde = ${mainMod} CTRL, j, resizeactive, 0 20
    binde = ${mainMod} CTRL, l, resizeactive, 20 0
    binde = ${mainMod} CTRL, h, resizeactive, -20 0
    binde = ${mainMod} ALT,  k, moveactive, 0 -20
    binde = ${mainMod} ALT,  j, moveactive, 0 20
    binde = ${mainMod} ALT,  l, moveactive, 20 0
    binde = ${mainMod} ALT,  h, moveactive, -20 0

    # Move active window to workspace
    bind = ${mainMod} SHIFT, right, movetoworkspace, e+1
    bind = ${mainMod} SHIFT, left,  movetoworkspace, e-1
    bind = ${mainMod} SHIFT, 1, movetoworkspace, 1
    bind = ${mainMod} SHIFT, 2, movetoworkspace, 2
    bind = ${mainMod} SHIFT, 3, movetoworkspace, 3
    bind = ${mainMod} SHIFT, 4, movetoworkspace, 4
    bind = ${mainMod} SHIFT, 5, movetoworkspace, 5
    bind = ${mainMod} SHIFT, 6, movetoworkspace, 6
    bind = ${mainMod} SHIFT, 7, movetoworkspace, 7
    bind = ${mainMod} SHIFT, 8, movetoworkspace, 8
    bind = ${mainMod} SHIFT, 9, movetoworkspace, 9
    bind = ${mainMod} SHIFT, 0, movetoworkspace, 10
  '';
}
