# vim: set ft=make :

user := "zie"
host := "fenrisulfr"

# build the flake
build:
	git -C . add --intent-to-add --all
	nixos-rebuild build --flake '.#{{host}}'
	home-manager build --flake '.#{{user}}@{{host}}'

# update the version in the lock file
update:
	nix flake update

# switch to new system
switch: (build)
	sudo nixos-rebuild switch --flake '.#{{host}}'
	home-manager switch --flake '.#{{user}}@{{host}}'

install_home_manger:
	nix run 'github:nix-community/home-manager#home-manager' -- switch --flake '.#{{user}}@{{host}}'

# run garbage collection
clear: 
	sudo nix-collect-garbage -d
	home-manager expire-generations "-5 days"
