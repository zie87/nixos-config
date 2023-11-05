#
#  Terminal Emulator
#

{ pkgs, unstable, vars, ... }:

{
  home-manager.users.${vars.user} = {
    programs = {
      alacritty = {
        enable = true;
        package = unstable.alacritty;
      };
    };
  };
}
