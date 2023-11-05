#
# Brave 
#

{ pkgs, unstable, ... }:

{
  environment.systemPackages = [
    pkgs.brave
  ];
}
