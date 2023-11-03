#
#  Terminal Emulator
#

{ pkgs, vars, ... }:

{
  home-manager.users.${vars.user} = {
    programs = {
      alacritty = {
        enable = true;
      };
    };
  };
}
