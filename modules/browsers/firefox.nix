#
# Firefox 
#

{ pkgs, unstable, ... }:

{
  environment.systemPackages = [
    pkgs.firefox
  ];
}
