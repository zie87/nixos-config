#
#  Terminal Emulator
#

{config, lib, pkgs, vars, ... }:

{
  home-manager.users.${vars.user} = {
    programs = {
      password-store = {
        enable = true;
        settings = {
          PASSWORD_STORE_DIR = "$HOME/.password-store";
        };
      };
    };
  };
}
