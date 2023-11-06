# vim: set ft=make :

# build the flake
build:
	nixos-rebuild build --flake '.#desktop'

# update the version in the lock file
update:
	nix flake update

# switch to new system
switch: (build)
	sudo nixos-rebuild switch --flake '.#desktop'

