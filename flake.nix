{
  description = "Zie's NixOS Configuration";

  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";                     # Stable Nix Packages (Default)
      nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";         # Unstable Nix Packages

      home-manager = {                                                      # User Environment Manager
        url = "github:nix-community/home-manager/release-23.05";
        inputs.nixpkgs.follows = "nixpkgs";
      };
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, ... }: # Function telling flake which inputs to use
  let
    vars = {                                                              # Variables Used In Flake
      user = "zie";
      userDescription = "Tobias Zindl";
      location = "$HOME/.config/nixos-config";
      terminal = "kitty";
      editor = "nvim";
    };
  in
  {
    nixosConfigurations = (                                               # NixOS Configurations
      import ./hosts {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs nixpkgs-unstable home-manager vars;   # Inherit inputs
      }
    );
  };
}
