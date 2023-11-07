{
  description = "Zie's NixOS Configuration";

  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";         # Unstable Nix Packages

      hyprland = {                                                          # Official Hyprland Flake
        url = "github:hyprwm/Hyprland"; 
        inputs.nixpkgs.follows = "nixpkgs";
      };

      home-manager = {                                                      # User Environment Manager
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
  };

  outputs = { self, nixpkgs, hyprland, home-manager, ... } @inputs: 
  let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    systems = ["x86_64-linux" "aarch64-linux"];
    forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs systems (system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });   
  in
  {
    inherit lib;
    devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});

    nixosConfigurations = {
      fenrisulfr = lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/configuration.nix
          ./hosts/users/fenrisulfr
        ];
      };
    };

    homeConfigurations = {
      "zie@fenrisulfr" = lib.homeManagerConfiguration {
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
          hidpi = true;
        };
        modules = [
          ./home/home.nix
        ];
      };
    };
  };
}
