#
#  Terminal Emulator
#

{ pkgs, unstable, vars, ... }:

{
  environment.systemPackages = [
    pkgs.fd                # find alternative
    pkgs.ripgrep           # grep alternative
    unstable.eza           # ls alternative
  ];

  home-manager.users.${vars.user} = {
    programs = {
      lf.enable = true;
      # eza.enable = true;
      bat.enable = true;
      # ripgrep.enable = true;
      tealdeer.enable = true;
      atuin = {
        enable = true;
        enableBashIntegration = true;
      };
      starship = {
        enable = true;
        enableBashIntegration = true;
      };
      zoxide = {
        enable = true;
        enableBashIntegration = true;
      };
      zellij = {
        enable = true;
        enableBashIntegration = true;
      };
      fzf = {
        enable = true;
        enableBashIntegration = true;
      };
    };
  };
}
