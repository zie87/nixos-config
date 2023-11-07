{ pkgs, unstable, vars, ... }:

{
  environment.systemPackages = [
    unstable.rustc      # rust compiler
    unstable.cargo      # rust package manager
  ];
}
