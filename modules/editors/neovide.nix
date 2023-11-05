#
#  Neovide
#

{ pkgs, unstable, ... }:

{
  environment.systemPackages = [
    unstable.neovide
  ];
}
