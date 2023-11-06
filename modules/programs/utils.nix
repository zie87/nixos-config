#
#  Terminal Emulator
#

{ pkgs, unstable, vars, ... }:

{
  environment.systemPackages = [
    pkgs.fd                # find alternative
    pkgs.ripgrep           # grep alternative
    unstable.eza           # ls alternative
    pkgs.imv              # image viewer
  ];

  home-manager.users.${vars.user} = {
    programs = {
      lf.enable = true;       # terminal file browser
      # eza.enable = true;
      bat.enable = true;      # cat alternative
      # ripgrep.enable = true;
      tealdeer.enable = true; # tldr front end
      # imv.enable = true;      # image viewer
      zathura.enable = true;  # pdf viewer
      atuin = {               # stores history as db
        enable = true;
        enableBashIntegration = true;
      };
      starship = {            # meta prompt
        enable = true;
        enableBashIntegration = true;
      };
      zoxide = {              # directory jumps
        enable = true;
        enableBashIntegration = true;
      };
      zellij = {              # terminal multiplexer
        enable = true;
        enableBashIntegration = true;
      };
      fzf = {                 # fuzzy finder
        enable = true;
        enableBashIntegration = true;
      };
    };
  };
}
