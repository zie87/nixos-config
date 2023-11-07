{ pkgs, unstable, vars, ... }:

{
  environment.systemPackages = [
    pkgs.gcc      # c/cpp compiler
  ];
}
